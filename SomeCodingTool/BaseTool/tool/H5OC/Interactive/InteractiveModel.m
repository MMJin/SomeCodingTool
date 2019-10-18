//
//  InteractiveModel.m
//  test
//
//  Created by fcna03 on 2019/7/16.
//  Copyright © 2019 fujisoft. All rights reserved.
//

#import "InteractiveModel.h"

@implementation InteractiveModel

+(instancetype)creatModelWith:(NSDictionary *)dic{
    
    InteractiveModel *model = [[InteractiveModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return  model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
