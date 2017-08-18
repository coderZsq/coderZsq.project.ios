//
//  SQBuilder_iOS.m
//  SQBuilder
//
//  Created by 朱双泉 on 17/08/2017.
//  Copyright © 2017 Castie!. All rights reserved.
//

#import "SQBuilder_iOS.h"
#import "SQFileParser.h"

@implementation SQBuilder_iOS

- (void)build {
    
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [NSString stringWithFormat:@"/Users/%@/Desktop/%@", self.user, self.module];
    [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSMutableString * presenterFrag_h = @"".mutableCopy;
    NSMutableString * presenterFrag_m = @"".mutableCopy;
    NSMutableString * viewModelFrag_h = @"".mutableCopy;
    NSMutableString * viewModelFrag_m = @"".mutableCopy;
    NSMutableString * modelFrag = @"".mutableCopy;
    NSString * func = @"WithParameter:(NSDictionary *)parameter completion:(void(^)())completion";
    
    for (NSString * frag in self.actionList) {
        [presenterFrag_h appendFormat:@"- (void)%@%@;\n", frag, func];
        [presenterFrag_m appendFormat:@"- (void)%@%@ {\n\n    __weak typeof(self) _self = self;\n    __weak id<%@%@ViewModelInterface> __%@ViewModel = _%@ViewModel;\n    [_%@ViewModel %@WithParameter:parameter completion:^{\n        _self.%@View.%@ViewModel = __%@ViewModel;\n        completion();\n    }];\n}\n\n",
         frag, func, self.prefix, self.module, [self.module lowercaseString], [self.module lowercaseString], [self.module lowercaseString], frag, [self.module lowercaseString],[self.module lowercaseString],[self.module lowercaseString]];
        [viewModelFrag_h appendFormat:@"- (void)%@%@;\n", frag, func];
        [viewModelFrag_m appendFormat:@"- (void)%@%@ {\n\n}\n\n", frag, func];
    }
    
    [self.dataList enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull name, NSString *  _Nonnull datatype, BOOL * _Nonnull stop) {
        NSString * class = @"";
        NSString * modified = @"";
        if ([datatype caseInsensitiveCompare:@"String"] == NSOrderedSame) {
            class = @"NSString *"; modified = @"copy";
        } else if ([datatype caseInsensitiveCompare:@"Int"] == NSOrderedSame) {
            class = @"NSInteger"; modified = @"assign";
        } else if ([datatype caseInsensitiveCompare:@"Float"] == NSOrderedSame) {
            class = @"CGFloat"; modified = @"assign";
        } else if ([datatype caseInsensitiveCompare:@"Bool"] == NSOrderedSame) {
            class = @"BOOL"; modified = @"assign";
        } else if ([datatype caseInsensitiveCompare:@"Array"] == NSOrderedSame) {
            class = @"NSArray *"; modified = @"strong";
        } else if ([datatype caseInsensitiveCompare:@"Dictionary"] == NSOrderedSame) {
            class = @"NSDictionary *"; modified = @"strong";
        } else {
            class = [NSString stringWithFormat:@"%@ *", datatype]; modified = @"strong";
        }
        [modelFrag appendFormat:@"@property (nonatomic,%@) %@ %@;\n", modified, class, name];
    }];
    
    NSArray * filenames = @[@"Interface.h",
                            @"Model.h", @"Model.m",
                            @"View.h", @"View.m",
                            @"ViewModel.h", @"ViewModel.m",
                            @"Presenter.h", @"Presenter.m",
                            @"ViewController.h", @"ViewController.m"];
    
    NSString * header = [NSString stringWithFormat:@"%@%@",self.prefix, self.module];
    
    for (NSString * filename in filenames) {
        NSMutableArray * parameter = @[@{@"<#Root#>" : self.prefix},
                                       @{@"<#Unit#>" : self.module},
                                       @{@"<#unit#>" : [self.module lowercaseString]},
                                       @{@"<#ViewOperation#>" : presenterFrag_h},
                                       @{@"<#ViewOperation_m#>" : presenterFrag_m},
                                       @{@"<#ViewModelInterface#>" : viewModelFrag_h},
                                       @{@"<#ViewModelImplementation#>" : viewModelFrag_m},
                                       @{@"<#ModelInterface#>" : modelFrag}
                                       ].mutableCopy;
        [SQFileParser parser_ios_rw:path filename:filename header:header parameter:parameter];
    }
}

@end
