//
//  KSFeedBackController.m
//  Boring
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSFeedBackController.h"

@interface KSFeedBackController ()<
UITextViewDelegate>
@property (nonatomic, strong) UILabel* contactLabel;
@property (nonatomic, strong) UILabel* bodyLabel;

@property (nonatomic, strong) UITextField* contactField;
@property (nonatomic, strong) UITextView* bodyTextView;

@property (nonatomic, strong) UIButton* submitButton;

@property (nonatomic, assign) NSUInteger maxLenght;
@end

@implementation KSFeedBackController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maxLenght = 140;
    
    self.navigationItem.title = @"意见反馈";
    
    self.contactLabel = [[UILabel alloc] init];
    self.contactLabel.textColor = [UIColor colorWithHex:@"333333"];
    self.contactLabel.font = [UIFont systemFontOfSize:13];
    self.contactLabel.text = @"联系方式";
    [self.view addSubview:self.contactLabel];
    
    self.bodyLabel = [[UILabel alloc] init];
    self.bodyLabel.text = @"你的意见(必填，140字以内)";
    self.bodyLabel.textColor = [UIColor colorWithHex:@"333333"];
    self.bodyLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:self.bodyLabel];
    
    self.contactField = [[UITextField alloc] init];
    self.contactField.font = [UIFont systemFontOfSize:13];
    self.contactField.backgroundColor = [UIColor whiteColor];
    self.contactField.layer.borderColor = SeparatorColor.CGColor;
    self.contactField.layer.borderWidth = SeparatorHeight;
    self.contactField.layer.cornerRadius = 4;
    self.contactField.placeholder = @"你的邮箱/QQ号";
    [self.view addSubview:self.contactField];
    
    self.bodyTextView = [[UITextView alloc] init];
    self.bodyTextView.font = [UIFont systemFontOfSize:13];
    self.bodyTextView.layer.borderColor = SeparatorColor.CGColor;
    self.bodyTextView.layer.borderWidth = SeparatorHeight;
    self.bodyTextView.layer.cornerRadius = 4;
    self.bodyTextView.delegate = self;
    [self.view addSubview:self.bodyTextView];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.submitButton.backgroundColor = ThemeColor;
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.submitButton.layer.cornerRadius = 4;
    self.submitButton.layer.masksToBounds = YES;
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIEdgeInsets layoutMargin = UIEdgeInsetsMake(20, 20, 20, 20);
    
    CGFloat width = CGRectGetWidth(self.view.bounds) - layoutMargin.left - layoutMargin.right;
    
    self.contactLabel.frame = CGRectMake(layoutMargin.left,
                                         layoutMargin.top,
                                         width,
                                         20);
    
    self.contactField.frame = CGRectMake(layoutMargin.left,
                                         CGRectGetMaxY(self.contactLabel.frame),
                                         width,
                                         30);
    
    self.bodyLabel.frame = CGRectMake(layoutMargin.left,
                                      CGRectGetMaxY(self.contactField.frame) + 20,
                                      width,
                                      20);
    
    self.bodyTextView.frame = CGRectMake(layoutMargin.left,
                                         CGRectGetMaxY(self.bodyLabel.frame),
                                         width,
                                         100);
    
    self.submitButton.frame = CGRectMake(layoutMargin.left,
                                         CGRectGetMaxY(self.bodyTextView.frame) + 30,
                                         width, 
                                         44);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > self.maxLenght) {
        textView.text = [textView.text substringToIndex:self.maxLenght];
    }
}

- (void)submit:(UIButton*)btn{
    
    [self.view endEditing:YES];
    
    NSString* body = self.bodyTextView.text;
    NSString* email = self.contactField.text;
    
    Weak(self);
    btn.userInteractionEnabled = NO;
    [Api submitFeedbackEmail:email
                     content:body
                    complate:^(BOOL success) {
                        btn.userInteractionEnabled = YES;
                        if (success) {
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [weak_self.navigationController popViewControllerAnimated:YES];
                            });
                        }
                    }];
}


@end
