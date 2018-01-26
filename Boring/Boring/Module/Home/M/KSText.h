//
//  KSText.h
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSText : NSObject

@property (nonatomic, copy) NSString* regionName;
@property (nonatomic, copy) NSString* c_numbers;
@property (nonatomic, copy) NSString* headUrl;
@property (nonatomic, copy) NSString* userName;
@property (nonatomic, copy) NSString* htmlKeywords;
@property (nonatomic, copy) NSString* htmlDescription;
@property (nonatomic, copy) NSString* resId;
@property (nonatomic, copy) NSString* userId;

@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy, readonly) NSAttributedString* attributeContent;

@property (nonatomic, copy) NSString* down;
@property (nonatomic, copy) NSString* resName;
@property (nonatomic, copy) NSString* htmlTitle;
@property (nonatomic, copy) NSString* top;
@property (nonatomic, copy) NSString* share;
@property (nonatomic, copy) NSString* id;
@property (nonatomic, copy) NSString* tag;
@property (nonatomic, copy) NSString* pageview;
@property (nonatomic, copy) NSString* collect;
@property (nonatomic, copy) NSString* kingComment;
@property (nonatomic, copy) NSString* cp_sum;

@property (nonatomic, copy) NSString* picture;

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy, readonly) NSAttributedString* attributeTitle;

@property (nonatomic, copy) NSString* createTime;

@property (nonatomic, assign) KSTextResType resType;

@property (nonatomic, assign) BOOL hot;
@property (nonatomic, assign) BOOL isCollect;
@property (nonatomic, assign) BOOL isLike;
@property (nonatomic, assign) BOOL isUnlike;


@end
