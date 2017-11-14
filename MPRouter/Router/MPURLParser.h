//
//  MPURLParser.h
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 URL 解析
 
 scheme://$container/[$compoent]/[$compoent].$ext?$param#$fragment
 $component = vc2<key=value&key2=value2> = $path<$param>
 URL: {}和<>内为可选内容, <>为对应path的 参数
 
 eg:
 scheme1://main{.c}{?value=1&name=2}{#push}
 scheme2://navi/{vc1<key=value>}/{vc2<key=value&key2=value2>}{?key=value}{#present}

 作用：
 $container:
 main 或者 navi 对应配置文件对应的视图控制器类
 参数来源: $param /
 
 $compoent:
 子组件，当$container 对应一个UINavigationController时，需要配置子控制器,一个或者多个
 参数来源："<>"内的内容
 
 $ext:
 扩展：todo
 
 $fragment:
 呈现方式，push？present？other custom
 
 !important
 配置文件设置：
 MPRouter->configWithPath:error:

 不支持对$container为UITabbarViewController时配置对应的子控制器
 */
@protocol MPURLParser <NSObject>
//$pathURL = //navi/vc1<name=1>/vc2<title=t>.html
/*
 $container = navi
 $components = [vc1<name=1>, vc2<title=t>]
 $ext = html
 */
- (BOOL)parserPath:(NSString *)path container:(NSString **)container components:(NSArray<NSString *> **)components extension:(NSString **)ext;

/* $queryStr = name=1&title=2
 return value
 */
- (id)parserQueryDictionaryWithString:(NSString *)queryStr;

//  main<name=1&title=2>   $path = name; $param = parser<name=1&title=2>
//- (void)parserString:(NSString *)string toPath:(NSString **)path param:(id *)param;

/* $url = scheme://main#push
 $return "push"
*/
- (NSString *)fragmentWithUrl:(NSURL *)url;
@end
