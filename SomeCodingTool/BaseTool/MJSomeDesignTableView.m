//
//  MJSomeDesignTableView.m
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/21.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "MJSomeDesignTableView.h"
#import "SomeDesignTableViewCell.h"
@interface MJSomeDesignTableView()<UITableViewDelegate,UITableViewDataSource>
//初始表
@property(nonatomic,strong)UITableView *tableView;
//初始testData
@property(nonatomic,strong)NSMutableArray *dataArr;
@end
@implementation MJSomeDesignTableView
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}
-(MJSomeDesignTableView *)createTableViewInitWithFrame:(CGRect)frame withTableStyle:(NSInteger)style{
    [self testData];
    MJSomeDesignTableView *tempView =[self initWithFrame:frame];
    //处理添加是的Y轴问题
    CGFloat tableView_Y = 0;
    frame = CGRectMake(0, tableView_Y,frame.size.width, frame.size.height);
    _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    //去线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tempView addSubview:_tableView];
    return tempView;
}
-(void)testData{
    _dataArr = [NSMutableArray arrayWithArray:@[@"red",@"yellow"]];
}
#pragma mark ++++++++UITableViewDataSource,UITableViewDelegate++++++++++++++++
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SomeDesignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SomeDesignTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    cell.backgroundColor = [UIColor clearColor];
//    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame]; 点击的背景颜色
//    cell.selectedBackgroundView.backgroundColor =  KColor_Sensor_CellSelected;
    cell.designType = normalCellType;
    NSString *colorStr = self.dataArr[indexPath.row];
    if ([colorStr isEqualToString:@"red"]) {
      cell.backgroundColor = UIColor.redColor;
    }
    else {
     cell.backgroundColor = UIColor.yellowColor;
    }
    return cell;
}
//点击cell 处理选中状态
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了cell");
    [self someDesignForClickSelect:indexPath];
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//估计cell的高度
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 80;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
         return 80;
    }
    else {
        return 100;
    }

}

/// 点击状态记录数据源处理部分
/// @param indexPath 点击当前的Cell
-(void)someDesignForClickSelect:(NSIndexPath *)indexPath {
    //处理数据源 刷新对应的cell
    NSString *colorStr = self.dataArr[indexPath.row];
    if ([colorStr isEqualToString:@"red"]) {
        colorStr =@"yellow";
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:colorStr];
    }
    else {
        colorStr =@"red";
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:colorStr];
    }
    //刷新对应行
    NSArray *arr =@[indexPath];
    [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationNone];
    //[self.tableView reloadData];
}

/// cell移动数据源处理部分
/// @param indexPath 点击当前的Cell
-(void)someDesignForMoveSelect:(NSIndexPath *)indexPath{

}
@end
