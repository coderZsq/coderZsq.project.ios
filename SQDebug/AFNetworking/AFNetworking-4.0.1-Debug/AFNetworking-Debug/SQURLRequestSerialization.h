//
//  SQURLRequestSerialization.h
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/22.
//

#import <Foundation/Foundation.h>

@interface SQURLRequestSerialization : NSObject

NSString * SQQueryStringFromParameters(NSDictionary *parameters);

NSArray * SQQueryStringPairFromDictionary(NSDictionary *dictionary);

NSArray * SQQueryStringPairsFromKeyAndValue(NSString *key, id value);

@end
