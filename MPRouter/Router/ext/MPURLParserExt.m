//
//  MPURLParserExt.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "MPURLParserExt.h"

@implementation MPURLParserExt

- (BOOL)parserPath:(NSString *)path container:(NSString **)container components:(NSArray<NSString *> **)components extension:(NSString **)ext
{
    *ext = [path pathExtension];
    
    NSString *pbe = [path stringByDeletingPathExtension];
    NSArray *t_comps = [pbe pathComponents];
    
    NSArray *comps = t_comps;
    if (t_comps.count > 0 && [[t_comps firstObject] isEqualToString:@"/"]) {
        comps = [t_comps subarrayWithRange:NSMakeRange(1, t_comps.count - 1)];
    }
    if (comps.count == 0) {
        return NO;
    }
    *container = [comps firstObject];
    if (comps.count > 1) {
        *components = [comps subarrayWithRange:NSMakeRange(1, comps.count - 1)];
    }
    return YES;
}

- (id)parserQueryDictionaryWithString:(NSString *)queryStr
{
    NSMutableDictionary *queryDic = nil;
    if (queryStr.length > 0) {
        queryDic = [NSMutableDictionary dictionaryWithCapacity:0];
        NSArray *items = [queryStr componentsSeparatedByString:@"&"];
        for (NSString *item in items) {
            NSArray *keyValues = [item componentsSeparatedByString:@"="];
            if (keyValues.count != 2) {
                continue;
            }
            [queryDic setObject:keyValues[1] forKey:keyValues[0]];
        }
    }
    return queryDic;
}

//- (void)parserString:(NSString *)string toPath:(NSString **)path param:(id *)param
//{
//    *path = string;
//    *param = nil;
//    NSRange foundRange = [string rangeOfString:@"<"];
//    if (foundRange.location == NSNotFound) {
//        return;
//    }
//    NSString *paramStrOrigin = [string substringFromIndex:foundRange.location];
//    NSString *paramStr = [paramStrOrigin stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
//    *param = [self parserQueryDictionaryWithString:paramStr];
//    *path = [string substringToIndex:foundRange.location];
//}

- (NSString *)fragmentWithUrl:(NSURL *)url
{
    return [url fragment];
}
@end
