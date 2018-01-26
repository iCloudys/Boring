//
//  KSViewController.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSViewController.h"

@interface KSViewController ()

@end

@implementation KSViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc{
    NSLog(@"dealloc:%@",self);
}

@end
