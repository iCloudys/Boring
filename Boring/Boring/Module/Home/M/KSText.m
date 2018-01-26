//
//  KSText.m
//  Boring
//
//  Created by Mac on 2018/1/19.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSText.h"

@implementation KSText

//此处需要优化内存
- (void)setContent:(NSString *)content{
    _content = [content copy];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = TextLineSpacing;
    
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    [attributes setObject:TextFont forKey:NSFontAttributeName];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    
    _attributeContent = [[NSAttributedString alloc] initWithString:[self replaceHtmlString:content] attributes:attributes];
}

- (void)setTitle:(NSString *)title{
    _title = [title copy];
    
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    
    NSMutableAttributedString* attributeString = [[NSMutableAttributedString alloc] init];
    
    [attributeString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:title
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],
                                                          NSForegroundColorAttributeName:[UIColor colorWithHex:@"323232"]
                                                          }
                                             ]
     ];
    
    [attributeString appendAttributedString:[[NSAttributedString alloc]
                                             initWithString:[NSString stringWithFormat:@"\n%@阅读",self.pageview]
                                             attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],
                                                          NSForegroundColorAttributeName:[UIColor colorWithHex:@"7d7d7d"],
                                                          }
                                             ]
     ];
    
    [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributeString.string.length)];
    
    _attributeTitle = attributeString;
}

- (NSString*)replaceHtmlString:(NSString*)content{
    
    NSData* contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    [options setObject:NSHTMLTextDocumentType forKey:NSDocumentTypeDocumentOption];
    [options setObject:@(NSUTF8StringEncoding) forKey:NSCharacterEncodingDocumentOption];

    NSAttributedString* htmlString = [[NSAttributedString alloc] initWithData:contentData options:options
                                                           documentAttributes:nil
                                                                        error:nil];
    
    return htmlString.string;
}

@end
