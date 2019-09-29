//
//  SQAuthorizationManager.h
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/22.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQContact : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *namePrefix;
@property (nonatomic, copy) NSString *givenName;
@property (nonatomic, copy) NSString *middleName;
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, copy) NSString *previousFamilyName;
@property (nonatomic, copy) NSString *nameSuffix;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *organizationName;
@property (nonatomic, copy) NSString *departmentName;
@property (nonatomic, copy) NSString *jobTitle;
@property (nonatomic, copy) NSString *phoneticGivenName;
@property (nonatomic, copy) NSString *phoneticMiddleName;
@property (nonatomic, copy) NSString *phoneticFamilyName;
@property (nonatomic, copy) NSString *phoneticOrganizationName;
@property (nonatomic, strong) NSDateComponents *birthday;
@property (nonatomic, strong) NSDateComponents *nonGregorianBirthday;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSData *thumbnailImageData;
@property (nonatomic, assign) BOOL imageDataAvailable;
@property (nonatomic, strong) NSArray *phoneNumbers;
@property (nonatomic, strong) NSArray *emailAddresses;
@property (nonatomic, strong) NSArray *postalAddresses;
@property (nonatomic, strong) NSArray *dates;
@property (nonatomic, strong) NSArray *urlAddresses;
@property (nonatomic, strong) NSArray *contactRelations;
@property (nonatomic, strong) NSArray *socialProfiles;
@property (nonatomic, strong) NSArray *instantMessageAddresses;
@end

@interface SQAuthorizationTool : NSObject

+ (void)fetchContacts: (void(^)(NSArray *contacts))callback;

@end

NS_ASSUME_NONNULL_END
