//
//  SomeDesignTableViewCell.h
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/21.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum :int
{
    normalCellType = 0,
    otherCelltype = 1,
}CellType;
NS_ASSUME_NONNULL_BEGIN
typedef void (^blockName)(NSString *can1,NSString *can2);
@interface SomeDesignTableViewCell : UITableViewCell
/**
 标题内容
 */
@property(nonatomic,strong)UILabel *labTitle;
//箭头
@property(nonatomic,strong)UIButton *btnNext;
//高度
@property(nonatomic,assign)CGFloat cellHight;
//cell的设计类型样式
@property(nonatomic,assign)CellType designType;
//点击的结果
@property(nonatomic,copy)blockName result;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withCellHight:(CGFloat)cellHight;
@end

NS_ASSUME_NONNULL_END
