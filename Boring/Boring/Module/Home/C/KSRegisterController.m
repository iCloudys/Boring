//
//  KSRegisterController.m
//  Boring
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSRegisterController.h"


@interface KSRegisterController ()

@property (nonatomic, strong) UIView* userNameBackView;
@property (nonatomic, strong) UIView* passWordBackView;
@property (nonatomic, strong) UIView* identifyBackView;

@property (nonatomic, strong) UITextField* userNameField;
@property (nonatomic, strong) UITextField* passWordField;
@property (nonatomic, strong) UITextField* identifyField;

@property (nonatomic, strong) UIImageView* userNameIcon;
@property (nonatomic, strong) UIImageView* passWordIcon;
@property (nonatomic, strong) UIImageView* identifyIcon;

@property (nonatomic, strong) UIButton* registerButton;

@end

@implementation KSRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"注册";
    [self setupSubviews];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIEdgeInsets layoutMargin = UIEdgeInsetsMake(20, 20, 20, 20);
    
    CGFloat backView_space = 20;
    
    CGSize icon_size = CGSizeMake(21, 22);
    
    CGFloat textField_leftMargin = 10;
    
    CGSize backView_size = CGSizeMake(CGRectGetWidth(self.view.frame) - layoutMargin.left - layoutMargin.right, 44);
    
    
    {
        self.userNameBackView.frame = CGRectMake(layoutMargin.left,
                                                 layoutMargin.top,
                                                 backView_size.width,
                                                 backView_size.height);
        self.userNameIcon.frame = CGRectMake(10,
                                             (backView_size.height - icon_size.height) / 2,
                                             icon_size.width,
                                             icon_size.height);
        
        self.userNameField.frame = CGRectMake(CGRectGetMaxX(self.userNameIcon.frame) + textField_leftMargin,
                                              0,
                                              backView_size.width - CGRectGetMaxX(self.userNameIcon.frame) - textField_leftMargin,
                                              backView_size.height);
    }
    {
        self.passWordBackView.frame = CGRectMake(layoutMargin.left,
                                                 CGRectGetMaxY(self.userNameBackView.frame) + backView_space,
                                                 backView_size.width,
                                                 backView_size.height);
        self.passWordIcon.frame = CGRectMake(10,
                                             (backView_size.height - icon_size.height) / 2,
                                             icon_size.width,
                                             icon_size.height);
        
        self.passWordField.frame = CGRectMake(CGRectGetMaxX(self.passWordIcon.frame) + textField_leftMargin,
                                              0,
                                              backView_size.width - CGRectGetMaxX(self.passWordIcon.frame) - textField_leftMargin,
                                              backView_size.height);
    }
    {
        self.identifyBackView.frame = CGRectMake(layoutMargin.left,
                                                 CGRectGetMaxY(self.passWordBackView.frame) + backView_space,
                                                 backView_size.width,
                                                 backView_size.height);
        self.identifyIcon.frame = CGRectMake(10,
                                             (backView_size.height - icon_size.height) / 2,
                                             icon_size.width,
                                             icon_size.height);
        
        self.identifyField.frame = CGRectMake(CGRectGetMaxX(self.identifyIcon.frame) + textField_leftMargin,
                                              0,
                                              backView_size.width - CGRectGetMaxX(self.identifyIcon.frame) - textField_leftMargin,
                                              backView_size.height);
    }
    {
        self.registerButton.frame = CGRectMake(layoutMargin.left,
                                            CGRectGetMaxY(self.identifyBackView.frame) + backView_space * 2,
                                            backView_size.width,
                                            backView_size.height);
    }
}

- (void)setupSubviews{
    {
        self.userNameBackView = [[UIView alloc] init];
        self.userNameBackView.layer.borderColor = SeparatorColor.CGColor;
        self.userNameBackView.layer.borderWidth = SeparatorHeight;
        [self.view addSubview:self.userNameBackView];
        
        self.userNameIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"username"]];
        [self.userNameBackView addSubview:self.userNameIcon];
        
        self.userNameField = [[UITextField alloc] init];
        self.userNameField.placeholder = @"请输入账号";
        self.userNameField.textColor = [UIColor colorWithHex:@"969696"];
        self.userNameField.font = [UIFont systemFontOfSize:14];
        self.userNameField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.userNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.userNameBackView addSubview:self.userNameField];
    }
    {
        self.passWordBackView = [[UIView alloc] init];
        self.passWordBackView.layer.borderColor = SeparatorColor.CGColor;
        self.passWordBackView.layer.borderWidth = SeparatorHeight;
        [self.view addSubview:self.passWordBackView];
        
        self.passWordIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        [self.passWordBackView addSubview:self.passWordIcon];
        
        self.passWordField = [[UITextField alloc] init];
        self.passWordField.placeholder = @"请输入密码";
        self.passWordField.textColor = self.userNameField.textColor;
        self.passWordField.font = self.userNameField.font;
        self.passWordField.secureTextEntry = YES;
        [self.passWordBackView addSubview:self.passWordField];
    }
    {
        self.identifyBackView = [[UIView alloc] init];
        self.identifyBackView.layer.borderColor = SeparatorColor.CGColor;
        self.identifyBackView.layer.borderWidth = SeparatorHeight;
        [self.view addSubview:self.identifyBackView];
        
        self.identifyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
        [self.identifyBackView addSubview:self.identifyIcon];
        
        self.identifyField = [[UITextField alloc] init];
        self.identifyField.placeholder = @"请再次输入密码";
        self.identifyField.textColor = self.userNameField.textColor;
        self.identifyField.font = self.userNameField.font;
        self.identifyField.secureTextEntry = YES;
        [self.identifyBackView addSubview:self.identifyField];
    }
    {
        self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.registerButton setTitle:@"注 册" forState:UIControlStateNormal];
        self.registerButton.titleLabel.font = [UIFont systemFontOfSize:17];
        self.registerButton.backgroundColor = ThemeColor;
        [self.registerButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.registerButton];
    }
}

///MARK:- Action
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)loginAction:(UIButton*)login{
    [self.view endEditing:YES];
    
    //登录
    NSString* username = self.userNameField.text;
    NSString* password = self.passWordField.text;
    NSString* identifity = self.identifyField.text;
    
    Weak(self);
    [Api registe:username
        password:password
      repassword:identifity
        complate:^(BOOL success) {
            if (success) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weak_self.navigationController popViewControllerAnimated:YES];
                });
            }
        }];
    
}

- (void)loginSuccess{

}


@end
