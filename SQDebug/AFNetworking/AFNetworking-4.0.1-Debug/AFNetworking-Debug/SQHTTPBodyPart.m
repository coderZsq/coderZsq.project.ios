//
//  SQHTTPBodyPart.m
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/23.
//

#import "SQHTTPBodyPart.h"
#import <CoreServices/CoreServices.h>

NSString * SQCreateMultipartFormBoundary() {
    return [NSString stringWithFormat:@"Boundary+%08X%08X", arc4random(), arc4random()];
}

NSString * const kSQMultipartFormCRLF = @"\r\n";

inline NSString * SQMultipartFormInitialBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"--%@%@", boundary, kSQMultipartFormCRLF];
}

inline NSString * SQMultipartFormEncapsulationBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"%@--%@%@", kSQMultipartFormCRLF, boundary, kSQMultipartFormCRLF]; // 细节 boundary前后有两个换行
}

inline NSString * SQMultipartFormFinalBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"%@--%@--%@", kSQMultipartFormCRLF, boundary, kSQMultipartFormCRLF]; // 细节 boundary前后有两个换行
}

inline NSString * SQContentTypeForPathExtension(NSString *extension) {
    NSString *UTI = (__bridge_transfer NSString *)UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)extension, NULL);
    NSString *contentType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass((__bridge CFStringRef)UTI, kUTTagClassMIMEType);
    if (!contentType) {
        return @"application/octet-stream";
    } else {
        return contentType;
    }
}

typedef enum {
    SQEncapsulationBoundaryPhase = 1,
    SQHeaderPhase                = 2,
    SQBodyPhase                  = 3,
    SQFinalBoundaryPhase         = 4,
} SQHTTPBodyPartReadPhase;

@interface SQHTTPBodyPart () <NSCopying> {
    SQHTTPBodyPartReadPhase _phase;
    NSInputStream *_inputStram;
    unsigned long long _phaseReadOffset;
}

/**
 过度到下一个阶段
 */
- (BOOL)transitionToNextPhase;
- (NSInteger)readData:(NSData *)data intoBuffer:(uint8_t *)buffer maxLength:(NSUInteger)length;

@end

@implementation SQHTTPBodyPart

- (BOOL)transitionToNextPhase {
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self transitionToNextPhase];
        });
        return YES;
    }
    switch (_phase) {
        case SQEncapsulationBoundaryPhase:
            _phase = SQHeaderPhase;
            break;
        case SQHeaderPhase:
            [self.inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            [self.inputStream open];
            _phase = SQBodyPhase;
            break;
        case SQBodyPhase:
            [self.inputStream close];
            _phase = SQFinalBoundaryPhase;
            break;
        case SQFinalBoundaryPhase:
        default:
            _phase = SQEncapsulationBoundaryPhase;
            break;
    }
    _phaseReadOffset = 0;
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self transitionToNextPhase];
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    SQHTTPBodyPart *bodyPart = [[[self class] allocWithZone:zone] init];
    bodyPart.stringEncoding = self.stringEncoding;
    bodyPart.headers = self.headers;
    bodyPart.bodyContentLength = self.bodyContentLength;
    bodyPart.body = self.body;
    bodyPart.boundary = self.boundary;
    return bodyPart;
}

- (void)dealloc {
    if (_inputStram) {
        [_inputStram close];
        _inputStram = nil;
    }
}

- (NSInputStream *)inputStream {
    if (!_inputStram) {
        if ([self.body isKindOfClass:[NSData class]]) {
            _inputStram = [NSInputStream inputStreamWithData:self.body];
        } else if ([self.body isKindOfClass:[NSURL class]]) {
            _inputStram = [NSInputStream inputStreamWithURL:self.body];
        } else if ([self.body isKindOfClass:[NSInputStream class]]) {
            _inputStram = self.body;
        } else {
            _inputStram = [NSInputStream inputStreamWithData:[NSData data]];
        }
    }
    return _inputStram;
}

