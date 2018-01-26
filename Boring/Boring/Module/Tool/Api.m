//
//  Api.m
//  Boring
//
//  Created by Mac on 2018/1/22.
//  Copyright © 2018年 RUIPENG. All rights reserved.
//

#import "Api.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFImageDownloader.h>
#import "KSText.h"
#import "KSUser.h"
#import "KSCategory.h"

@interface Api()
@property (nonatomic, strong) AFHTTPSessionManager* manager;
@end

@implementation Api

static Api* _api;
+ (instancetype)api{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _api = [[Api alloc] init];
    });
    return _api;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return self;
}

+ (void)getIdentifyCode:(void (^)(UIImage *))complete{
    
    NSString* urlString = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/verify?t=%.0f",CFAbsoluteTimeGetCurrent() * 1000];
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    req.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    [[AFImageDownloader defaultInstance] downloadImageForURLRequest:req
                                                            success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull responseObject) {

                                                                complete(responseObject);
                                                            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                                                complete(nil);
                                                            }];
}

+ (void)registe:(NSString *)account
       password:(NSString *)password
     repassword:(NSString *)repassword
       complate:(void (^)(BOOL))complate{
    
    if (account.length == 0) {
        [self showMsg:@"账号不能为空"];
        complate(NO);
        return;
    }
    if (password.length == 0) {
        [self showMsg:@"密码不能为空"];
        complate(NO);
        return;
    }
    if (![password isEqualToString:repassword]) {
        [self showMsg:@"两次密码不一致"];
        complate(NO);
        return;
    }
    
    Weak(self);
    [self POST:@"https://www.wuliaokankan.cn/doregister"
     parameter:@{@"account":account,@"password":password,@"repassword":repassword}
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
           [weak_self showMsg:@"注册成功"];
           complate(YES);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate(NO);
       }];
}


+ (void)login:(NSString *)account
     password:(NSString *)password
      captcha:(NSString *)captcha
     complate:(void (^)(BOOL success))complate{
    if (account.length == 0) {
        [self showMsg:@"账号不能为空"];
        complate(NO);
        return;
    }
    if (password.length == 0) {
        [self showMsg:@"密码不能为空"];
        complate(NO);
        return;
    }
    if (captcha.length == 0) {
        [self showMsg:@"验证码不能为空"];
        complate(NO);
        return;
    }
    
    [self POST:@"https://www.wuliaokankan.cn/dologin"
     parameter:@{@"account":account,@"password":password,@"captcha":captcha}
       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
           
           NSString* result = responseObject[@"result"];

           NSString* header_pattern = @"http(.*?)(.jpg)|(.png)";
           
           NSRegularExpression* re = [NSRegularExpression regularExpressionWithPattern:header_pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
           
           NSTextCheckingResult* header_result = [re firstMatchInString:result options:NSMatchingReportCompletion range:NSMakeRange(0, result.length)];
           
           NSString* header = [result substringWithRange:header_result.range];
           
           
           NSString* cuid_pattern = @"value='\\d+";

           re = [NSRegularExpression regularExpressionWithPattern:cuid_pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
           
           NSTextCheckingResult* cuid_result = [re firstMatchInString:result options:NSMatchingReportCompletion range:NSMakeRange(0, result.length)];
           
           NSString* cuid = [[result substringWithRange:cuid_result.range] substringFromIndex:7];
           
           
           [KSUser shared].header = header;
           
           [KSUser shared].username = account;
           
           [KSUser shared].cuid = cuid;
           
           complate(YES);
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate(NO);
       }];
}

+ (void)getTextWithCategory:(KSCategory *)category
                       page:(NSUInteger)page
                   complate:(void (^)(NSArray<KSText *> *))complate{
    
    [self POST:category.url
     parameter:@{@"page":@(page),@"resId":category.resId}
       success:^(NSURLSessionDataTask *task, id responseObject) {
       
           NSDictionary* dic = responseObject[@"result"][@"texts"];
           NSArray* temp = [KSText mj_objectArrayWithKeyValuesArray:dic];
           complate(temp);
       
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate(@[]);
       }];
    
}

+ (void)getTextDetail:(KSText *)text
             complate:(void (^)(BOOL, NSString *))complate{
    
    NSString* url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/short_detail/%@.html",text.id];
    if (text.resType == KSTextResLongType) {
        url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/long_detail/%@.html",text.id];
    }
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager POST:url
       parameters:nil
         progress:NULL
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
              
              NSString* str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
              
              complate(YES,str);
              
          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              complate(NO,nil);
          }];
}

