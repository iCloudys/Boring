//
//  KSTableLongCell.h
//  Boring
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSText;
@interface KSTableLongCell : UITableViewCell

@property (nonatomic, strong) KSText* text;

+ (CGFloat)heightForText:(KSText*)text withWidth:(CGFloat)width;

@end

UIKIT_EXTERN NSString * const KSTableLongCellID;
