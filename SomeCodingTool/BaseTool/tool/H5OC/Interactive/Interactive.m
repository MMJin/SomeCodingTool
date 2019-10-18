//
//  Interactive.m
//  test
//
//  Created by fcna03 on 2019/7/16.
//  Copyright © 2019 fujisoft. All rights reserved.
//

#import "Interactive.h"
#import "InteractiveResultModel.h"
#import "NSMutableDictionary+JSData.h"

@interface Interactive ()

@property (strong, nonatomic) InteractiveModel *interactiveData;

@end

static Interactive *interactiv;
@implementation Interactive

- (NSString *)javaScriptRunHandler:(nonnull InteractiveModel *)recieveData withSleepSensorDetail:(NSObject *)detailModel withSleepSensorLinkageSetModel:(NSObject *)setWebModel withRequestStatus:(int)status
{
    self.interactiveData = recieveData;
    NSData *data = nil;
    if ([@"getPhoneVersion" isEqualToString:recieveData.action]) {
        //获取App版本号
        NSString *app_Version = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
         NSLog(@"获取App版本号--%@",app_Version);
        //初始化返回数据
        NSMutableDictionary *model = NSMutableDictionary.create.putErrCode(status).putErrMsg([self requestStatus:status]).putAction(self.interactiveData.action);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:app_Version forKey:@"version"];
        [model setObject:dic forKey:@"data"];
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];

    } else if ([@"getUserType" isEqualToString:recieveData.action]) {
    //获取用户类型
        NSString *userType;
//        if ([UserFileManager isInstallUser]) {
            userType = @"install";
//        }
//        else if (SelectIsDemo){
            userType = @"demo";
        //}
       // else {
            userType = @"user";
        //}
        NSLog(@"获取用户类型--%@",userType);
        NSMutableDictionary *model = NSMutableDictionary.create.putErrCode(status).putErrMsg([self requestStatus:status]).putAction(self.interactiveData.action);
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:userType forKey:@"role"];
        [model setObject:dic forKey:@"data"];
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
        
    } else if ([@"getUserNLC" isEqualToString:recieveData.action]) {

    } else if ([@"getIPBoxVersion" isEqualToString:recieveData.action]) {
    
    } else if ([@"showLoading" isEqualToString:recieveData.action]) {
    //展示旋转框
        //初始化返回数据
        NSMutableDictionary *model = NSMutableDictionary.create.putAction(self.interactiveData.action);
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
    } else if ([@"hideLoading" isEqualToString:recieveData.action]) {
    //隐藏旋转框
        NSMutableDictionary *model = NSMutableDictionary.create.putAction(self.interactiveData.action);
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
    } else if ([@"setSleepUniteInfo" isEqualToString:recieveData.action]) {
        //发送协议@"sendCommond"
        NSMutableDictionary *model = NSMutableDictionary.create.putErrCode(status).putErrMsg([self requestStatus:status]).putAction(self.interactiveData.action);
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
    } else if ([@"getSleepUniteInfo" isEqualToString:recieveData.action]) {
    //监听协议@"monitorCommond"
        //初始化返回数据
        NSMutableDictionary *model = NSMutableDictionary.create.putErrCode(status).putErrMsg([self requestStatus:status]).putAction(self.interactiveData.action);
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
    } else if ([@"getSleepSensorMac" isEqualToString:recieveData.action]) {
    //获取睡眠传感器Mac地址
        //初始化返回数据

    }
    else if ([@"getIPBoxVersion" isEqualToString:recieveData.action]) {

    }
    else if ([@"getSSCommonInfo" isEqualToString:recieveData.action]) {

    }
    else if ([@"showSleepTimePicker" isEqualToString:recieveData.action]) {
        NSMutableDictionary *model = NSMutableDictionary.create.putErrCode(status).putErrMsg([self requestStatus:status]).putAction(self.interactiveData.action);
        //将返回数据转为data格式
        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
    }
//    else if ([@"onShow" isEqualToString:recieveData.action]) {
//        NSMutableDictionary *model = NSMutableDictionary.create.putErrCode(status).putErrMsg([self requestStatus:status]).putAction(self.interactiveData.action);
//        //将返回数据转为data格式
//        data = [NSJSONSerialization dataWithJSONObject:model options:0 error:nil];
//    }
    //如果data为空则发送空字符串，否则发送JSON字符串
    NSString *jsStr  = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    return data?jsStr:@"";
}

/**
 处理结果信息

 @param status 状态码
 @return 返回请求结果信息
 */
-(NSString *)requestStatus:(int)status {
    NSString *statuStr;
    if (status == 0) {
        statuStr =@"成功";
    }
    else {
         statuStr =@"失败";
    }
    return statuStr;
}
@end
