//
//  InteractiveModel.h
//  test
//
//  Created by fcna03 on 2019/7/16.
//  Copyright © 2019 fujisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractiveResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InteractiveModel : NSObject

///动作
@property (nonatomic, strong) NSString *action;

///参数prarms
@property (nonatomic, strong) NSMutableDictionary *data;

/**
 根据模型生成数组
 */
+ (instancetype)creatModelWith:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
