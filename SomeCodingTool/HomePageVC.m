//
//  HomePageVC.m
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/16.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "HomePageVC.h"
#import "MJSomeDesignTableView.h"
@interface HomePageVC ()

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.view.backgroundColor = UIColor.whiteColor;
#warning mark 这里发现init的话tableview会变成不可点击 而在图层方面并没有遮罩什么的 也就是存在初始化影响（关于alloc 是内存分配和对象指针生成，而init只是生成返回对象 即内存调用对象方法，方法内存再初始化）[一个人和他的家差不多的关系]
    MJSomeDesignTableView *tableView = [[MJSomeDesignTableView alloc]createTableViewInitWithFrame:CGRectMake(0, 64, 375, 500) withTableStyle:0];
    //tableView.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:tableView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
