//
//  KSTableShortCell.h
//  Boring
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//  幽默笑话

#import <UIKit/UIKit.h>

@class KSText;
@interface KSTableShortCell : UITableViewCell

@property (nonatomic, strong) KSText* text;

+ (CGFloat)heightForText:(KSText*)text withWidth:(CGFloat)width;

@end

UIKIT_EXTERN NSString * const KSTableShortCellID;

