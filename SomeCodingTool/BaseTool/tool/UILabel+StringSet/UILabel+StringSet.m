//
//  UILabel+StringSet.m
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/18.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "UILabel+StringSet.h"

@implementation UILabel (StringSet)

+(UILabel *)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font{
    UILabel *tempLab = [[UILabel alloc]init];
    // 最大允许绘制的文本范围
     CGSize size = CGSizeMake(width, 2000);
     //配置计算时的行截取方法,和contentLabel对应
     NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
     //设置行间距
     [style setLineSpacing:16];
     //配置计算时的字体的大小
     //配置属性字典
     NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:style};
     //计算
     //如果想保留多个枚举值,则枚举值中间加按位或|即可,并不是所有的枚举类型都可以按位或,只有枚举值的赋值中有左移运算符时才可以
     CGFloat height = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
     tempLab.frame = CGRectMake(0, 0, width, height);
     return tempLab;
}
/**

 * 　设置 UILabel、UIButton的删除线/下划线

 * mark = 0 删除线、= 1 下划线       应该是个View的

 */
+ (UILabel *)createLineInView:(UIView*)theView Mark:(NSInteger)mark {

    NSString*tempStr =@"";

    UIButton*tempBut;

    UILabel*tempLab;

    if ([[theView class] isSubclassOfClass:[UIButton class]]) {

        tempBut = (UIButton*)theView;

        tempStr = tempBut.titleLabel.text;

    }

    else if([[theView class]isSubclassOfClass:[UILabel class]]) {

        tempLab = (UILabel*)theView;

        tempStr = tempLab.text;

    }

    if(theView && ![tempStr isEqualToString:@""]) {

        // 获取字符串的长度

        NSUInteger length = [tempStr length];

        // 设置富文本的属性

        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:tempStr];

        if(mark ==1) {

            // 下划线

            [attri addAttribute:NSUnderlineStyleAttributeName

                          value:@(NSUnderlineStyleSingle)

                          range:NSMakeRange(0, length)];

        }else{

            // 删除线

            [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleSingle)  range:NSMakeRange(0, length)];

        }

        if(tempBut) {

            [tempBut setAttributedTitle:attri forState:UIControlStateNormal];

        }

        else if(tempLab) {

            [tempLab setAttributedText:attri];

        }
    }
    return tempLab;

}
- (UILabel*)redXingWithLabel:(UILabel*)tempLabel atIndex:(NSInteger)tempIndex lenth:(NSInteger)lenth stringColor:(UIColor*)color fontOfSize:(CGFloat)font dataArr:(NSMutableArray*)dataArr{

    NSMutableAttributedString * tempString = [[NSMutableAttributedString alloc] initWithString: tempLabel.text];



    if(dataArr.count>1) {

        for(NSMutableArray*data in dataArr) {

            NSString*tempIndexStr = data[0];

            tempIndex = [tempIndexStr integerValue];

            NSString*lenthStr = data[1];

            lenth =[lenthStr integerValue];

            NSString*fontStr = data[2];

            font =[fontStr integerValue];

            [tempString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(tempIndex, lenth)];

            [tempString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(tempIndex, lenth)];

            //调整行间距

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

            [paragraphStyle setLineSpacing:10];

            paragraphStyle.lineBreakMode= tempLabel.lineBreakMode;

            //保留原有的对齐方式

            paragraphStyle.alignment= tempLabel.textAlignment;

            [tempString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [tempLabel.text length])];

        }

        tempLabel.attributedText= tempString;

    }

    else{

        [tempString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(tempIndex, lenth)];

        [tempString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(tempIndex, lenth)];

        tempLabel.attributedText= tempString;

    }

    return tempLabel;
}
@end
