//
//  SQAuthorizationTool.m
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQAuthorizationTool.h"
#import <Contacts/Contacts.h>

@implementation SQContact
@end

@implementation SQAuthorizationTool

+ (void)fetchContacts:(void (^)(NSArray * _Nonnull))callback{
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
        NSArray *keys = @[
            CNContactIdentifierKey,
            CNContactNamePrefixKey,
            CNContactGivenNameKey,
            CNContactMiddleNameKey,
            CNContactFamilyNameKey,
            CNContactPreviousFamilyNameKey,
            CNContactNameSuffixKey,
            CNContactNicknameKey,
            CNContactOrganizationNameKey,
            CNContactDepartmentNameKey,
            CNContactJobTitleKey,
            CNContactPhoneticGivenNameKey,
            CNContactPhoneticMiddleNameKey,
            CNContactPhoneticFamilyNameKey,
            CNContactPhoneticOrganizationNameKey,
            CNContactBirthdayKey,
            CNContactNonGregorianBirthdayKey,
            CNContactImageDataKey,
            CNContactThumbnailImageDataKey,
            CNContactImageDataAvailableKey,
            CNContactTypeKey,
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactPostalAddressesKey,
            CNContactDatesKey,
            CNContactUrlAddressesKey,
            CNContactRelationsKey,
            CNContactSocialProfilesKey,
            CNContactInstantMessageAddressesKey
        ];
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        NSMutableArray *array = [NSMutableArray array];
        [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
            SQContact *obj = [SQContact new];
            obj.identifier = contact.identifier;
            obj.namePrefix = contact.namePrefix;
            obj.givenName = contact.givenName;
            obj.middleName = contact.middleName;
            obj.familyName = contact.familyName;
            obj.previousFamilyName = contact.previousFamilyName;
            obj.nameSuffix = contact.nameSuffix;
            obj.nickname = contact.nickname;
            obj.organizationName = contact.organizationName;
            obj.departmentName = contact.departmentName;
            obj.jobTitle = contact.jobTitle;
            obj.phoneticGivenName = contact.phoneticGivenName;
            obj.phoneticMiddleName = contact.phoneticMiddleName;
            obj.phoneticFamilyName = contact.phoneticFamilyName;
            obj.phoneticOrganizationName = contact.phoneticOrganizationName;
            obj.birthday = contact.birthday;
            obj.nonGregorianBirthday = contact.nonGregorianBirthday;
            obj.imageData = contact.imageData;
            obj.thumbnailImageData = contact.thumbnailImageData;
            obj.imageDataAvailable = contact.imageDataAvailable;
            NSMutableArray *phoneNumbers = @[].mutableCopy;
            for (CNLabeledValue *phoneNumber in contact.phoneNumbers) {
                CNPhoneNumber *phoneNumberValue = phoneNumber.value;
                [phoneNumbers addObject:phoneNumberValue.stringValue];
            }
            obj.phoneNumbers = phoneNumbers;
            NSMutableArray *emailAddresses = @[].mutableCopy;
            for (CNLabeledValue *emailAddress in contact.emailAddresses) {
                [emailAddresses addObject:[CNLabeledValue localizedStringForLabel:emailAddress.label]];
            }
            obj.emailAddresses = emailAddresses;
            NSMutableArray *postalAddresses = @[].mutableCopy;
            for (CNLabeledValue *postalAddress in contact.postalAddresses) {
                NSString *label = [CNLabeledValue localizedStringForLabel:postalAddress.label];
                id detail = postalAddress.value;
                id country = [detail valueForKey:CNPostalAddressCountryKey];
                id state = [detail valueForKey:CNPostalAddressStateKey];
                id city = [detail valueForKey:CNPostalAddressCityKey];
                id street = [detail valueForKey:CNPostalAddressStreetKey];
                id code = [detail valueForKey:CNPostalAddressPostalCodeKey];
                [postalAddresses addObject:[NSString stringWithFormat:@"%@: 国家: %@, 省: %@, 城市: %@, 街道: %@, 邮编: %@", label, country, state, city, street, code]];
            }
            obj.postalAddresses = postalAddresses;
            NSMutableArray *dates = @[].mutableCopy;
            for (CNLabeledValue *date in contact.dates) {
                NSString *label = [CNLabeledValue localizedStringForLabel:date.label];
                id dateComponents = date.value;
                NSDate *value = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
                NSDateFormatter *dateFormatter = [NSDateFormatter new];
                dateFormatter.dateFormat = @"yyyy年MM月dd日 HH:mm:ss";
                [dates addObject:[NSString stringWithFormat:@"%@: %@", label, [dateFormatter stringFromDate:value]]];
            }
            obj.dates = dates;
            NSMutableArray *urlAddresses = @[].mutableCopy;
            for (CNLabeledValue *urlAddress in contact.urlAddresses) {
                [urlAddresses addObject:[CNLabeledValue localizedStringForLabel:urlAddress.label]];
            }
            obj.urlAddresses = urlAddresses;
            NSMutableArray *socialProfiles = @[].mutableCopy;
            for (CNLabeledValue *socialProfile in contact.socialProfiles) {
                [urlAddresses addObject:[CNLabeledValue localizedStringForLabel:socialProfile.label]];
            }
            obj.socialProfiles = socialProfiles;
            NSMutableArray *instantMessageAddresses = @[].mutableCopy;
            for (CNLabeledValue *instantMessageAddress in contact.instantMessageAddresses) {
                [instantMessageAddresses addObject:[CNLabeledValue localizedStringForLabel:instantMessageAddress.label]];
            }
            obj.socialProfiles = socialProfiles;
            obj.instantMessageAddresses = instantMessageAddresses;
            [array addObject:obj];
        }];
        if (callback) {
            callback(array);
        }
    });
}

@end
