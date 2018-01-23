//
//  KSText.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSText.h"

@implementation KSText

- (void)setContent:(NSString *)content{
    _content = [self replaceHtmlString:content].copy;
}

- (void)setTitle:(NSString *)title{
    _title = [self replaceHtmlString:title];
}

- (NSString*)replaceHtmlString:(NSString*)content{
        
    NSDictionary* htmlStrs = @{@"&nbsp;":@" ",
                               @"&ldquo;":@"“",
                               @"&rdquo;":@"”",
                               @"&hellip;":@"……",
                               @"&lsquo;":@"‘",
                               @"&rsquo;":@"‘",
                               @"&middot;":@"·",
                               };
    
    __block NSString* str = content;
    [htmlStrs enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* obj, BOOL * stop) {
        str = [str stringByReplacingOccurrencesOfString:key withString:obj];
    }];
    
    return str;
}

@end
