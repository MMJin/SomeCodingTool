//
//  NSMutableDictionary+JSData.m
//  AirConditioningControl
//
//  Created by FCNC05 on 2019/7/19.
//  Copyright © 2019 Weidongsoft. All rights reserved.
//

#import "NSMutableDictionary+JSData.h"

@implementation NSMutableDictionary (JSData)
+ (instancetype)create
{
    NSMutableDictionary *reSendModel = [[NSMutableDictionary alloc] init];
    return reSendModel;
}
/**
 加入错误码
 */
- (NSMutableDictionary * (^)(int))putErrCode
{
    __weak typeof(self)wself = self;
    NSMutableDictionary * (^ result)(int) = ^(int value) {
        [wself setObject:@(value) forKey:@"errCode"];
        return wself;
    };
    return result;
}

/**
 加入错误信息
 */
- (NSMutableDictionary * (^)(NSString *errMsg))putErrMsg
{
    __weak typeof(self)wself = self;
    NSMutableDictionary * (^ result)(NSString *errMsg) = ^(NSString *errMsg) {
        [wself setObject:errMsg forKey:@"errMsg"];
        return wself;
    };
    return result;
}

/**
 加入标识符
 */
- (NSMutableDictionary * (^)(NSString *action))putAction
{
    __weak typeof(self)wself = self;
    NSMutableDictionary * (^ result)(NSString *action) = ^(NSString *action) {
        [wself setObject:action forKey:@"action"];
        return wself;
    };
    return result;
}

/**
 加入数据包
 */
//- (NSMutableDictionary * (^)(NSString *key, id value))putData
//{
//    __weak typeof(self)wself = self;
//    NSMutableDictionary * (^ result)(NSString *key, id value) = ^(NSString *key, id value) {
////        wself.sendData = [NSMutableDictionary dictionary];
//        [wself.sendData setValue:value forKey:key];
//        [wself setObject:wself.sendData forKey:@"data"];
//        return wself;
//    };
//    return result;
//}

//- (NSMutableDictionary *)sendData{
//    if (!_sendData) {
//        _sendData = [NSMutableDictionary dictionary];
//    }
//    return _sendData;
//}
@end
