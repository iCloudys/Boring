//
//  AppDelegate.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "AppDelegate.h"
#import "KSHomeController.h"
#import "KSNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    KSHomeController* home = [[KSHomeController alloc] init];
    self.window.rootViewController = [[KSNavigationController alloc] initWithRootViewController:home];
    
    return YES;
}

@end
