//
//  KSDetailController.m
//  Boring
//
//  Created by Mac on 2018/1/23.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "KSDetailController.h"
#import "KSText.h"
#import <AFNetworking/AFNetworking.h>
#import <WebKit/WebKit.h>

@interface KSDetailController ()<
WKNavigationDelegate>

@property (nonatomic, strong) WKWebView* webView;

@property (nonatomic, copy) NSString* url;
@end

@implementation KSDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView = [[WKWebView alloc] init];
    self.webView.navigationDelegate = self;
    [self.view addSubview:self.webView];
    
    self.url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/short_detail/%@.html",self.text.id];
    if (self.text.resType == KSTextResLongType) {
        self.url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/long_detail/%@.html",self.text.id];
    }

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.webView.frame =self.view.bounds;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    NSMutableArray<NSString*>* jses = @[
                                        @"document.getElementById('header').style.display='none'",
                                        @"document.getElementById('footer').style.display='none'",
                                        @"document.getElementsByClassName('adsense')[0].style.display='none'",
                                        @"document.getElementsByClassName('recommend')[0].style.display='none'",
                                        @"document.getElementById('pagelet-ncomment').style.display='none'",
                                        ].mutableCopy;
    
    if (self.text.resType == KSTextResLongType) {
        [jses addObject:@"document.getElementsByClassName('brother')[0].style.display='none'"];
        [jses addObject:@"document.getElementsByClassName('collect-share')[0].style.display='none'"];
    }else{
        [jses addObject:@"document.getElementById('pagelet-snsbox').style.display='none'"];
        [jses addObject:@"document.getElementsByClassName('right-btn clip')[0].style.display='none'"];
        [jses addObject:@"document.getElementsByClassName('left-btn clip')[0].style.display='none'"];
    }
    
    for (NSString* js in jses) {
        [webView evaluateJavaScript:js
                  completionHandler:^(id obj, NSError * _Nullable error) {
                  }];
    }
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if ([navigationAction.request.URL.absoluteString isEqualToString:self.url]) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

@end
