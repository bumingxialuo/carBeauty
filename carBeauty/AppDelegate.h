//
//  AppDelegate.h
//  carBeauty
//
//  Created by apple7 on 17/4/7.
//  Copyright © 2017年 apple7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;


- (void)saveContext;


@end

