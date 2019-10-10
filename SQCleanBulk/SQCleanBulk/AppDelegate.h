//
//  AppDelegate.h
//  SQCleanBulk
//
//  Created by 朱双泉 on 2019/10/10.
//  Copyright © 2019 朱双泉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

