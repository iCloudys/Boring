//
//  KSTableShortCell.m
//  Boring
//
//  Created by Mac on 2018/1/20.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSTableShortCell.h"
#import "KSText.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface KSTableShortCell()

@property (nonatomic, strong) UIImageView* userHeader;
@property (nonatomic, strong) UILabel* userName;
@property (nonatomic, strong) UIButton* likeBtn;
@property (nonatomic, strong) UIButton* unLikebtn;
@property (nonatomic, strong) UIButton* commentBtn;
@property (nonatomic, strong) UIButton* starBtn;
@property (nonatomic, strong) UILabel* contentLabel;

@end

@implementation KSTableShortCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.separatorInset = UIEdgeInsetsZero;
        self.layoutMargins = UIEdgeInsetsZero;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfoAction:)];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userInfoAction:)];
        self.userHeader = [[UIImageView alloc] init];
        self.userHeader.layer.cornerRadius = UserNameHeight / 2;
        self.userHeader.layer.masksToBounds = YES;
        self.userHeader.userInteractionEnabled = YES;
        [self.userHeader addGestureRecognizer:tap1];
        [self.contentView addSubview:self.userHeader];
        
        self.userName = [[UILabel alloc] init];
        self.userName.font = UserNameFont;
        self.userName.textColor = UserNameColor;
        [self.userName addGestureRecognizer:tap2];
        self.userName.userInteractionEnabled = YES;
        [self.contentView addSubview:self.userName];
        
        self.likeBtn = [self factoryButton:@"like"
                                    action:@selector(likeButtonAction:)
                                    border:YES];
        
        self.unLikebtn = [self factoryButton:@"unlike"
                                      action:@selector(unLikeButtonAction:)
                                      border:YES];
        
        self.commentBtn = [self factoryButton:@"comment"
                                       action:@selector(commentButtonAction:)
                                       border:NO];
        
        self.starBtn = [self factoryButton:@"star"
                                    action:@selector(starButtonAction:)
                                    border:NO];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.contentView.frame) - LayoutMargins.left - LayoutMargins.right;
    
    self.userHeader.frame = CGRectMake(LayoutMargins.left,
                                       LayoutMargins.top,
                                       UserNameHeight,
                                       UserNameHeight);
    
    CGSize username_size = [self.userName sizeThatFits:CGSizeMake(MAXFLOAT, UserNameHeight)];
    
    self.userName.frame = CGRectMake(CGRectGetMaxX(self.userHeader.frame) + UserNameMargin.left,
                                     LayoutMargins.top,
                                     username_size.width,
                                     UserNameHeight);
    
    CGSize content_size = [self.contentLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    self.contentLabel.frame = CGRectMake(LayoutMargins.left,
                                         CGRectGetMaxY(self.userName.frame) + UserNameMargin.bottom,
                                         content_size.width,
                                         content_size.height);
    
    self.likeBtn.frame = CGRectMake(LayoutMargins.left,
                                    CGRectGetMaxY(self.contentLabel.frame) + LikeBtnTopMargin,
                                    LikeBtnSize.width,
                                    LikeBtnSize.height);
    self.unLikebtn.frame = CGRectMake(CGRectGetMaxX(self.likeBtn.frame) + LikeBtnInterItemSpacing,
                                      CGRectGetMinY(self.likeBtn.frame),
                                      LikeBtnSize.width,
                                      LikeBtnSize.height);
    
    self.starBtn.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - LayoutMargins.right - LikeBtnSize.width,
                                    CGRectGetMinY(self.likeBtn.frame),
                                    LikeBtnSize.width,
                                    LikeBtnSize.height);
    self.commentBtn.frame = CGRectMake(CGRectGetMinX(self.starBtn.frame) - LikeBtnSize.width - LikeBtnInterItemSpacing,
                                       CGRectGetMinY(self.likeBtn.frame),
                                       LikeBtnSize.width,
                                       LikeBtnSize.height);
    
}

