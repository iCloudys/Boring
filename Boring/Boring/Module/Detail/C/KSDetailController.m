//
//  KSDetailController.m
//  Boring
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSDetailController.h"
#import "KSText.h"
#import <SafariServices/SafariServices.h>

@interface KSDetailController ()<
UITextViewDelegate>

@property (nonatomic, strong) UITextView* textView;

@end

@implementation KSDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView = [[UITextView alloc] init];
    self.textView.editable = NO;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    [self loadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.textView.frame = self.view.bounds;
}

///MARK:- UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    
//    SFSafariViewController* safari = [[SFSafariViewController alloc] initWithURL:URL entersReaderIfAvailable:YES];
    
//    [self presentViewController:safari animated:YES completion:NULL];
    
    return YES;
}

- (void)loadData{
    
    Weak(self);
    [Api getTextDetail:self.text
              complate:^(BOOL success, NSString *html) {
                  
                  if (success) {
                      if (weak_self.text.resType == KSTextResShortType) {
                          [weak_self loadShortHtml:html];
                      }else{
                          [weak_self loadLongHtml:html];
                      }
                  }
              }];
}

- (void)loadLongHtml:(NSString*)html{
    
    NSString* pattern = @"(?<=<div class=\"article-content\">)([\\w\\W]+)(?=<div class=\"y-box article-actions\">)";
    
    NSRegularExpression* regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:1 error:nil];
    
    NSTextCheckingResult* checkingResult = [regularExpression firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];
    
    NSString* subStr = [html substringWithRange:checkingResult.range];
    
    NSString* header = [NSString stringWithFormat:@"<html><head><style>img{max-width:%fpx !important;} p{font-size:15px;}</style></head><body>",CGRectGetWidth(self.textView.frame)];
    
    NSString* footer = @"</body></html>";
    
    if (subStr.length != 0) {
        subStr = [NSString stringWithFormat:@"%@%@%@",header,subStr,footer];
    }else{
        subStr = [NSString stringWithFormat:@"%@<p>文章找不到</p>%@",header,footer];
    }
    
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    [options setObject:NSHTMLTextDocumentType forKey:NSDocumentTypeDocumentOption];
    [options setObject:@(NSUTF8StringEncoding) forKey:NSCharacterEncodingDocumentAttribute];

    NSAttributedString* attributeStr = [[NSAttributedString alloc] initWithData:[subStr dataUsingEncoding:NSUTF8StringEncoding]
                                                                        options:options
                                                             documentAttributes:nil
                                                                          error:nil];
    
    self.textView.attributedText = attributeStr;
}

- (void)loadShortHtml:(NSString*)html{
    
    NSString* pattern = @"(?<=<div class=\"content-middle\">)([\\s\\S]*?)(?=(</div>))";
    
    NSRegularExpression* regularExpression = [NSRegularExpression regularExpressionWithPattern:pattern options:1 error:nil];
    
    NSTextCheckingResult* checkingResult = [regularExpression firstMatchInString:html options:0 range:NSMakeRange(0, html.length)];
    
    NSString* subStr = [html substringWithRange:checkingResult.range];
   
    NSString* header = [NSString stringWithFormat: @"<style>img{max-width:%fpx !important;} p{font-size:15px;}</style>", CGRectGetWidth(self.textView.frame)];
    
    NSString* footer = @"</body></html>";
    
    if (subStr.length != 0) {
        subStr = [NSString stringWithFormat:@"%@%@%@",header,subStr,footer];
    }else{
        subStr = [NSString stringWithFormat:@"%@<p>文章找不到</p>%@",header,footer];
    }
    
    NSMutableDictionary* options = [NSMutableDictionary dictionary];
    [options setObject:NSHTMLTextDocumentType forKey:NSDocumentTypeDocumentOption];
    [options setObject:@(NSUTF8StringEncoding) forKey:NSCharacterEncodingDocumentAttribute];
    
    NSAttributedString* attributeStr = [[NSAttributedString alloc] initWithData:[subStr dataUsingEncoding:NSUTF8StringEncoding]
                                                                        options:options
                                                             documentAttributes:nil
                                                                          error:nil];
    
    self.textView.attributedText = attributeStr;
    
}

@end
