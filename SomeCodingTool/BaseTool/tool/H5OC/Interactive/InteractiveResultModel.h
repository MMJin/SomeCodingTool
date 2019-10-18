//
//  InteractiveResultModel.h
//  test
//
//  Created by fcna03 on 2019/7/16.
//  Copyright © 2019 fujisoft. All rights reserved.
//

#import <Foundation/Foundation.h>


///错误码
static NSString *errCode = @"errCode";
///错误信息
static NSString *errMsg = @"errMsg";
///返回JS，回调标识符
static NSString *action = @"action";
///数据包
static NSString *data = @"data";

NS_ASSUME_NONNULL_BEGIN

@interface InteractiveResultModel : NSMutableDictionary

@property (nonatomic,strong)NSMutableDictionary *sendData;




/**
 创建实体类

 @return 创建的实体
 */
+(instancetype)create;
/**
 加入错误码
 */
-(InteractiveResultModel * (^)(int))putErrCode;
/**
 加入错误信息
 */
-(InteractiveResultModel * (^)(NSString *errMsg))putErrMsg;
/**
 加入标识符
 */
-(InteractiveResultModel * (^)(NSString * action))putAction;
/**
 加入数据包
 */
-(InteractiveResultModel * (^)(NSString *key,id value))putData;

@end

NS_ASSUME_NONNULL_END
