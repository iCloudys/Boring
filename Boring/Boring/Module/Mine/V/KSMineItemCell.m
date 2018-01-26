//
//  KSMineItemCell.m
//  Boring
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSMineItemCell.h"
#import "KSMineItem.h"

@interface KSMineItemCell()
@property (nonatomic, strong) UILabel* itemLabel;
@property (nonatomic, strong) UIImageView* arrow_view;
@end

@implementation KSMineItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        
        self.itemLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.itemLabel];
        
        self.arrow_view = [[UIImageView alloc] init];
        self.arrow_view.image = [UIImage imageNamed:@"arrow_right"];
        [self.contentView addSubview:self.arrow_view];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    UIEdgeInsets layoutMargin = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat content_h = CGRectGetHeight(self.contentView.frame) - layoutMargin.top - layoutMargin.bottom;
    
    self.itemLabel.frame = CGRectMake(layoutMargin.left,
                                      layoutMargin.top,
                                      CGRectGetWidth(self.contentView.frame) - layoutMargin.left - layoutMargin.right,
                                      content_h);
    
    self.arrow_view.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - layoutMargin.right - 10,
                                       (CGRectGetHeight(self.contentView.frame) - 10) / 2,
                                       10,
                                       18);
}



- (void)setItem:(KSMineItem *)item{
    _item = item;
    self.itemLabel.text = item.text;
}

@end

NSString * const KSMineItemCellID = @"KSMineItemCellID";
