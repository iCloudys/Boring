//
//  KSCollectCell.m
//  Boring
//
//  Created by Mac on 2018/1/29.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSCollectCell.h"
#import "KSText.h"

@interface KSCollectCell()
@property (strong, nonatomic) UILabel *contentLabel;
@end

@implementation KSCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIEdgeInsets layoutMargin = UIEdgeInsetsMake(-10, -20, 20, 10);
        
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:self.contentView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.contentLabel
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1
                                                                constant:layoutMargin.top];
        
        NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.contentLabel
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1
                                                                 constant:layoutMargin.left];
        
        NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                 attribute:NSLayoutAttributeRight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentLabel
                                                                 attribute:NSLayoutAttributeRight
                                                                multiplier:1
                                                                  constant:layoutMargin.right];
        
        NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:self.contentView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.contentLabel
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1
                                                                   constant:layoutMargin.bottom];
        
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:self.contentLabel
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1
                                                                   constant:44];
        height.priority = UILayoutPriorityDefaultHigh;
        
        [NSLayoutConstraint activateConstraints:@[top,left,right,bottom,height]];
        
    }
    return self;
}

- (void)setText:(KSText *)text{
    _text = text;
    self.contentLabel.attributedText = self.text.attributeContent;
    
}

@end

NSString * const KSCollectCellID = @"KSCollectCellID";