- (NSString *)stringForHeaders {
    NSMutableString *headerString = [NSMutableString string];
    for (NSString *field in [self.headers allKeys]) {
        [headerString appendString:[NSString stringWithFormat:@"%@: %@%@", field, [self.headers valueForKey:field], kSQMultipartFormCRLF]];
    }
    [headerString appendString:kSQMultipartFormCRLF]; // 最后多加一个换行
    return [NSString stringWithString:headerString];
}

- (unsigned long long)contentLength {
    unsigned long long length = 0;
    NSData *encapsulationBoundaryData = [([self hasInitialBoundary] ? SQMultipartFormInitialBoundary(self.boundary) : SQMultipartFormEncapsulationBoundary(self.boundary)) dataUsingEncoding:self.stringEncoding];
    length += [encapsulationBoundaryData length];
    
    NSData *headersData = [[self stringForHeaders] dataUsingEncoding:self.stringEncoding];
    length += [headersData length];
    
    length += _bodyContentLength;
    
    NSData *closingBoundaryData = ([self hasFinalBoundary] ? [SQMultipartFormFinalBoundary(self.boundary) dataUsingEncoding:self.stringEncoding] : [NSData data]);
    length += [closingBoundaryData length];
    return length;
}

- (BOOL)hasBytesAvailable {
    // 如果AFMultipartFormFinalBoundary不适合可用缓冲区，则允许再次调用read：maxLength：
    if (_phase == SQFinalBoundaryPhase) {
        return YES;
    }
    switch (self.inputStream.streamStatus) {
        case NSStreamStatusNotOpen:
        case NSStreamStatusOpening:
        case NSStreamStatusOpen:
        case NSStreamStatusReading:
        case NSStreamStatusWriting:
            return YES;
        case NSStreamStatusAtEnd:
        case NSStreamStatusClosed:
        case NSStreamStatusError:
        default:
            return NO;
    }
}

- (NSInteger)readData:(NSData *)data intoBuffer:(uint8_t *)buffer maxLength:(NSUInteger)length {
    NSRange range = NSMakeRange((NSUInteger)_phaseReadOffset, length);
    [data getBytes:buffer range:range];
    
    _phaseReadOffset += range.length;
    
    if (((NSUInteger)_phaseReadOffset) >= [data length]) {
        [self transitionToNextPhase];
    }
    return (NSInteger) range.length;
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)length {
    NSInteger totalNumberOfBytesRead = 0;
    if (_phase == SQEncapsulationBoundaryPhase) {
        NSData *encapsulationBoundaryData = [([self hasInitialBoundary] ? SQMultipartFormInitialBoundary(self.boundary) : SQMultipartFormEncapsulationBoundary(self.boundary)) dataUsingEncoding:self.stringEncoding];
        totalNumberOfBytesRead += [self readData:encapsulationBoundaryData intoBuffer:&buffer[totalNumberOfBytesRead] maxLength:length - (NSInteger)totalNumberOfBytesRead];
    }
    if (_phase == SQHeaderPhase) {
        NSData *headersData = [[self stringForHeaders] dataUsingEncoding:self.stringEncoding];
        totalNumberOfBytesRead += [self readData:headersData intoBuffer:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
    }
    if (_phase == SQBodyPhase) {
        NSInteger numberOfBytesRead = 0;
        numberOfBytesRead = [self.inputStream read:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
        if (numberOfBytesRead == -1) {
            return -1;
        } else {
            totalNumberOfBytesRead += numberOfBytesRead;
            if ([self.inputStream streamStatus] >= NSStreamStatusAtEnd) {
                [self transitionToNextPhase];
            }
        }
    }
    if (_phase == SQFinalBoundaryPhase) {
        NSData *closingBoundaryData = ([self hasFinalBoundary] ? [SQMultipartFormFinalBoundary(self.boundary) dataUsingEncoding:self.stringEncoding] : [NSData data]);
        totalNumberOfBytesRead += [self readData:closingBoundaryData intoBuffer:&buffer[totalNumberOfBytesRead] maxLength:(length - (NSUInteger)totalNumberOfBytesRead)];
    }
    return totalNumberOfBytesRead;
}

@end
