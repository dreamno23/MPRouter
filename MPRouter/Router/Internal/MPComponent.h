//
//  MPComponent.h
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPComponent : NSObject

@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, strong, readonly) id parameter;

+ (MPComponent *)componentWithKey:(NSString *)key
                        parameter:(id)param;

@end
