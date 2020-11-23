//
//  SQHTTPBodyPart.h
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NSString * SQCreateMultipartFormBoundary(void);

NSString * SQMultipartFormInitialBoundary(NSString *boundary);

NSString * SQMultipartFormEncapsulationBoundary(NSString *boundary);

NSString * SQMultipartFormFinalBoundary(NSString *boundary);

NSString * SQContentTypeForPathExtension(NSString *extension);

@interface SQHTTPBodyPart : NSObject

@property (nonatomic, assign) NSStringEncoding stringEncoding;
@property (nonatomic, strong) NSDictionary *headers;
@property (nonatomic, copy) NSString *boundary;
@property (nonatomic, strong) id body;
@property (nonatomic, assign) unsigned long long bodyContentLength;
@property (nonatomic, assign) NSInputStream *inputStream;

@property (nonatomic, assign) BOOL hasInitialBoundary;
@property (nonatomic, assign) BOOL hasFinalBoundary;

@property (readonly, nonatomic, assign, getter=hasBytesAvailable) BOOL bytesAvailable;
@property (readonly, nonatomic, assign) unsigned long long contentLength;

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)length;

- (NSString *)stringForHeaders;

@end

NS_ASSUME_NONNULL_END
