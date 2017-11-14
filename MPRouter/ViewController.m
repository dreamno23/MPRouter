//
//  ViewController.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "ViewController.h"
#import "MPRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 100, 80, 30)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"Detail0" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(100, 150, 80, 30)];
    [btn1 setBackgroundColor:[UIColor grayColor]];
    [btn1 setTitle:@"Detail1" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setFrame:CGRectMake(100, 200, 80, 30)];
    [btn2 setBackgroundColor:[UIColor grayColor]];
    [btn2 setTitle:@"Detail2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)onBtn
{
    [MPRouterGloble addRouteString:@"scheme://www.zhy.com/detail.b?key=detail#present" withDataHandler:^(id param) {
        NSLog(@"get return value %@",param);
    }];
}
- (void)onBtn1
{
    [MPRouterGloble addRouteString:@"scheme://detail.b?key=detail#push" withDataHandler:^(id param) {
        NSLog(@"get return value %@ onBtn1",param);
    }];
}
- (void)onBtn2
{
    [MPRouterGloble addRouteString:@"//www.zhy.com/detail#present"];
}
@end
