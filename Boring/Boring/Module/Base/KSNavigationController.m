//
//  KSNavigationController.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSNavigationController.h"

@interface KSNavigationController ()

@end

@implementation KSNavigationController

+ (void)initialize
{
    if (self == [KSNavigationController class]) {
        UINavigationBar* bar = [UINavigationBar appearance];
        bar.barTintColor = [UIColor colorWithHex:@"222222"];
        bar.translucent = NO;
        bar.tintColor = [UIColor whiteColor];
        [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        UIBarButtonItem* item = [UIBarButtonItem appearance];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    }
}

@end
