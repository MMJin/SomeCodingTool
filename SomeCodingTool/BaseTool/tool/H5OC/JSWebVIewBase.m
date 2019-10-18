//
//  JSWebVIewBase.m
//  AirConditioningControl
//
//  Created by FCNC05 on 2019/8/9.
//  Copyright © 2019 Weidongsoft. All rights reserved.
//

#import "JSWebVIewBase.h"
#import "Interactive.h"
@interface JSWebVIewBase()<WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>
/// 添加计时器 请求超时处理
@property (nonatomic,strong) NSTimer *timeOutTimer;
@end

@implementation JSWebVIewBase
//主要是设置加载URL 和加载状态
-(instancetype)initWithFrame:(CGRect)frame withLoadUrl:(NSString *)loadUrl withGetJSAction:(GetJSAction )getAction withRenderingStatus:(Rendering)status {
//这里的frame 是初始设置的
    if (self = [super initWithFrame:frame]) {
        //创建网页加载url
        [self addSubview:[self webViewJSWithFrame:frame withLoadUrl:loadUrl]];
        self.jsAction = getAction;
        self.renderingStatus = status;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(WKWebView *)webViewJSWithFrame:(CGRect)frame withLoadUrl:(NSString *)loadUrl{
    if (!_webViewJS) {
        _webViewJS = [[WKWebView alloc] initWithFrame:frame];
        //设置背景透明
        _webViewJS.opaque = NO;
        _webViewJS.backgroundColor = [UIColor clearColor];
        //注册H5商定的自定义协议
        [_webViewJS.configuration.userContentController addScriptMessageHandler:self name:@"sendToNative"];
        _webViewJS.UIDelegate = self;
        _webViewJS.navigationDelegate = self;
    }
    [_webViewJS loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loadUrl]]];
    return _webViewJS;
}

-(void)loadUrl:(NSString *)url{
    [_webViewJS loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if ([message.name isEqualToString:@"sendToNative"]) {//判断是否来自JS定义的方法
        //初始化数据模型
        InteractiveModel *model = [InteractiveModel creatModelWith:(NSDictionary *)message.body];
        self.jsTempModel = model;
        NSLog(@"------jsAction--%@",self.jsTempModel.action);
        if ([model.action isEqualToString:@"setSleepUniteInfo"]) {
            self.jsAction(@"setSleepUniteInfo");
        }
        else if([model.action isEqualToString:@"hideLoading"]){
            [JSWebVIewBase cancelPreviousPerformRequestsWithTarget:self selector:@selector(webUrlfinsh) object:nil];
            self.jsAction(@"hideLoading");
            NSLog(@"网页定时器销毁");
            [self.timeOutTimer invalidate];
             self.timeOutTimer = nil;
          }
        else if([model.action isEqualToString:@"showSleepTimePicker"]){
            self.jsAction(@"showSleepTimePicker");
        }
//        else if([model.action isEqualToString:@"getSSCommonInfo"]){
//            /// 对应demo不发送数据
//            if (SelectIsDemo) {
//                return;
//            }
//            self.jsAction(@"getSSCommonInfo");
////             [self sendDataToWebWithRequestStatus:0];
//        }
        else {
            //self.jsTempModel.data[@"appSleepScore"] = 1;
            [self sendDataToWebWithRequestStatus:0];
        }
    }
}
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"urlrenderingStart");
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
     NSLog(@"urlrenderingFail网页定时器销毁");
    [self.timeOutTimer invalidate];
    self.timeOutTimer = nil;
    self.renderingStatus(renderingError);
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (1) {
    self.renderingStatus(renderingEnd);
    }
    else{
     [self setTimeOutAction];
    }
}
-(void)webUrlfinsh {
    self.renderingStatus(renderingEnd);
    [JSWebVIewBase cancelPreviousPerformRequestsWithTarget:self selector:@selector(webUrlfinsh) object:nil];
}
//数据转发给h5
-(void)sendDataToWebWithRequestStatus:(int)status {
    //这边是要将数据转化为json数据字符串转发给H5渲染完成状态
    NSString *javaScript = [[[Interactive alloc] init] javaScriptRunHandler:self.jsTempModel withSleepSensorDetail:[NSObject new] withSleepSensorLinkageSetModel:[NSObject new] withRequestStatus:status];
    NSLog(@"JS数据处理后的字符串%@",javaScript);
    NSString *jsStr = [NSString stringWithFormat:@"receivedFromNative('%@')", javaScript];
    [self.webViewJS evaluateJavaScript:jsStr completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if (error) {
    NSLog(@"错误:%@", error.localizedDescription);
        }
    }];
    WKNavigation *nav;
    [self webView:self.webViewJS didFinishNavigation:nav];
}
/**
 web端获取数据发送P板

 @param jsDataModel jsdata
 */
-(void)sendWebInfoToIP:(InteractiveModel *)jsDataModel withSleepSensorData:(NSData *)sleepSensorData {
  //中间数据获取
}
// 超时处理 这里设置的是如果有请求固定15秒执行方法
- (void)timeOutAction {
    //[self disappearIndicator];
    NSLog(@"超时网页定时器销毁");
    self.renderingStatus(renderingEnd);
    [self.timeOutTimer invalidate];
     self.timeOutTimer = nil;
}
-(void)setTimeOutAction{
    //定时器用于判断超时
    if (!self.timeOutTimer) {
        self.timeOutTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeOutAction) userInfo:nil repeats:NO];
    }
}
@end
