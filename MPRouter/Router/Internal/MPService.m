//
//  MPService.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "MPService.h"

@interface MPService()

@property (nonatomic, strong) MPComponent *container;

@property (nonatomic, copy) NSString *fragment;
@end

@implementation MPService

+ (MPService *)serviceWithContainerKey:(NSString *)key
                             parameter:(id)param
                              fragment:(NSString *)fragment
{
    MPService *service = [MPService new];
    MPComponent *component = [MPComponent componentWithKey:key parameter:param];
    service.container = component;
    service.fragment = fragment;
    return service;
}

- (void)addCompoentWithKey:(NSString *)key parameter:(id)param
{
    if (!_components) {
        _components = [[NSMutableArray alloc]initWithCapacity:0];
    }
    MPComponent *component = [MPComponent componentWithKey:key parameter:param];
    [(NSMutableArray *)_components addObject:component];
}
@end
