//
//  HomePageVC.m
//  SomeCodingTool
//
//  Created by FCNC05 on 2019/10/16.
//  Copyright © 2019 FCNC05. All rights reserved.
//

#import "HomePageVC.h"
#import "MJSomeDesignTableView.h"
#import "MMJKeepAliveThread.h"
@interface HomePageVC ()
/** 用于判断销毁线程 */
@property (nonatomic, assign) BOOL stopping;
/** 保存线程 */
@property (nonatomic, strong) MMJKeepAliveThread *myThread;


/** 是否退出线程 */
@property(nonatomic, assign) BOOL isExitThread;
/** 保存线程将要执行的任务 */
@property(nonatomic, copy) void(^myTask)(void);
/** 条件锁 */
@property(nonatomic, strong) NSCondition *condition;

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

    [self test_3];
}
/** 定时器保活子线程 */
- (void)test_1  {
    self.stopping = NO;
    MMJKeepAliveThread* thread = [[MMJKeepAliveThread alloc] initWithBlock:^{
        // 此处创建定时器是为了保活线程
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"子线程定时器任务");
            if (self.stopping) {
                [NSThread exit];
            }
        }];
        [[NSRunLoop currentRunLoop] run];
        /* 另一种使用timer 启动 RunLoop 的写法
        NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"子线程定时器任务");
            if (self.stopping) {
                [NSThread exit];
            }
        }];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
         */
    }];
    [thread start];
    self.myThread = thread;
}
/** 子线程任务 */
- (void)subThreadTask {
    for (int i=0; i<10; i++) {
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"%@ ----子线程任务 %ld", [NSThread currentThread], (long)i);
    }
}
/** 触摸时，给常驻线程添加任务 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(subThreadTask) onThread:self.myThread withObject:nil waitUntilDone:NO];
//测试3的
    self.myTask = ^{
        NSLog(@"条件锁常驻线程 %@", NSThread.currentThread);
    };
    [self.condition signal];
    //self.isExitThread = YES;
}
- (void)test_2 {
    MMJKeepAliveThread *subThread = [[MMJKeepAliveThread alloc] initWithTarget:self selector:@selector(startRunloop) object:nil];
    [subThread setName:@"com.kpp.mythread"];
    [subThread start];
    self.myThread = subThread;
}
/* 启动子线程 RunLoop */
- (void)startRunloop {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //如果注释了下面这一行，子线程中的任务并不能正常执行
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        NSLog(@"子线程RunLoop启动前 ===> %@", [NSThread currentThread]);
        [runLoop run];
    }
}
/** 子线程任务 */
//- (void)subThreadTask {
//    for (int i=0; i<10; i++) {
//        [NSThread sleepForTimeInterval:1.0];
//        NSLog(@"%@ ----子线程任务 %ld", [NSThread currentThread], (long)i);
//    }
//}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
////    self.stopping = YES;
//    [self performSelector:@selector(subThreadTask) onThread:self.myThread withObject:nil waitUntilDone:NO];
//}


/** 条件锁保活子线程 */
- (void)test_3 {
    self.condition = [[NSCondition alloc] init];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(conditionThread) object:nil];
    thread.name = @"com.kpp.conditionThread";
    [thread start];
}
/** 让子线程任务进入闲等状态 */
- (void)conditionThread {
    @autoreleasepool {
        do {
            [self.condition lock];
            if (self.myTask) {
                self.myTask();
                self.myTask = nil;
            }
            [self.condition wait];
            [self.condition unlock];
        } while (!self.isExitThread);
    };
}

@end
