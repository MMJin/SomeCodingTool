//
//  JSWebVIewBase.h
//  AirConditioningControl
//
//  Created by FCNC05 on 2019/8/9.
//  Copyright © 2019 Weidongsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "InteractiveModel.h"
typedef enum:int {

    renderingStart =1,
    renderingError = 0,
    renderingEnd =2,

}renderingType;//渲染
@class JSWebVIewBase;
//返回值为本身且对象参数不为空/ 属性用copy
typedef JSWebVIewBase *_Nonnull(^pramar)(NSString * _Nonnull str);
typedef void(^GetJSAction)(NSString * _Nonnull action);
typedef void(^Rendering)(renderingType status);
NS_ASSUME_NONNULL_BEGIN

@interface JSWebVIewBase : UIView
///自定义动作
@property(nonatomic,copy)GetJSAction jsAction;
///渲染状态
@property(nonatomic,copy)Rendering renderingStatus;
//webView
@property(strong,nonatomic)WKWebView *webViewJS;
//临时处理JS数据存储
@property(strong,nonatomic)InteractiveModel *jsTempModel;
@property(nonatomic,strong)NSData *sleepSensorMAC;
/**
 初始化对象
 @param instancetype
 @return
 */
-(instancetype)initWithFrame:(CGRect)frame withLoadUrl:(NSString *)loadUrl withGetJSAction:(GetJSAction )getAction withRenderingStatus:(Rendering)status;//withRenderingStatus

/**
 加载连接

 @param url 显示连接
 */
-(void)loadUrl:(NSString *)url;

/**
 发送数据给H5

 @param status 数据获取状态
 */
-(void)sendDataToWebWithRequestStatus:(int)status;

/**
 获取H5数据发送给P板

 @param jsDataModel H5数据
 @param sleepSensorData 设备的mac
 */
-(void)sendWebInfoToIP:(InteractiveModel *)jsDataModel withSleepSensorData:(NSData *)sleepSensorData;
@end

NS_ASSUME_NONNULL_END
