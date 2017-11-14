//
//  MPService.h
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MPComponent.h"

@interface MPService : NSObject


@property (nonatomic, strong, readonly) MPComponent *container;

@property (nonatomic, strong, readonly) NSArray <MPComponent *> *components;

@property (nonatomic, copy, readonly) NSString *fragment;

+ (MPService *)serviceWithContainerKey:(NSString *)key
                             parameter:(id)param
                       fragment:(NSString *)fragment;

- (void)addCompoentWithKey:(NSString *)key parameter:(id)param;

#pragma mark -dynVC
@property (nonatomic, weak) id generatedValue;

@end
