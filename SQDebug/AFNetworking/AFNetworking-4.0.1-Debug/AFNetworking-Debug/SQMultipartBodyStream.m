//
//  SQMultipartBodyStream.m
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/25.
//

#import "SQMultipartBodyStream.h"
#import "SQHTTPBodyPart.h"

@interface NSStream ()
@property (readwrite) NSStreamStatus streamStatus;
@property (readwrite, copy) NSError *streamError;
@end

@interface SQMultipartBodyStream () <NSCopying>
@property (readwrite, nonatomic, assign) NSStringEncoding stringEncoding;
@property (readwrite, nonatomic, strong) NSMutableArray *HTTPBodyParts;
@property (readwrite, nonatomic, strong) NSEnumerator *HTTPBodyPartEnumerator;
@property (readwrite, nonatomic, strong) SQHTTPBodyPart *currentHTTPBodyPart;
@property (readwrite, nonatomic, strong) NSOutputStream *outputStream;
@property (readwrite, nonatomic, strong) NSMutableData *buffer;
@end

@implementation SQMultipartBodyStream

@synthesize delegate;
@synthesize streamStatus;
@synthesize streamError;

- (instancetype)initWithStringEncoding:(NSStringEncoding)encoding {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.stringEncoding = encoding;
    self.HTTPBodyParts = [NSMutableArray array];
    self.numberOfBytesInPacket = NSIntegerMax;
    return self;
}

- (void)setInitialAndFinalBoundaries {
    if ([self.HTTPBodyParts count] > 0) {
        for (SQHTTPBodyPart *bodyPart in self.HTTPBodyParts) {
            bodyPart.hasInitialBoundary = NO;
            bodyPart.hasFinalBoundary = NO;
        }
        [[self.HTTPBodyParts firstObject] setHasInitialBoundary:YES];
        [[self.HTTPBodyParts lastObject] setHasFinalBoundary:YES];
    }
}

- (void)appendHTTPBodyPart:(SQHTTPBodyPart *)bodyPart {
    [self.HTTPBodyParts addObject:bodyPart];
}

- (BOOL)isEmpty {
    return [self.HTTPBodyParts count] == 0;
}

#pragma mark - NSInputStream

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)length {
    if ([self streamStatus] == NSStreamStatusClosed) {
        return 0;
    }
    
    NSInteger totalNumberOfBytesRead = 0;
    
    while ((NSUInteger)totalNumberOfBytesRead < MIN(length, self.numberOfBytesInPacket)) {
        if (!self.currentHTTPBodyPart || ![self.currentHTTPBodyPart hasBytesAvailable]) {
            if (!(self.currentHTTPBodyPart = [self.HTTPBodyPartEnumerator nextObject])) {
                break;
            }
        } else {
            NSUInteger maxLength = MIN(length, self.numberOfBytesInPacket) - (NSUInteger)totalNumberOfBytesRead;
            NSInteger numberOfBytesRead = [self.currentHTTPBodyPart read:&buffer[totalNumberOfBytesRead] maxLength:maxLength];
            if (numberOfBytesRead == -1) {
                self.streamError = self.currentHTTPBodyPart.inputStream.streamError;
                break;
            } else {
                totalNumberOfBytesRead += numberOfBytesRead;
                if (self.delay > 0.0f) {
                    [NSThread sleepForTimeInterval:self.delay];
                }
            }
        }
    }
    return totalNumberOfBytesRead;
}

- (BOOL)getBuffer:(__unused uint8_t * _Nullable *)buffer length:(__unused NSUInteger *)len {
    return NO;
}

- (BOOL)hasBytesAvailable {
    return [self streamStatus] == NSStreamStatusOpen;
}

#pragma mark - NSStream

- (void)open {
    if (self.streamStatus == NSStreamStatusOpen) {
        return;
    }
    self.streamStatus = NSStreamStatusOpen;
    [self setInitialAndFinalBoundaries];
    self.HTTPBodyPartEnumerator = [self.HTTPBodyParts objectEnumerator];
}

- (void)close {
    self.streamStatus = NSStreamStatusClosed;
}

- (id)propertyForKey:(__unused NSStreamPropertyKey)key {
    return nil;
}

- (BOOL)setProperty:(__unused id)property forKey:(__unused NSStreamPropertyKey)key {
    return NO;
}

- (void)scheduleInRunLoop:(__unused NSRunLoop *)aRunLoop forMode:(__unused NSRunLoopMode)mode {
    
}

- (void)removeFromRunLoop:(__unused NSRunLoop *)aRunLoop forMode:(__unused NSRunLoopMode)mode {
    
}

- (unsigned long long)contentLength {
    unsigned long long length = 0;
    for (SQHTTPBodyPart *bodyPart in self.HTTPBodyParts) {
        length += [bodyPart contentLength];
    }
    return length;
}

#pragma mark - Undocumented CFReadStream Bridged Methods

- (void)_scheduleInCFRunLoop:(__unused CFRunLoopRef)aRunLoop forMode:(__unused CFStringRef)aMode {
    
}

- (void)_unscheduleFromCFRunLoop:(__unused CFRunLoopRef)aRunLoop forMode:(__unused CFStringRef)aMode {
    
}

- (BOOL)_setCFClientFlags:(__unused CFOptionFlags)inFlags callback:(__unused CFReadStreamClientCallBack)inCallback context:(__unused CFStreamClientContext *)inContext {
    return NO;
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
    SQMultipartBodyStream *bodyStreamCopy = [[[self class] allocWithZone:zone] initWithStringEncoding:self.stringEncoding];
    for (SQHTTPBodyPart *bodyPart in self.HTTPBodyParts) {
        [bodyStreamCopy appendHTTPBodyPart:[bodyPart copy]];
    }
    [bodyStreamCopy setInitialAndFinalBoundaries];
    return bodyStreamCopy;
}

@end
