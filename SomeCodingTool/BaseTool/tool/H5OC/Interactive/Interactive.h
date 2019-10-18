//
//  Interactive.h
//  test
//
//  Created by fcna03 on 2019/7/16.
//  Copyright © 2019 fujisoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Interactive : NSObject
/**
 根据从JS获得的数据生成返信数据

 @param recieveData 从JS获得的数据
 @param detailModel 从P板获得的睡眠传感器数据
 @return 需要返回给JS的JSON数据
 */
- (NSString *)javaScriptRunHandler:(nonnull InteractiveModel *)recieveData withSleepSensorDetail:(NSObject *)detailModel withSleepSensorLinkageSetModel:(NSObject *)setWebModel withRequestStatus:(int)status;

@end

NS_ASSUME_NONNULL_END
