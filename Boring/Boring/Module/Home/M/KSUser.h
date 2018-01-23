//
//  KSUser.h
//  Boring
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSUser : NSObject

+ (instancetype)shared;

+ (BOOL)isLogin;

@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* cuid;
@property (nonatomic, copy) NSString* header;

@end
