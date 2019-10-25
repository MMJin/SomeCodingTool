//
//  SomeDesignTableViewCell.m
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/21.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "SomeDesignTableViewCell.h"
//关于高可以是在动态计算高的时候和cell初始话时传进来的用同一个计算方式
@implementation SomeDesignTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor = UIColor.redColor;
        //self.cellHight = cellHight;
        [self creatView];
    }
    return self;
}
-(void)creatView{
    NSLog(@"%.f--%.f",self.frame.size.height,self.contentView.frame.size.height);
    self.labTitle = [[UILabel alloc]init];
    self.labTitle.frame = CGRectMake(10, 0,100 ,_cellHight);
    self.labTitle.text = @"1-00 abcdhdgshsnvdjd";
    self.labTitle.textColor = UIColor.whiteColor;
    self.labTitle.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:self.labTitle];

    self.btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnNext.frame = CGRectMake(100 - 44 - 2, 20,40,40);
    [self.btnNext setImage:[UIImage imageNamed:@"sensor_cell_arrow"] forState:UIControlStateNormal];
    //self.btnNext.userInteractionEnabled = NO;
    [self.btnNext addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    self.btnNext.backgroundColor = UIColor.greenColor;
    //[self.btnNext addTarget:self action:@selector(clickBtnq:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnNext];

    UILabel *linelab = [[UILabel alloc]init];
    linelab.frame = CGRectMake(0, 44 - 1, 100, 1);
    linelab.backgroundColor = UIColor.yellowColor;;
    [self.contentView addSubview:linelab];
}
-(void)butClick {
    NSLog(@"点击了btn");
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