///MARK:- Factory
- (UIButton*)factoryButton:(NSString*)imageName action:(SEL)action border:(BOOL)border{
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:LikeBtnTextColor forState:UIControlStateNormal];
    button.titleLabel.font = LikeBtnFont;
    
    if (border) {
        button.layer.borderColor = SeparatorColor.CGColor;
        button.layer.borderWidth = SeparatorHeight;
    }
    
    NSString* normalImageName = [NSString stringWithFormat:@"%@_normal",imageName];
    NSString* selectedImageName = [NSString stringWithFormat:@"%@_selected",imageName];
    [button setImage:[UIImage imageNamed:normalImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, LikeBtnTitleImageSpace, 0, -LikeBtnTitleImageSpace);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -LikeBtnTitleImageSpace, 0, LikeBtnTitleImageSpace);
        
    [button addTarget:self
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:button];
    return button;
}

///MARK:- Action
- (void)userInfoAction:(UITapGestureRecognizer*)tap{
    NSLog(@"点击用户");
}

- (void)likeButtonAction:(UIButton*)btn{
    
    if (btn.selected) {
        return;
    }
    
    Weak(btn);
    Weak(self);
    
    btn.userInteractionEnabled = NO;
    
    [Api likeText:self.text
         complate:^(BOOL success) {
             if (success) {
                 
                 weak_self.text.top = [@(weak_self.text.top.integerValue + 1) description];
                 [weak_btn setTitle:weak_self.text.top forState:UIControlStateNormal];
                 
                 weak_self.text.isLike = YES;
                 weak_btn.selected = YES;
             }
             weak_btn.userInteractionEnabled = YES;
         }];
}


- (void)unLikeButtonAction:(UIButton*)btn{
    
    if (btn.selected) {
        return;
    }
    
    Weak(btn);
    Weak(self);
    
    btn.userInteractionEnabled = NO;
    
    [Api unlikeText:self.text
         complate:^(BOOL success) {
             if (success) {
                 weak_self.text.down = [@(weak_self.text.down.integerValue + 1) description];
                 [weak_btn setTitle:weak_self.text.down forState:UIControlStateNormal];

                 weak_self.text.isUnlike = YES;
                 weak_btn.selected = YES;
             }
             weak_btn.userInteractionEnabled = YES;
         }];
}


- (void)starButtonAction:(UIButton*)btn{
    
    if (btn.selected) {
        return;
    }
    
    Weak(btn);
    Weak(self);
    
    btn.userInteractionEnabled = NO;
    
    [Api collectText:self.text
            complate:^(BOOL success) {
                if (success) {
                    weak_self.text.collect = [@(weak_self.text.collect.integerValue + 1) description];
                    [weak_btn setTitle:weak_self.text.collect forState:UIControlStateNormal];

                    weak_self.text.isCollect = YES;
                    weak_btn.selected = YES;
                }
                weak_btn.userInteractionEnabled = YES;
            }];
}


- (void)commentButtonAction:(UIButton*)btn{
    NSLog(@"评论");
}
///MARK:-


- (void)setText:(KSText *)text{
    _text = text;
    
    self.userName.text = text.userName;
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:text.headUrl]];
    
    [self.likeBtn setTitle:text.top forState:UIControlStateNormal];
    [self.unLikebtn setTitle:text.down forState:UIControlStateNormal];
    [self.commentBtn setTitle:text.c_numbers forState:UIControlStateNormal];
    [self.starBtn setTitle:text.collect forState:UIControlStateNormal];
    
    self.likeBtn.selected = text.isLike;
    self.unLikebtn.selected = text.isUnlike;
    self.starBtn.selected = text.isCollect;
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = TextLineSpacing;
    
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    [attributes setObject:TextFont forKey:NSFontAttributeName];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    NSAttributedString* attributeString = [[NSAttributedString alloc] initWithString:text.content attributes:attributes];
    self.contentLabel.attributedText = attributeString;
    
}

+ (CGFloat)heightForText:(KSText *)text withWidth:(CGFloat)width{
    KSTableShortCell* cell = [[KSTableShortCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    cell.frame = CGRectMake(0, 0, width, 0);
    cell.text = text;
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    return CGRectGetMaxY(cell.likeBtn.frame) + LayoutMargins.bottom;
}

@end


NSString * const KSTableShortCellID = @"KSTableShortCellID";
