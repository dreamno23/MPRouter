//
//  NSObject+MPDataBind.m
//  MPRouterTest
//
//  Created by zhangyu on 2017/11/13.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "NSObject+MPDataBind.h"
#import <objc/runtime.h>

void * kRouteParameterKey          =  &kRouteParameterKey;
void * kRouteProcessorHandlerKey   =  &kRouteProcessorHandlerKey;

@implementation NSObject (MPDataBind)
- (id)parameter
{
    return objc_getAssociatedObject(self, kRouteParameterKey);
}
- (void)setParameter:(id)param
{
    objc_setAssociatedObject(self, kRouteParameterKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(id data))processorCallback
{
    return objc_getAssociatedObject(self, kRouteProcessorHandlerKey);
}
- (void)setProcessorCallback:(void (^)(id data))callback
{
    objc_setAssociatedObject(self, kRouteProcessorHandlerKey, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
