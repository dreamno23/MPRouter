//
//  NSObject+MPDataBind.h
//  MPRouterTest
//
//  Created by zhangyu on 2017/11/13.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MPDataBind)

- (id)parameter;
- (void)setParameter:(id)param;

- (void (^)(id data))processorCallback;
- (void)setProcessorCallback:(void (^)(id data))callback;


@end
