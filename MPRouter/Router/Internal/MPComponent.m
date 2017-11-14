//
//  MPComponent.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "MPComponent.h"

@interface MPComponent()
@property (nonatomic, copy) NSString *key;
@property (nonatomic, strong) id parameter;
@end

@implementation MPComponent
+ (MPComponent *)componentWithKey:(NSString *)key
                        parameter:(id)param
{
    MPComponent *component = [MPComponent new];
    component.key = key;
    component.parameter = param;
    return component;
}
@end
