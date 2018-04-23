# MPRouter   #
URL routing library for iOS with a simple API based Objective-C

# 介绍： #
/**
MP 页面路由,用于分割各个跳转组件！

并组合 深度链接和app内的页面路由

URL协议，RFC1738

协议://用户名:密码@host:端口号/目录/文件名.文件后缀?参数=值#标志

MPRouter 暂时使用 协议://host/目录/文件名.文件后缀?参数=值#标志

host：

1、当host为 associate_domains 内的设置值时,不适用，取目录为 目标控制器的key

2、当host不为associate_domains的设置值时， host为 目标控制器的key

3、key对应的控制器可能是ViewController/NavigationController

通过URLParser解析出 container和 components，当存在components，即判断container为 NavigationController,并配置components为其子控制器
如果解析出只有container，判定为直接使用的ViewController

4、URLParser可自定义，用于 根据 url-query 字符串自定义 传递参数，通过“parserQueryDictionaryWithString：”，该参数会直接传递给url对应的控制器

5、目标控制器 可直接通过"mpGetRouterParameter(self)"读取 接收到的参数

6、目标控制器 可以通过调用回调block"mpGetRouterCallback(self)"向调用者 回调值

7、可通过 transform，自定义转场动画或者逻辑
8、test
*/


### 路由接口：MPRouter ###
```objc
/**
配置 key 及对应的控制器的 String名称
@param configFilePath 配置文件路径,可以是 沙盒内的文件，实现服务器实时更新!
@param error 错误
*/
- (void)configWithPath:(NSString *)configFilePath error:(NSError **)error;

//配置 通用链接 域名, 比如 "www.zhy.com"
- (void)configAssociaeDomains:(NSArray <NSString *> *)domains;

//设置根控制URL
- (BOOL)setRooteURL:(NSURL *)url;
- (BOOL)setRooteURLString:(NSString *)urlStr;

//跳转路由
- (BOOL)addRoute:(NSURL *)url;
- (BOOL)addRouteString:(NSString *)urlStr;

//跳转路由，如果需要目标返回处理值，传入 handler
- (BOOL)addRoute:(NSURL *)url withDataHandler:(void (^)(id param))handler;
- (BOOL)addRouteString:(NSString *)urlStr withDataHandler:(void (^)(id param))handler;
```

### 基础使用： ###
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.
NSString *routerConfig = [[NSBundle mainBundle]pathForResource:@"VCKeyMapConfig" ofType:@"plist"];
[[MPRouter sharedInstance] configWithPath:routerConfig error:nil];
[[MPRouter sharedInstance] configAssociaeDomains:@[@"www.zhy.com"]];

//    [[MPRouter sharedInstance] setRooteURLString:@"scheme://www.zhy.com/rootnavi/main"];
[[MPRouter sharedInstance] setRooteURLString:@"//rootnavi/main"];
//    [[MPRouter sharedInstance] setRooteURLString:@"//main"];
return YES;
}
```

### 跳转及回调返回值 ###
```objc
- (void)onBtn
{
[MPRouterGloble addRouteString:@"scheme://www.zhy.com/detail.b?key=detail#present" withDataHandler:^(id param) {
NSLog(@"get return value %@",param);
}];
}
- (void)onBtn1
{
[MPRouterGloble addRouteString:@"scheme://detail.b?key=detail#push" withDataHandler:^(id param) {
NSLog(@"get return value %@ onBtn1",param);
}];
}
- (void)onBtn2
{
[MPRouterGloble addRouteString:@"//www.zhy.com/detail#present"];
}
```

### 接收参数： ###
```objc
/**
获取传递的参数

@param object 需要获取的对象
@return 该对象绑定的参数值
*/
id mpGetRouterParameter(NSObject *object);
```
last go.

