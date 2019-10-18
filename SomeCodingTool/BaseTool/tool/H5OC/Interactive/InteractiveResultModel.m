//
//  InteractiveResultModel.m
//  test
//
//  Created by fcna03 on 2019/7/16.
//  Copyright © 2019 fujisoft. All rights reserved.
//

#import "InteractiveResultModel.h"

@implementation InteractiveResultModel

+ (instancetype)create
{
    InteractiveResultModel *reSendModel = [[InteractiveResultModel alloc] init];
    return reSendModel;
}

/**
 加入错误码
 */
- (InteractiveResultModel * (^)(int))putErrCode
{
    __weak typeof(self)wself = self;
    InteractiveResultModel * (^ result)(int) = ^(int value) {
        [wself setObject:@(value) forKey:errCode];
        return wself;
    };
    return result;
}

/**
 加入错误信息
 */
- (InteractiveResultModel * (^)(NSString *errMsg))putErrMsg
{
    __weak typeof(self)wself = self;
    InteractiveResultModel * (^ result)(NSString *errMsg) = ^(NSString *errMsg) {
        [super setObject:errMsg forKey:errMsg];
        return wself;
    };
    return result;
}

/**
 加入标识符
 */
- (InteractiveResultModel * (^)(NSString *action))putAction
{
    __weak typeof(self)wself = self;
    InteractiveResultModel * (^ result)(NSString *action) = ^(NSString *action) {
        [super setObject:action forKey:action];
        return wself;
    };
    return result;
}

/**
 加入数据包
 */
- (InteractiveResultModel * (^)(NSString *key, id value))putData
{
    __weak typeof(self)wself = self;
    InteractiveResultModel * (^ result)(NSString *key, id value) = ^(NSString *key, id value) {
        [wself.sendData setValue:value forKey:key];
        [super setObject:wself.sendData forKey:data];
        return wself;
    };
    return result;
}

- (NSMutableDictionary *)sendData
{
    if (!_sendData) {
        _sendData = [NSMutableDictionary dictionary];
    }
    return _sendData;
}

@end
