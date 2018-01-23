//
//  KSTextManager.m
//  Boring
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSTextManager.h"
#import "KSText.h"
#import "KSCategory.h"

static KSTextManager* _manager;
static dispatch_once_t _onceToken;


@implementation KSTextManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone{return _manager;}

- (id)copyWithZone:(NSZone *)zone{return _manager;}

+ (instancetype)manager{
    dispatch_once(&_onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}

- (void)fetchTextWithCategory:(KSCategory *)category
                         page:(NSUInteger)page
                     complate:(KSFetchTextComplateHandle)complate{
    
    [Api getTextWithCategory:category
                        page:page
                    complate:^(NSArray<KSText *> *texts) {
                        complate(texts);
                    }];
}

@end
