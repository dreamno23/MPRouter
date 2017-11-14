//
//  MPServiceStack.h
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPService.h"

@interface MPServiceStack : NSObject


- (BOOL)canPop;

- (MPService *)top;

- (void)levelDown;

- (void)levelUpWithService:(MPService *)service;

- (void)push:(MPService *)sevice;

- (void)pop;

- (void)popToGenValue:(id)generatedValue;


- (MPService *)serviceWithKey:(NSString *)key;

@end
