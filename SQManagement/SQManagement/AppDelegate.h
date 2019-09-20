//
//  AppDelegate.h
//  SQManagement
//
//  Created by 朱双泉 on 2019/9/20.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

