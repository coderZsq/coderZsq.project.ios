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
    
    __weak typeof(self) _self = self;
    
    NSFileManager * manager = [NSFileManager defaultManager];
    NSString * path = [NSString stringWithFormat:@"/Users/%@/Desktop/%@", self.user, self.module];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath:path error:nil];
    }
    [manager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    
    NSMutableString * initialize_property = @"".mutableCopy;
    NSMutableString * initialize_parameter = @"".mutableCopy;
    NSMutableString * initialize_interface = @"".mutableCopy;
    NSMutableString * initialize_assignment = @"".mutableCopy;
    [self.parameter enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull name, NSString *  _Nonnull datatype, BOOL * _Nonnull stop) {
        NSDictionary * property = [_self parserDataType:datatype];
        NSString * class = property[@"class"];
        NSString * modified = property[@"modified"];
        [initialize_property appendFormat:@"@property (nonatomic,%@) %@ %@;\n", modified, class, name];
        [initialize_parameter appendFormat:@"%@:_self.%@ ", name, name];
        [initialize_interface appendFormat:@"%@:(%@)%@ ", name, class, name];
        [initialize_assignment appendFormat:@"\n        _%@Presenter.%@ = _%@;", [_self.module lowercaseString], name, name];
    }];
    
    NSMutableString * presenterFrag_h = @"".mutableCopy;
    NSMutableString * presenterFrag_m = @"".mutableCopy;
    NSMutableString * viewModelFrag_h = @"".mutableCopy;
    NSMutableString * viewModelFrag_m = @"".mutableCopy;
    NSMutableString * modelFrag = @"".mutableCopy;    
    [self.actionList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString * frag = action[@"function"];
        NSMutableString * func = [NSMutableString stringWithFormat:@"WithModel:(id<%@%@ModelInterface>)model", _self.prefix, _self.module];
        NSMutableString * func_in_presenter = @"WithModel:model".mutableCopy;
        [action[@"parameter"] enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull name, NSString *  _Nonnull datatype, BOOL * _Nonnull stop) {
            NSDictionary * property = [_self parserDataType:datatype];
            NSString * class = property[@"class"];
            [func appendFormat:@" %@:(%@)%@",name, class,name];
            [func_in_presenter appendFormat:@" %@:%@", name, name];
        }];
        [func appendFormat:@" completion:(void(^)())completion"];
        
        [presenterFrag_h appendFormat:@"- (void)%@%@;\n", frag, func];
        [presenterFrag_m appendFormat:@"- (void)%@%@ {\n\n", frag, func];
        [presenterFrag_m appendFormat:@"    __weak typeof(self) _self = self;\n"];
        [presenterFrag_m appendFormat:@"    __weak id<%@%@ViewModelInterface> __%@ViewModel = _%@ViewModel;\n", _self.prefix, _self.module, [_self.module lowercaseString], [_self.module lowercaseString]];
        [presenterFrag_m appendFormat:@"    [_%@ViewModel %@%@ completion:^{\n", [_self.module lowercaseString], frag, func_in_presenter];
        [presenterFrag_m appendFormat:@"        _self.%@View.%@ViewModel = __%@ViewModel;\n", [_self.module lowercaseString],[_self.module lowercaseString],[self.module lowercaseString]];
        [presenterFrag_m appendFormat:@"        if (completion) {completion();}\n    }];\n}\n\n"];
        [viewModelFrag_h appendFormat:@"- (void)%@%@;\n", frag, func];
        [viewModelFrag_m appendFormat:@"- (void)%@%@ {\n\n}\n\n", frag, func];
    }];
    
    [self.dataList enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull name, NSString *  _Nonnull datatype, BOOL * _Nonnull stop) {
        NSDictionary * property = [_self parserDataType:datatype];
        NSString * class = property[@"class"];
        NSString * modified = property[@"modified"];
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
                                       @{@"<#ModelInterface#>" : modelFrag},
                                       @{@"<#InitializeProperty#>" : initialize_property},
                                       @{@"<#InitializeParameter#>" : initialize_parameter},
                                       @{@"<#InitializeInterface#>" : initialize_interface},
                                       @{@"<#InitializeAssignment#>" : initialize_assignment},
                                       ].mutableCopy;
        [SQFileParser parser_rw:path code:@"oc" filename:filename header:header parameter:parameter];
    }
}

- (NSDictionary *)parserDataType:(NSString *)datatype {

    NSString * class = @"";
    NSString * modified = @"";
    
    if ([self.prefix caseInsensitiveCompare:@"HY"] == NSOrderedSame) {
        if ([datatype caseInsensitiveCompare:@"HYString"] == NSOrderedSame) {
            class = @"NSString *"; modified = @"copy";
        } else if ([datatype caseInsensitiveCompare:@"HYInt"] == NSOrderedSame) {
            class = @"NSInteger"; modified = @"assign";
        } else if ([datatype caseInsensitiveCompare:@"HYboolean"] == NSOrderedSame) {
            class = @"BOOL"; modified = @"assign";
        } else if ([datatype containsString:@"HYModel"]) {
            NSString * temp1 = [[datatype componentsSeparatedByString:@"<"] lastObject];
            NSString * temp2 = [[temp1 componentsSeparatedByString:@">"] firstObject];
            class = [NSString stringWithFormat:@"%@ *", temp2]; modified = @"strong";
        } else if ([datatype containsString:@"HYList"]) {
            class = @"NSMutableArray *"; modified = @"strong";
        }
    } else {
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
    }
    return @{@"class" : class, @"modified" : modified};
}

@end
