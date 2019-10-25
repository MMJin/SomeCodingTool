//
//  MJSomeDesignTableView.h
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/21.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJSomeDesignTableView : UIView
//创建表的基本结构 大小 线
-(MJSomeDesignTableView *)createTableViewInitWithFrame:(CGRect)frame withTableStyle:(NSInteger)style;
@end

NS_ASSUME_NONNULL_END
