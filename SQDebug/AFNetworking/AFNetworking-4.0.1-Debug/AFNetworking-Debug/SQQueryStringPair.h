//
//  SQQueryStringPair.h
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/22.
//

#import <Foundation/Foundation.h>

NSString * SQQueryStringFromParameters(NSDictionary *parameters);

NSArray * SQQueryStringPairFromDictionary(NSDictionary *dictionary);

NSArray * SQQueryStringPairsFromKeyAndValue(NSString *key, id value);

@interface SQQueryStringPair : NSObject

@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;

@end
