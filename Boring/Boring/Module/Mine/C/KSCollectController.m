//
//  KSCollectController.m
//  Boring
//
//  Created by Mac on 2018/1/26.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSCollectController.h"
#import "KSUser.h"
#import "KSText.h"
#import "KSCollectCell.h"

@interface KSCollectController ()<
UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray<KSText*>* dataSource;

@end

@implementation KSCollectController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];

    [self loadData];
}

- (void)loadData{
    if (!self.dataSource) { self.dataSource = [NSMutableArray array]; }
    
    Weak(self);
    [Api fetchCollectUser:[KSUser shared].cuid
                 complate:^(BOOL success, NSArray<KSText *> *texts) {
                     weak_self.dataSource = texts.mutableCopy;
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Weak(self);
    UIAlertController* al = [UIAlertController alertControllerWithTitle:nil
                                                                message:@"是否取消收藏?"
                                                         preferredStyle:UIAlertControllerStyleAlert];
    [al addAction:[UIAlertAction actionWithTitle:@"是"
                                           style:UIAlertActionStyleDefault
                                         handler:^(UIAlertAction * _Nonnull action) {
                                             [Api unCollectText:weak_self.dataSource[indexPath.row] complate:NULL];
                                             [weak_self.dataSource removeObjectAtIndex:indexPath.row];
                                             [weak_self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                                                        withRowAnimation:UITableViewRowAnimationAutomatic];
    }]];
    [al addAction:[UIAlertAction actionWithTitle:@"否"
                                           style:UIAlertActionStyleCancel
                                         handler:NULL]];
    [self presentViewController:al animated:YES completion:NULL];
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KSText* text = self.dataSource[indexPath.row];
    
    KSCollectCell* cell = [tableView dequeueReusableCellWithIdentifier:KSCollectCellID forIndexPath:indexPath];
    
    cell.text = text;
    
    return cell;
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        if (@available(iOS 10,*)) {
            _tableView.prefetchDataSource = self;
        }
        
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.layoutMargins = UIEdgeInsetsZero;
        
        _tableView.separatorColor = SeparatorColor;
        
        _tableView.tableFooterView = [UIView new];
        
        _tableView.estimatedRowHeight = 200;
        _tableView.rowHeight = UITableViewAutomaticDimension;

        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        [_tableView registerClass:[KSCollectCell class]
           forCellReuseIdentifier:KSCollectCellID];
    }
    return _tableView;
}
@end
