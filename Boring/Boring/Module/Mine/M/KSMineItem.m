//
//  KSMineItem.m
//  Boring
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSMineItem.h"
#import "KSUser.h"
#import "KSFeedBackController.h"
#import "KSDetailController.h"
#import "KSSubmitController.h"
#import "KSCollectController.h"
#import "KSText.h"

@implementation KSMineItem

+ (NSArray<NSArray<KSMineItem *> *> *)itemsForController:(UINavigationController *)controller {
    
    NSMutableArray* items = [NSMutableArray array];
    
    KSMineItem* header = [[KSMineItem alloc] init];
    header.height = 80;
    header.header = [KSUser shared].header;
    header.text = [KSUser shared].username;
    header.controller = controller;
    
    header.selectedBlock = ^{
       /* UIAlertController* al = [UIAlertController alertControllerWithTitle:@"更新头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [al addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weak_self selectedImageSource:UIImagePickerControllerSourceTypeCamera item:weak_header];
        }]];
        [al addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weak_self selectedImageSource:UIImagePickerControllerSourceTypePhotoLibrary item:weak_header];
        }]];
        [al addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:NULL]];
        [weak_controller presentViewController:al animated:YES completion:NULL];
        */
    };
    [items addObject:@[header]];
    
    KSMineItem* item1 = [[KSMineItem alloc] init];
    item1.height = 50;
    item1.selectedBlock = ^{
        KSCollectController* detail = [[KSCollectController alloc] init];
        [controller pushViewController:detail animated:YES];
    };
    item1.text = @"我的收藏";
    [items addObject:@[item1]];
    /*
    KSMineItem* item2 = [[KSMineItem alloc] init];
    item2.height = 50;
    item2.selectedBlock = ^{
        KSSubmitController* detail = [[KSSubmitController alloc] init];
        [controller pushViewController:detail animated:YES];
    };
    item2.text = @"投稿";
*/
    
    KSMineItem* item4 = [[KSMineItem alloc] init];
    item4.height = 50;
    item4.selectedBlock = ^{
        KSDetailController* detail = [[KSDetailController alloc] init];
        KSText* about = [[KSText alloc] init];
        about.resType = KSTextResLongType;
        about.id = @"5";
        detail.text = about;
        [controller pushViewController:detail animated:YES];
    };
    item4.text = @"帮助文档";
    
    KSMineItem* item5 = [[KSMineItem alloc] init];
    item5.height = 50;
    item5.selectedBlock = ^{
        KSDetailController* detail = [[KSDetailController alloc] init];
        KSText* about = [[KSText alloc] init];
        about.resType = KSTextResLongType;
        about.id = @"4";
        detail.text = about;
        [controller pushViewController:detail animated:YES];
    };
    item5.text = @"协议声明";
    
    KSMineItem* item6 = [[KSMineItem alloc] init];
    item6.height = 50;
    item6.selectedBlock = ^{
        KSDetailController* detail = [[KSDetailController alloc] init];
        KSText* about = [[KSText alloc] init];
        about.resType = KSTextResLongType;
        about.id = @"3";
        detail.text = about;
        [controller pushViewController:detail animated:YES];
    };
    item6.text = @"联系我们";
    
    KSMineItem* item7 = [[KSMineItem alloc] init];
    item7.height = 50;
    item7.text = @"关于我们";
    item7.selectedBlock = ^{
        KSDetailController* detail = [[KSDetailController alloc] init];
        KSText* about = [[KSText alloc] init];
        about.resType = KSTextResLongType;
        about.id = @"1";
        detail.text = about;
        [controller pushViewController:detail animated:YES];
    };
    [items addObject:@[item4,item5,item6,item7]];
    
    KSMineItem* item3 = [[KSMineItem alloc] init];
    item3.height = 50;
    item3.selectedBlock = ^{
        KSFeedBackController* detail = [[KSFeedBackController alloc] init];
        [controller pushViewController:detail animated:YES];
    };
    item3.text = @"反馈";
    [items addObject:@[item3]];
    
    return items.copy;
}
/*
+ (void)selectedImageSource:(UIImagePickerControllerSourceType)sourceType item:(KSMineItem*)item{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = item;
        imagePicker.allowsEditing = YES;
        [item.controller presentViewController:imagePicker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* image = info[UIImagePickerControllerEditedImage];
    
    NSLog(@"%@",image);
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
*/
@end
