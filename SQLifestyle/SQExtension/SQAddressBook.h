//
//  SQAddressBook.h
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQAddressBook : NSObject

+ (void)requestAccessAddressBook;

+ (void)selectContacts;

+ (void)updateContacts;

+ (void)insertContacts;

+ (void)deleteContacts;

@end
