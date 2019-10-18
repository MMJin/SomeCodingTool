//
//  NSMutableDictionary+JSData.h
//  AirConditioningControl
//
//  Created by FCNC05 on 2019/7/19.
//  Copyright © 2019 Weidongsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (JSData)
///错误码
@property (nonatomic,copy)NSString *errCode;
///错误信息
@property (nonatomic,copy)NSString *errMsg;
///返回JS，回调标识符
@property (nonatomic,copy)NSString *action;
///数据包
@property (nonatomic,copy)NSString *data;

//@property (nonatomic,strong)NSMutableDictionary *sendData;

/**
 创建实体类

 @return 创建的实体
 */
+(instancetype)create;
/**
 加入错误码
 */
-(NSMutableDictionary * (^)(int))putErrCode;
/**
 加入错误信息
 */
-(NSMutableDictionary * (^)(NSString *errMsg))putErrMsg;
/**
 加入标识符
 */
-(NSMutableDictionary * (^)(NSString * action))putAction;
///**
// 加入数据包
// */
//-(NSMutableDictionary * (^)(NSString *key,id value))putData;
@end

NS_ASSUME_NONNULL_END
