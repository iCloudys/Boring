//
//  Api.h
//  Boring
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSText;
@class KSCategory;
@interface Api : NSObject

+ (instancetype)api;

+ (void)getIdentifyCode:(void(^)(UIImage* code))complete;

+ (void)login:(NSString*)account
     password:(NSString*)password
      captcha:(NSString*)captcha
     complate:(void(^)(BOOL success))complate;

+ (void)getTextWithCategory:(KSCategory*)category
                       page:(NSUInteger)page
                   complate:(void(^)(NSArray<KSText*>* texts))complate;


+ (void)likeText:(KSText*)text
        complate:(void(^)(BOOL success))complate;


+ (void)unlikeText:(KSText *)text
          complate:(void(^)(BOOL success))complate;


+ (void)collectText:(KSText *)text
           complate:(void(^)(BOOL success))complate;

@end
