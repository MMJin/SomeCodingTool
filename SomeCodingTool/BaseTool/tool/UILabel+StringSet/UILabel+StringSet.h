//
//  UILabel+StringSet.h
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/18.
//  Copyright © 2019 FCNC05. All rights reserved.
//

//#import <AppKit/AppKit.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (StringSet)
//根据文字计算高度
+(UILabel *)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font;
//设置文本显示和字体设置，颜色设置，行间距设置

//下划线和删除线等
/// 设置下划线，删除线
/// @param theView 目标视图
/// @param mark mark = 0 删除线、= 1 下划线
+ (UILabel *)createLineInView:(UIView*)theView Mark:(NSInteger)mark;
@end

NS_ASSUME_NONNULL_END
