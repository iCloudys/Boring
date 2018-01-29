//
//  KSCollectCell.h
//  Boring
//
//  Created by Mac on 2018/1/29.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSText;
@interface KSCollectCell : UITableViewCell

@property (nonatomic, strong) KSText* text;

@end

UIKIT_EXTERN NSString * const KSCollectCellID;
