//
//  KSTextManager.h
//  Boring
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KSText;
@class KSCategory;
typedef void(^KSFetchTextComplateHandle)(NSArray<KSText*>* texts);

@interface KSTextManager : NSObject

+ (instancetype)manager;

- (void)fetchTextWithCategory:(KSCategory*)category
                         page:(NSUInteger)page
                     complate:(KSFetchTextComplateHandle)complate;

@end
