//
//  KSConstant.h
//  Boring
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#ifndef KSConstant_h
#define KSConstant_h

#define UMengKey @"5a6fdcf6f43e4830ba0000c0"

#define Weak(obj) __weak typeof(obj) weak_##obj = obj

#define SeparatorColor [UIColor colorWithHex:@"C8C7CC"]
#define SeparatorHeight (1.0 / [UIScreen mainScreen].scale)

#define ThemeColor [UIColor colorWithHex:@"ed4040"]

//KSHomeController
#define menuViewHeight (40)
#define menuItemMargin (20)
#define menuTitleSizeNormal (14)
#define menuTitleSizeSelected (14)
#define menuTitleColorNormal [UIColor colorWithHex:@"222222"]
#define menuTitleColorSelected ThemeColor
#define menuViewBackgroundColor [UIColor colorWithHex:@"f2f2f5"]

//KSTableHumorCell
#define UserNameHeight (30)
#define UserNameFont [UIFont systemFontOfSize:16]
#define UserNameColor [UIColor colorWithHex:@"3f6792"]
#define UserNameMargin (UIEdgeInsetsMake(0, 10, 10, 0))
#define LikeBtnSize CGSizeMake(60, 30)
#define LikeBtnInterItemSpacing (15)
#define LikeBtnTopMargin (15)
#define LikeBtnTitleImageSpace (3)
#define LikeBtnFont [UIFont systemFontOfSize:12]
#define LikeBtnTextColor [UIColor lightGrayColor]
#define LayoutMargins (UIEdgeInsetsMake(15, 20, 15, 15))
#define TextLineSpacing (10)
#define TextFont [UIFont systemFontOfSize:16]


typedef NS_ENUM(NSUInteger, KSTextResType) {
    KSTextResShortType = 0,
    KSTextResLongType = 1,
};

#endif /* KSConstant_h */
