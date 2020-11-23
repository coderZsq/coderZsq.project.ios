//
//  SQURLRequestSerializationTest.m
//  AFNetworking-DebugTests
//
//  Created by 朱双泉 on 2020/11/23.
//

#import <XCTest/XCTest.h>
#import "SQQueryStringPair.h"
#import "SQHTTPBodyPart.h"

@interface SQQueryStringPairTest : XCTestCase

@end

@implementation SQQueryStringPairTest

- (void)setUp {
    NSLog(@"==================DEBUG==================");
}

- (void)tearDown {
    NSLog(@"==================DEBUG==================");
}

- (void)testStringPair {
    SQQueryStringPair *pair = [[SQQueryStringPair alloc] initWithField:@"a" value:@1];
    NSLog(@"%@", [pair URLEncodedStringValue]);
    // a=1
    
    SQQueryStringPair *pair2 = [[SQQueryStringPair alloc] initWithField:@"b" value:nil];
    NSLog(@"%@", [pair2 URLEncodedStringValue]);
    // b
    
    NSLog(@"%@", SQQueryStringPairsFromKeyAndValue(@"a", @1));
    /**
     (
         "a=1"
     )
     */
    
    NSLog(@"%@", SQQueryStringPairsFromKeyAndValue(@"a", @{@"b": @{@"c": @3}, @"d": @""}));
    /**
     (
         "a[b][c]=3",
         "a[d]="
     )
     */
    NSLog(@"%@", SQQueryStringPairsFromKeyAndValue(@"a", @[@"b", @{@"c": @3}, @"d"]));
    /**
     (
         "a[]=b",
         "a[][c]=3",
         "a[]=d"
     )
     */
    NSLog(@"%@", SQQueryStringPairFromDictionary(@{@"a": @{@"b": @{@"c": @3}, @"d": @""}}));
    /**
     (
         "a[b][c]=3",
         "a[d]="
     )
     */
    NSLog(@"%@", SQQueryStringFromParameters(@{@"a": @{@"b": @{@"c": @3}, @"d": @""}}));
    // a[b][c]=3&a[d]=
}

- (void)testHTTPBodyPart {
    NSString *boundary = SQCreateMultipartFormBoundary();
    NSLog(@"InitialBoundary: %@", SQMultipartFormInitialBoundary(boundary));
    // InitialBoundary: --Boundary+97E7F63434C35636
    NSLog(@"EncapsulationBoundary: %@", SQMultipartFormEncapsulationBoundary(boundary));
    // EncapsulationBoundary:
    // --Boundary+97E7F63434C35636
    //
    NSLog(@"FinalBoundary: %@", SQMultipartFormFinalBoundary(boundary));
    // FinalBoundary:
    // --Boundary+97E7F63434C35636--
    //
    NSLog(@"ContentType: %@", SQContentTypeForPathExtension(@"jpg"));
    // ContentType: image/jpeg
    NSLog(@"ContentType: %@", SQContentTypeForPathExtension(@"mp4"));
    // ContentType: video/mp4
    NSLog(@"ContentType: %@", SQContentTypeForPathExtension(@"zip"));
    // ContentType: application/zip

    SQHTTPBodyPart *bodyPart = [[SQHTTPBodyPart alloc] init];
    bodyPart.headers = @{
        @"accept": @"application/json, text/javascript, */*; q=0.01",
        @"accept-encoding": @"gzip, deflate, br",
        @"accept-language": @"en-US,en;q=0.9,zh;q=0.8",
        @"content-length": @"9",
        @"content-type": @"application/json; charset=UTF-8"
    };
    NSLog(@"%@", [bodyPart stringForHeaders]);
    
//     accept: application/json, text/javascript, */*; q=0.01
//     accept-language: en-US,en;q=0.9,zh;q=0.8
//     content-length: 9
//     accept-encoding: gzip, deflate, br
//     content-type: application/json; charset=UTF-8
//
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
