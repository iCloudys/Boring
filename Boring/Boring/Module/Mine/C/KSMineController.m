//
//  KSMineController.m
//  Boring
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSMineController.h"
#import "KSNavigationController.h"
#import "KSUser.h"

#import "KSMineItemCell.h"
#import "KSMineHeaderCell.h"
#import "KSMineItem.h"

@interface KSMineController ()<
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSArray<NSArray<KSMineItem*>*>* items;

@end

@implementation KSMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.navigationItem.title = @"个人中心";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(cancelLoginAction:)];
    
    self.items = [KSMineItem itemsForController:self.navigationController];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

///MARK:- Back
- (void)cancelLoginAction:(UIBarButtonItem*)item{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
}


///MARK:- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.items[indexPath.section][indexPath.row].height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        KSMineHeaderCell* cell = [tableView dequeueReusableCellWithIdentifier:KSMineHeaderCellID forIndexPath:indexPath];
        cell.item = self.items[indexPath.section][indexPath.row];
        return cell;
    }else{
        
        KSMineItemCell* cell = [tableView dequeueReusableCellWithIdentifier:KSMineItemCellID forIndexPath:indexPath];
        cell.item = self.items[indexPath.section][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.items[indexPath.section][indexPath.row].selectedBlock();
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.layoutMargins = UIEdgeInsetsZero;
        
        _tableView.separatorColor = SeparatorColor;
        
        _tableView.tableFooterView = [UIView new];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        [_tableView registerClass:[KSMineHeaderCell class]
           forCellReuseIdentifier:KSMineHeaderCellID];
        [_tableView registerClass:[KSMineItemCell class]
           forCellReuseIdentifier:KSMineItemCellID];
        
    }
    return _tableView;
}


+ (void)show{
    KSMineController* login = [[KSMineController alloc] init];
    
    KSNavigationController* nav = [[KSNavigationController alloc] initWithRootViewController:login];
    
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [rootViewController presentViewController:nav animated:YES completion:NULL];
}

@end
