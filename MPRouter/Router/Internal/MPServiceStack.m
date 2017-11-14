//
//  MPServiceStack.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "MPServiceStack.h"

@interface MPServiceStack()

//二维数组
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *stack;

@property (nonatomic, weak) NSMutableArray *cur_stack_level;
@end

@implementation MPServiceStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stack = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)levelDown
{
    if (self.stack.count > 1) {
        [self.stack removeLastObject];
        self.cur_stack_level = self.stack.lastObject;
    }
}
- (void)levelUpWithService:(MPService *)service
{
    NSMutableArray *t = [[NSMutableArray alloc]initWithCapacity:0];
    [t addObject:service];
    [self.stack addObject:t];
    
    self.cur_stack_level = t;
}

- (MPService *)top
{
    return [self.cur_stack_level lastObject];
}

- (BOOL)canPop
{
    return self.cur_stack_level.count > 0;
}

- (void)push:(MPService *)sevice
{
    [self.cur_stack_level addObject:sevice];
}

- (void)pop
{
    if (self.cur_stack_level.count > 0) {
        [self.cur_stack_level removeLastObject];
    }
}

- (void)popToGenValue:(id)generatedValue
{
    if (!generatedValue) return;
    MPService *service = [self top];
    while (service.generatedValue != generatedValue && self.cur_stack_level.count > 1) {
        [self pop];
        service = [self top];
    }
}

- (MPService *)serviceWithKey:(NSString *)key
{
    if (key.length == 0) {
        return nil;
    }
    for (NSArray *subArray in self.stack) {
        for (MPService *service in subArray) {
            if ([service.container.key isEqualToString:key]) {
                return service;
            }
        }
    }
    return nil;
}
@end
