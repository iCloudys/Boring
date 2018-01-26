//
//  KSMineItem.h
//  Boring
//
//  Created by Mac on 2018/1/24.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^KSMineItemDidSelectedBlock)();

@interface KSMineItem : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, copy) NSString* header;
@property (nonatomic, copy) NSString* text;
@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) KSMineItemDidSelectedBlock selectedBlock;

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, weak) UINavigationController* controller;

+ (NSArray<NSArray<KSMineItem *> *> *)itemsForController:(UINavigationController*)controller;

@end
