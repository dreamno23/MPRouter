//
//  DetailViewCtrl.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "DetailViewCtrl.h"
#import "MPRouter.h"

@interface DetailViewCtrl ()

@end

@implementation DetailViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"parameter = %@", mpGetRouterParameter(self));
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 100, 80, 30)];
    [btn setBackgroundColor:[UIColor grayColor]];
    [btn setTitle:@"点击回调" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
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
    
    MPRouterValueCallback callback = mpGetRouterCallback(self);
    if (callback) {
        callback(@"done");
    }
    [MPRouterGloble popOrDismiss];
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
