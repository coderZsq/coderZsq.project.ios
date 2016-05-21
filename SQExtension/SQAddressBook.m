//
//  SQAddressBook.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "SQAddressBook.h"
#import <AddressBook/AddressBook.h>

@implementation SQAddressBook

+ (void)requestAccessAddressBook {

    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSLog(@"允许访问");
        } else {
            NSLog(@"不允许访问");
        }
    });
    CFRelease(addressBook);
}

+ (void)selectContacts {

    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) return;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSArray * allPeopole = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    for (int i = 0; i < allPeopole.count; i++) {
        ABRecordRef record = (__bridge ABRecordRef)(allPeopole[i]);
        NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(record, kABPersonLastNameProperty));
        NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(record, kABPersonFirstNameProperty));
        NSLog(@"%@ %@", lastName, firstName);
    }
    CFRelease(addressBook);
}

+ (void)updateContacts {

    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) return;
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    NSArray * allPeopole = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
    ABRecordRef people = (__bridge ABRecordRef)(allPeopole[0]);
    CFStringRef lastName = (__bridge CFStringRef)@"";//modify value
    ABRecordSetValue(people, kABPersonLastNameProperty, lastName, NULL);
    
    ABAddressBookSave(addressBook, NULL);
}

+ (void)insertContacts {

    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) return;
    
    ABRecordRef people = ABPersonCreate();
    ABRecordSetValue(people, kABPersonLastNameProperty, (__bridge CFStringRef)@"", NULL);//modify value
    ABRecordSetValue(people, kABPersonFirstNameProperty, (__bridge CFStringRef)@"", NULL);//modify value
    
    ABMultiValueRef phone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phone, (__bridge CFStringRef)@"", kABPersonPhoneMainLabel, NULL);//modify value
    ABMultiValueAddValueAndLabel(phone, (__bridge CFStringRef)@"", kABPersonPhoneMobileLabel, NULL);//modify value
    ABMultiValueAddValueAndLabel(phone, (__bridge CFStringRef)@"", kABPersonPhoneIPhoneLabel, NULL);//modify value

    ABRecordSetValue(people, kABPersonPhoneProperty, phone, NULL);
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookAddRecord(addressBook, people, NULL);
    
    ABAddressBookSave(addressBook, NULL);
    
    CFRelease(phone);
    CFRelease(people);
    CFRelease(addressBook);
}

+ (void)deleteContacts {

    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) return;
    
    ABRecordRef people = ABPersonCreate();
    ABRecordSetValue(people, kABPersonLastNameProperty, (__bridge CFStringRef)@"", NULL);//modify value
    ABRecordSetValue(people, kABPersonFirstNameProperty, (__bridge CFStringRef)@"", NULL);//modify value
    
    ABMultiValueRef phone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    ABMultiValueAddValueAndLabel(phone, (__bridge CFStringRef)@"", kABPersonPhoneMainLabel, NULL);//modify value
    ABMultiValueAddValueAndLabel(phone, (__bridge CFStringRef)@"", kABPersonPhoneMobileLabel, NULL);//modify value
    ABMultiValueAddValueAndLabel(phone, (__bridge CFStringRef)@"", kABPersonPhoneIPhoneLabel, NULL);//modify value
    
    ABRecordSetValue(people, kABPersonPhoneProperty, phone, NULL);
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAddressBookRemoveRecord(addressBook, people, NULL);
    ABAddressBookSave(addressBook, NULL);
    
    CFRelease(phone);
    CFRelease(people);
    CFRelease(addressBook);
}

@end
