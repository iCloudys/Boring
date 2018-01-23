//
//  KSIndexController.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSIndexController.h"
#import "KSTextManager.h"
#import "KSText.h"
#import <MJRefresh/MJRefresh.h>

#import "KSTableShortCell.h"
#import "KSTableLongCell.h"

#import "KSDetailController.h"

@interface KSIndexController ()<
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray<KSText*>* dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation KSIndexController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
    
    [self loadData];
}

- (void)loadData{
    if (!self.dataSource) { self.dataSource = [NSMutableArray array]; }
    
    Weak(self);
    [[KSTextManager manager] fetchTextWithCategory:self.category
                                              page:_page
                                          complate:^(NSArray<KSText *> *texts) {
                                              [weak_self.tableView.mj_footer endRefreshing];
                                              [weak_self.dataSource addObjectsFromArray:texts];
                                              [weak_self.tableView reloadData];
                                          }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

///MARK: -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    KSText* text = self.dataSource[indexPath.row];
    if (text.resType == KSTextResShortType) {
        return [KSTableShortCell heightForText:text
                                     withWidth:CGRectGetWidth(tableView.frame)];
    }else{
        return [KSTableLongCell heightForText:text
                                    withWidth:CGRectGetWidth(tableView.frame)];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KSText* text = self.dataSource[indexPath.row];
    
    if (text.resType == KSTextResShortType) {
        
        KSTableShortCell* cell = [tableView dequeueReusableCellWithIdentifier:KSTableShortCellID forIndexPath:indexPath];
        
        cell.text = text;
        
        return cell;
        
    }else{
        
        KSTableLongCell* cell = [tableView dequeueReusableCellWithIdentifier:KSTableLongCellID forIndexPath:indexPath];
        
        cell.text = text;
        
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    KSDetailController* detail = [[KSDetailController alloc] init];
    detail.text = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
        [self.tableView.mj_footer beginRefreshing];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.layoutMargins = UIEdgeInsetsZero;
        
        _tableView.separatorColor = SeparatorColor;
        
        _tableView.tableFooterView = [UIView new];

        [_tableView registerClass:[KSTableShortCell class]
           forCellReuseIdentifier:KSTableShortCellID];
        [_tableView registerClass:[KSTableLongCell class]
           forCellReuseIdentifier:KSTableLongCellID];
        
        Weak(self);
        MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _page ++;
            [weak_self loadData];
        }];
    
        _tableView.mj_footer = footer;
    }
    return _tableView;
}

@end
