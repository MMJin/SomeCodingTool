//
//  BaseHeader.h
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/25.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#ifndef BaseHeader_h
#define BaseHeader_h

#import "HomePageVC.h"

#pragma mark _______________长宽_________________________________
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight            [UIScreen mainScreen].bounds.size.height
#define kScreenSize             [UIScreen mainScreen].bounds.size  //获取屏幕大小
#define kWidthRatio             (kIsIpad ? (kScreenSize.width / 1024.0) : (kScreenSize.width / 375.0))
#define kHeightRatio            (kIsIpad ? (kScreenSize.height / 768.0) :(kScreenSize.height / 667.0))

#pragma mark _______________字体大小设置_________________________________
#define kFont_17       ((kScreenSize.width == 1366) ? 21   : ((kScreenSize.width == 320) ? 15   : 17))

#pragma mark _______________颜色_________________________________
//16进制颜色
#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#define RGB(r,g,b) \
[UIColor \
colorWithRed:(r)\
green:(g) \
blue:(b)\
alpha:1.0]

#pragma mark _______________输出LOG_________________________________
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

#pragma mark _______________本地存取_________________________________
#define BaseUserDefaultsGET(key) [[NSUserDefaults standardUserDefaults] valueForKey:key] // 取
#define BaseUserDefaultsSET(object,key) [[NSUserDefaults standardUserDefaults] setValue:object forKey:key]  // 写
#define BaseUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize] // 存
#pragma mark _______________IPone_X判断_________________________________
//其中，反斜杠\并不是注释或者其它的无用符号，其实是多行宏换行必须要用的标志。
//最后一句tmp;\也是必须的，因为要将经过逻辑判断得到的tmp作为该宏的返回值。
// 重新设置刘海类型判断，原来的根据尺寸判断不能适应多种刘海机型判断。
#define kDevice_Is_iPhoneX      ({\
int isIphoneX = 0;\
if(@available(iOS 11.0, *)) {\
if(kIsIpad) {\
isIphoneX = 0;\
} else {\
if([UIApplication sharedApplication].windows[0].safeAreaInsets.bottom != 0) {\
isIphoneX = 1;\
}\
}\
}\
isIphoneX;\
})
#endif /* BaseHeader_h */
