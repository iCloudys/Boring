//
//  KSUser.m
//  Boring
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSUser.h"

@implementation KSUser

static KSUser* _user;
static dispatch_once_t _onceToken;
+ (instancetype)shared{
    
    dispatch_once(&_onceToken, ^{
        _user = [[super allocWithZone:NULL] init];
    });
    return _user;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{return _user;}
- (id)copyWithZone:(NSZone *)zone{return _user;}

+ (BOOL)isLogin{
    return [KSUser shared].cuid != nil || [KSUser shared].cuid.length != 0;
}

@end
