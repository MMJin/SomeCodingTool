//
//  BaseNavController.m
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/16.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
}
-(void)setNav{
    //修改title字体大小
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[[UIColor blackColor] colorWithAlphaComponent:0.8]};
    UIView *navigationview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,375, 64)];
    navigationview.backgroundColor = UIColor.yellowColor;
    [self.view addSubview:navigationview];

    //去除导航栏下的黑线
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar];
    navBarHairlineImageView.hidden = YES;

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.tag = 600;
    backBtn.frame = CGRectMake(12, 32, 20, 20);
    NSString *backImage = @"back_nav";
    //    if (backImageName.length > 0) {
    //        backImage = backImageName;
    //        self.isBack = NO;
    //    }
    [backBtn setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationview addSubview:backBtn];
}
-(void)backAction {
    NSLog(@"back");
}
//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
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