+ (void)likeText:(KSText *)text
        complate:(void (^)(BOOL))complate{
    
    NSString* url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/short_top/%@",text.id];
    Weak(self);
    [self POST:url
     parameter:@{}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [weak_self showMsg:responseObject[@"msg"]];
           complate ? complate(YES) : nil;
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate ? complate(NO) : nil;
       }];
}

+ (void)unlikeText:(KSText *)text
        complate:(void (^)(BOOL))complate{
    
    NSString* url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/short_down/%@",text.id];

    [self POST:url
     parameter:@{}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           complate ? complate(YES) : nil;
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate ? complate(NO) : nil;
       }];
}

+ (void)collectText:(KSText *)text complate:(void (^)(BOOL))complate{
    
    NSString* url = [NSString stringWithFormat:@"https://www.wuliaokankan.cn/user_collection/%@/0?resType=0",text.id];
    
    [self POST:url
     parameter:@{}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           complate ? complate(YES) : nil;
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate ? complate(NO) : nil;
       }];
}

+ (void)submitFeedbackEmail:(NSString*)email
                    content:(NSString*)content
                   complate:(void(^)(BOOL success))complate{
    
    if (content.length == 0) {
        [self showMsg:@"请输入意见"];
        complate ? complate(NO) : nil;
        return;
    }
    
    if (content.length > 140) {
        content = [content substringToIndex:140];
    }
    
    NSString* url = @"https://www.wuliaokankan.cn/feedback";
    
    [self POST:url
     parameter:@{@"email":email,@"content":content}
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self showMsg:@"反馈成功"];
           complate ? complate(YES) : nil;
       } failure:^(NSURLSessionDataTask *task, NSError *error) {
           complate ? complate(NO) : nil;
       }];
}

+ (void)POST:(NSString*)post
   parameter:(id)parameter
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask * task, NSError *error))failure{
    
//    cookie:    @"UM_distinctid=1610c4569aa304-04222225e5ef37-32677403-13c680-1610c4569ab9ae;
//    Hm_lvt_16e9a02ab296d279ea57f95bcfa3c3e8=1516329331,1516588251;
//    wlkk_uid=1771;
//    JSESSIONID=B8659378F50707970B940B98666C4E03;
//    Hm_lpvt_16e9a02ab296d279ea57f95bcfa3c3e8=1516617022;
//    CNZZDATA1262018712=586299301-1516329225-%7C1516617021"
    
    Weak(self);
    [[Api api].manager POST:post
                 parameters:parameter
                   progress:NULL
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        
                        NSInteger code = [responseObject[@"code"] integerValue];
                        if (code == 0) {
                            
                            success? success(task,responseObject) : nil;
                            
                        }else{
                            NSString* msg = responseObject[@"msg"];
                            [weak_self showMsg:msg];
                            failure ? failure(task,nil) : nil;
                        }
                        
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#if DEBUG
                        NSHTTPURLResponse* resp = (NSHTTPURLResponse*)task.response;
                        [weak_self showMsg:[NSString stringWithFormat:@"error:%ld",resp.statusCode]];
#else
                        [weak_self showMsg:@"网络错误"];
#endif
                        failure ? failure(task,nil) : nil;
                    }];
}

+ (void)showMsg:(NSString*)msg{
    [[UIApplication sharedApplication].delegate.window makeToast:msg
                                                        duration:1.0
                                                        position:CSToastPositionCenter];
}
@end
