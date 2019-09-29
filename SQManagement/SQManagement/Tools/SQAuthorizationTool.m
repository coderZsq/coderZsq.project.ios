//
//  SQAuthorizationTool.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQAuthorizationTool.h"
#import <Contacts/Contacts.h>

@implementation SQAuthorizationTool

+ (void)fetchContacts:(void (^)(NSString *, NSArray *))callback {
    dispatch_async(dispatch_get_main_queue(), ^{
        CNContactStore *store = [[CNContactStore alloc] init];
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType: CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    NSLog(@"联系人授权成功");
                } else {
                    NSLog(@"联系人授权失败");
                }
            }];
        }
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactFamilyNameKey, CNContactGivenNameKey,CNContactPhoneNumbersKey]];
        [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            NSString *name = [contact.familyName stringByAppendingString:contact.givenName];
            NSMutableArray *phoneNumbers = @[].mutableCopy;
            for (CNLabeledValue *phoneNumber in contact.phoneNumbers) {
                CNPhoneNumber *phoneNumberValue = phoneNumber.value;
                [phoneNumbers addObject:phoneNumberValue.stringValue];
            }
            if (callback) {
                callback(name, phoneNumbers);
            }
        }];
    });
}

@end
