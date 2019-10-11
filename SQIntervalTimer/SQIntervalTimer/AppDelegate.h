//
//  AppDelegate.h
//  SQIntervalTimer
//
//  Created by 朱双泉 on 2019/10/11.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

