//
//  KSLoginController.m
//  Boring
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSLoginController.h"
#import "KSNavigationController.h"
#import "KSMineController.h"
#import "KSRegisterController.h"

@interface KSLoginController ()

@property (nonatomic, copy) dispatch_block_t complete;

@property (nonatomic, strong) UIView* userNameBackView;
@property (nonatomic, strong) UIView* passWordBackView;
@property (nonatomic, strong) UIView* identifyBackView;

@property (nonatomic, strong) UITextField* userNameField;
@property (nonatomic, strong) UITextField* passWordField;
@property (nonatomic, strong) UITextField* identifyField;

@property (nonatomic, strong) UIImageView* userNameIcon;
@property (nonatomic, strong) UIImageView* passWordIcon;
@property (nonatomic, strong) UIImageView* identifyIcon;
@property (nonatomic, strong) UIButton* identifyView;
@property (nonatomic, strong) UIActivityIndicatorView* identifyIndicatorView;

@property (nonatomic, strong) UIButton* loginButton;
@property (nonatomic, strong) UIButton* registerButton;

@end

@implementation KSLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"个人账号登录";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelLoginAction:)];
    

    [self setupSubviews];
    
#if DEBUG
    self.userNameField.text = @"qqqqqq";
    self.passWordField.text = @"123456";
#endif
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
        
        self.identifyView.frame = CGRectMake(backView_size.width - 122,
                                             0,
                                             122,
                                             backView_size.height);
        
        self.identifyIndicatorView.frame = self.identifyView.frame;
        
        self.identifyField.frame = CGRectMake(CGRectGetMaxX(self.identifyIcon.frame) + textField_leftMargin,
                                              0,
                                              CGRectGetMinX(self.identifyView.frame) - CGRectGetMaxX(self.identifyIcon.frame) - textField_leftMargin,
                                              backView_size.height);
    }
    {
        self.loginButton.frame = CGRectMake(layoutMargin.left,
                                            CGRectGetMaxY(self.identifyBackView.frame) + backView_space * 2,
                                            backView_size.width,
                                            backView_size.height);
        
        self.registerButton.frame = CGRectMake(CGRectGetMaxX(self.loginButton.frame) - 130,
                                               CGRectGetMaxY(self.loginButton.frame) + 10,
                                               130,
                                               20);
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
        
        self.identifyIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"identifity"]];
        [self.identifyBackView addSubview:self.identifyIcon];
        
        self.identifyField = [[UITextField alloc] init];
        self.identifyField.placeholder = @"请输入验证码";
        self.identifyField.textColor = self.userNameField.textColor;
        self.identifyField.font = self.userNameField.font;
        self.identifyField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.identifyField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        [self.identifyBackView addSubview:self.identifyField];
        
        self.identifyView = [UIButton buttonWithType:UIButtonTypeCustom];
        self.identifyView.backgroundColor = SeparatorColor;
        self.identifyView.adjustsImageWhenHighlighted = NO;
        [self.identifyView setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        self.identifyView.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.identifyView addTarget:self action:@selector(getIdentifyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.identifyBackView addSubview:self.identifyView];
        
        self.identifyIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.identifyBackView addSubview:self.identifyIndicatorView];
        
    }
    {
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.loginButton setTitle:@"登 录" forState:UIControlStateNormal];
        self.loginButton.titleLabel.font = [UIFont systemFontOfSize:17];
        self.loginButton.backgroundColor = ThemeColor;
        [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.loginButton];
        
        self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.registerButton setTitle:@"没有账号?点此注册" forState:UIControlStateNormal];
        self.registerButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.registerButton setTitleColor:SeparatorColor forState:UIControlStateNormal];
        [self.registerButton addTarget:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [Api login:username
      password:password
       captcha:identifity
      complate:^(BOOL success){
          if (success) {
              
              weak_self.complete ? weak_self.complete() : nil;

              [weak_self loginSuccess];
          }else{
              [weak_self getIdentifyAction:nil];
          }
      }];
}

- (void)registerAction:(UIButton*)btn{
    KSRegisterController* regist = [[KSRegisterController alloc] init];
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)loginSuccess{
    KSMineController* mine = [[KSMineController alloc] init];
    [self.navigationController pushViewController:mine animated:YES];
}

- (void)cancelLoginAction:(UIBarButtonItem*)item{
    [self.view endEditing:YES];
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)getIdentifyAction:(UIButton*)button{
    button.userInteractionEnabled = NO;
    [self.identifyIndicatorView startAnimating];
    
    Weak(self);
    [Api getIdentifyCode:^(UIImage *code) {
        [weak_self.identifyView setTitle:nil forState:UIControlStateNormal];
        [weak_self.identifyView setImage:code forState:UIControlStateNormal];
        weak_self.identifyView.userInteractionEnabled = YES;
        [weak_self.identifyIndicatorView stopAnimating];
    }];
}


///MARK:-
+ (void)show{

    KSLoginController* login = [[KSLoginController alloc] init];
    
    KSNavigationController* nav = [[KSNavigationController alloc] initWithRootViewController:login];
    
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [rootViewController presentViewController:nav animated:YES completion:NULL];
}

@end
