//
//  KSHomeController.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSHomeController.h"
#import "KSIndexController.h"
#import "KSCategory.h"
#import "KSUser.h"
#import "KSLoginController.h"
#import "KSMineController.h"

#import <SDWebImage/UIButton+WebCache.h>

@interface KSHomeController ()<
WMPageControllerDelegate,
WMPageControllerDataSource
>

@property (nonatomic, strong) UIButton* headerView;

@property (nonatomic, strong) UIView* separator;

@property (nonatomic, strong) NSArray<KSCategory*>* categorys;

@end

@implementation KSHomeController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.itemMargin = menuItemMargin;
        
        self.titleSizeNormal = menuTitleSizeNormal;
        self.titleSizeSelected = menuTitleSizeSelected;
        
        self.titleColorNormal = menuTitleColorNormal;
        self.titleColorSelected = menuTitleColorSelected;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"无聊看看网";

    self.menuView.backgroundColor = menuViewBackgroundColor;

    self.headerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headerView setImage:[UIImage imageNamed:@"demo"] forState:UIControlStateNormal];
    self.headerView.layer.masksToBounds = YES;
    [self.headerView addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.headerView];
    /*
    UIImageView* search = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    search.frame = CGRectMake(0, 0, 25, 25);
    UITapGestureRecognizer* right = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightButtonAction:)];
    [search addGestureRecognizer:right];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    */
    self.separator = [[UIView alloc] init];
    self.separator.backgroundColor = SeparatorColor;
    [self.view addSubview:self.separator];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.separator.frame = CGRectMake(0,
                                      CGRectGetHeight(self.menuView.bounds),
                                      CGRectGetWidth(self.view.bounds),
                                      SeparatorHeight);

    self.headerView.frame = CGRectMake(0, 0, 30, 30);
    self.headerView.layer.cornerRadius = CGRectGetWidth(self.headerView.bounds) / 2;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([KSUser shared].header.length > 0) {
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:[KSUser shared].header] forState:UIControlStateNormal];
    }
}

///MARK:- BarButtonItemAction
- (void)leftButtonAction:(UIButton*)tap{
    
    if ([KSUser isLogin]) {
        
        [KSMineController show];
        
    }else{
        [KSLoginController show];
    }
}

- (void)rightButtonAction:(UIBarButtonItem*)right{
    NSLog(@"right");
}

///MARK: -WMPageControllerDataSource
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.categorys.count;
}

- (__kindof UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index{
    KSIndexController* vc = [[KSIndexController alloc] init];
    vc.category = self.categorys[index];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index{
    return self.categorys[index].name;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return UIEdgeInsetsInsetRect(self.view.bounds, UIEdgeInsetsMake(menuViewHeight, 0, 0, 0));
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), menuViewHeight);
}

///MARK: -Categorys
- (NSArray<KSCategory *> *)categorys{
    if (!_categorys) {
        _categorys = [KSCategory mj_objectArrayWithFilename:@"Categorys.plist"];
    }
    return _categorys;
}
@end
