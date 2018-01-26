//
//  KSMineHeaderCell.m
//  Boring
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSMineHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KSMineItem.h"

@interface KSMineHeaderCell()
@property (nonatomic, strong) UIImageView* picuterView;
@property (nonatomic, strong) UILabel* nameLabel;
@property (nonatomic, strong) UIImageView* arrow_view;

@end

@implementation KSMineHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        
        self.picuterView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.picuterView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
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
    
    self.picuterView.frame = CGRectMake(layoutMargin.top,
                                        layoutMargin.left,
                                        content_h ,
                                        content_h);
    
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.picuterView.frame) + 10,
                                      layoutMargin.top,
                                      300,
                                      content_h);
    
    self.arrow_view.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - layoutMargin.right - 10,
                                       (CGRectGetHeight(self.contentView.frame) - 10) / 2,
                                       10,
                                       18);
}

- (void)setItem:(KSMineItem *)item{
    _item = item;
    [self.picuterView sd_setImageWithURL:[NSURL URLWithString:item.header]];
    self.nameLabel.text = item.text;

}
@end

NSString * const KSMineHeaderCellID = @"KSMineHeaderCellID";
