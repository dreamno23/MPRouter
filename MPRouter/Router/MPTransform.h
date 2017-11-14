//
//  MPTransform.h
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MPTransform <NSObject>

/* 设置rootViewController
 MPRouter->setRooteURL：
 return 成功返回true，失败返回false
*/
- (BOOL)mpTransformSetRoot:(UIViewController *)root;

/* 跳转
 MPRouter
 MPRouter->addRoute:
 MPRouter->addRoute:withDataHandler:
 return 成功返回true，失败返回false
 */
- (BOOL)mpTransformFrom:(UIViewController *)from to:(UIViewController *)to fragment:(NSString *)fragment;

/*dissmiss
 MPRouter->dismissRoute
 return 方法调用完成后的顶部 视图控制器
 调用失败，返回nil
 */
- (UIViewController *)mpTransformDismiss:(UIViewController *)vc;

/*
 MPRouter->popRoute
 return 方法调用完成后的顶部 视图控制器
 调用失败，返回nil
 !important:  导航控制器的子控制器只有一个的时候，必须返回导航控制器
 */
- (UIViewController *)mpTransformPop:(UIViewController *)vc;

@end
