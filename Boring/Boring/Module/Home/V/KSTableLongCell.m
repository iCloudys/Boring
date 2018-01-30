//
//  KSTableLongCell.m
//  Boring
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSTableLongCell.h"
#import "KSText.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface KSTableLongCell()

@property (nonatomic, strong) UIImageView* pictureView;
@property (nonatomic, strong) UILabel* contentLabel;

@end

@implementation KSTableLongCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.pictureView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.pictureView];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    UIEdgeInsets layoutMargin = UIEdgeInsetsMake(10, 10, 10, 10);
    
    CGFloat content_Height = CGRectGetHeight(self.contentView.frame) - layoutMargin.top - layoutMargin.bottom;
    
    if (self.text.picture.length > 0) {
        self.pictureView.frame = CGRectMake(layoutMargin.left,
                                            layoutMargin.top,
                                            content_Height * 1.5,
                                            content_Height);
        
        self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.pictureView.frame) + 10,
                                             layoutMargin.top,
                                             CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.pictureView.frame) - layoutMargin.left - layoutMargin.bottom - 10,
                                             content_Height);
        
    }else{
        self.pictureView.frame = CGRectMake(layoutMargin.left,
                                            layoutMargin.top,
                                            0,
                                            content_Height);
        
        self.contentLabel.frame = CGRectMake(CGRectGetMaxX(self.pictureView.frame),
                                             layoutMargin.top,
                                             CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.pictureView.frame) - layoutMargin.left - layoutMargin.bottom,
                                             content_Height);
    }
    
    
}

- (void)setText:(KSText *)text{
    _text = text;
    
    if (text.picture.length > 0) {
        [self.pictureView sd_setImageWithURL:[NSURL URLWithString:text.picture]];
    }else{
        self.pictureView.image = nil;
    }
    
    self.contentLabel.attributedText = text.attributeTitle;
    
}

+ (CGFloat)heightForText:(KSText*)text withWidth:(CGFloat)width{
    if (text.height == CGFLOAT_MIN) {
        if (text.picture.length == 0) {
            text.height = 60;
        }else{
            text.height = 90;
        }
    }
    return text.height;
}

@end

NSString * const KSTableLongCellID = @"KSTableLongCellID";
