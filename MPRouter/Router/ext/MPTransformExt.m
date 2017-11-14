//
//  MPTransformExt.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "MPTransformExt.h"

@implementation MPTransformExt
- (BOOL)mpTransformSetRoot:(UIViewController *)root
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (!window) {
        window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [window makeKeyAndVisible];
        
        [[UIApplication sharedApplication].delegate setWindow:window];
    }
    
    [window setRootViewController:root];
    return root;
}

- (BOOL)mpTransformFrom:(UIViewController *)from to:(UIViewController *)to fragment:(NSString *)fragment
{
    UINavigationController *navi = from.navigationController;
    if ([from isKindOfClass:[UINavigationController class]]) {
        navi = (UINavigationController *)from;
    }
    if ([fragment isEqualToString:@"present"]) {
        [navi presentViewController:to animated:YES completion:nil];
    } else {
        [navi pushViewController:to animated:YES];
    }
    return navi;
}

- (UIViewController *)mpTransformDismiss:(UIViewController *)vc
{
    UIViewController *presetingVC = [vc presentingViewController];
    if (presetingVC == nil) {
        presetingVC = [vc.navigationController presentingViewController];
    }
    [presetingVC dismissViewControllerAnimated:YES completion:nil];
    return presetingVC;
}

- (UIViewController *)mpTransformPop:(UIViewController *)vc
{
    UINavigationController *navi = vc.navigationController;
    [navi popViewControllerAnimated:YES];
    return navi.viewControllers.count > 1 ? [navi topViewController] : navi;
}
@end
