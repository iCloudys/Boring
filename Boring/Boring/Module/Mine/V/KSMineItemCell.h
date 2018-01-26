//
//  KSMineItemCell.h
//  Boring
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSMineItem;

@interface KSMineItemCell : UITableViewCell

@property (nonatomic, strong) KSMineItem* item;

@end

UIKIT_EXTERN NSString * const KSMineItemCellID;
