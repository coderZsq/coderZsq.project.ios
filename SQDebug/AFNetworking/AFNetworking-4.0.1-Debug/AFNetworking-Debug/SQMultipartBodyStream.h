//
//  SQMultipartBodyStream.h
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SQHTTPBodyPart;

@interface SQMultipartBodyStream : NSInputStream <NSStreamDelegate>

@property (nonatomic, assign) NSUInteger numberOfBytesInPacket;
@property (nonatomic, assign) NSTimeInterval delay;
@property (nonatomic, strong) NSInputStream *inputStream;
@property (readonly, nonatomic, assign) unsigned long long contentLength;
@property (readonly, nonatomic, assign, getter=isEmpty) BOOL empty;

- (instancetype)initWithStringEncoding:(NSStringEncoding)encoding;
- (void)setInitialAndFinalBoundaries;
- (void)appendHTTPBodyPart:(SQHTTPBodyPart *)bodyPart;

@end

NS_ASSUME_NONNULL_END
