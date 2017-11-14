//
//  MPRouter.m
//  MPRouter
//
//  Created by zhangyu on 2017/11/14.
//  Copyright © 2017年 Michong. All rights reserved.
//

#import "MPRouter.h"
#import "MPServiceStack.h"
#import "MPURLParserExt.h"
#import "MPTransformExt.h"
#import "NSObject+MPDataBind.h"

static NSString *const kMPRouterErrorDomain = @"com.mprouter.zhy";

static NSString *const kAssociateDomainsKey = @"com.apple.developer.associated-domains";
@interface MPRouter ()

@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *servicesKeyMap;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *associateDomainsMap;
@end
@implementation MPRouter {
    MPServiceStack *serviceStack_;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        serviceStack_ = [MPServiceStack new];
        self.parser = [MPURLParserExt new];
        self.transform = [MPTransformExt new];
    }
    return self;
}

+ (MPRouter *)sharedInstance
{
    static MPRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MPRouter alloc]init];
    });
    return instance;
}

#pragma mark -private
- (Class)_vcClassForServiceKey:(NSString *)aKey
{
    NSString *classString = [self.servicesKeyMap objectForKey:aKey];
    return NSClassFromString(classString);
}
- (MPService *)_serviceWithURL:(NSURL *)url
{
//    NSString *scheme = [url scheme];
    
    NSString *relativePath = [url host];
    if ([self.associateDomainsMap objectForKey:[url host]]) {
        relativePath = [url relativePath];
    } else if ([url relativePath].length > 0) {
        relativePath = [[url host] stringByAppendingString:[url relativePath]];
    }
    
    NSString *path = nil;
    NSArray *components = nil;
    NSString *ext = nil;
    BOOL parsered = [self.parser parserPath:relativePath container:&path components:&components extension:&ext];
    if (!parsered) {
        return nil;
    }
    NSString *fragment= [self.parser fragmentWithUrl:url];
    id param = [self.parser parserQueryDictionaryWithString:[url query]];

//    NSString *m_path = nil;
//    id m_param = nil;
//    [self.parser parserString:path toPath:&m_path param:&m_param];
//    if (!param) {
//        param = m_param;
//    }
    MPService *service = [MPService serviceWithContainerKey:path parameter:param fragment:fragment];
    for (NSString *comp in components) {
//        NSString *c_path = nil;
//        id c_param = nil;
//        [self.parser parserString:comp toPath:&c_path param:&c_param];
//        [service addCompoentWithKey:c_path parameter:c_param];
        [service addCompoentWithKey:comp parameter:nil];
    }
    return service;
}

- (UIViewController *)_buildVCWithService:(MPService *)service
{
    Class _newClass = [self _vcClassForServiceKey:service.container.key];
#if DEBUG
    NSAssert(_newClass, @" url <%@> is invalid or not config in keysMap, please config it in FILE with  configWithPath:",service.container.key);
#endif
    UIViewController *_newVC = [[_newClass alloc] init];
    if (![_newVC isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    _newVC.parameter = service.container.parameter;
    
    if (service.components.count > 0 && [_newVC isKindOfClass:[UINavigationController class]]) {
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:0];
        for (MPComponent *com in service.components) {
            Class _subClass = [self _vcClassForServiceKey:com.key];
            UIViewController *_subVC = [[_subClass alloc] init];
            if (![_subVC isKindOfClass:[UIViewController class]]) {
                return nil;
            }
            _subVC.parameter = com.parameter;
            [vcs addObject:_subVC];
        }
        [(UINavigationController *)_newVC setViewControllers:vcs];
    }
    return _newVC;
}

#pragma mark -

- (void)configWithPath:(NSString *)configFilePath error:(NSError **)error
{
    NSDictionary *keysMap = [[NSDictionary alloc]initWithContentsOfFile:configFilePath];
    if (keysMap.count == 0) {
        *error = [NSError errorWithDomain:kMPRouterErrorDomain code:-1 userInfo:nil];
    }
    self.servicesKeyMap = [keysMap copy];
}
- (void)configAssociaeDomains:(NSArray <NSString *> *)domains
{
    if (domains.count > 0) {
        self.associateDomainsMap = [[NSMutableDictionary alloc]initWithCapacity:0];
        for (NSString *link in domains) {
            [self.associateDomainsMap setObject:@(YES) forKey:link];
        }
    }
}


- (BOOL)setRooteURL:(NSURL *)url
{
    MPService *service = [self _serviceWithURL:url];
    UIViewController *_newVC = [self _buildVCWithService:service];
    if (!_newVC) {
        return NO;
    }
    BOOL result = [self.transform mpTransformSetRoot:_newVC];
#if DEBUG
    NSAssert(result, @"please config correct prossor with : configTransformProcessor: in %@", NSStringFromSelector(_cmd));
#endif
    if (result) {
        service.generatedValue = _newVC;
        [serviceStack_ levelUpWithService:service];
    }
    return result;
}
- (BOOL)setRooteURLString:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    return [self setRooteURL:url];
}

- (BOOL)addRoute:(NSURL *)url
{
    return [self addRoute:url withDataHandler:nil];
}
- (BOOL)addRouteString:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    return [self addRoute:url];
}

- (BOOL)addRoute:(NSURL *)url withDataHandler:(void (^)(id param))handler
{
    MPService *service = [self _serviceWithURL:url];
    UIViewController *_newVC = [self _buildVCWithService:service];
    if (!_newVC) {
        return NO;
    }
    _newVC.processorCallback = handler;
    
    BOOL result = [self.transform mpTransformFrom:[serviceStack_ top].generatedValue to:_newVC fragment:service.fragment];
    
    if (result) {
        service.generatedValue = _newVC;
        [serviceStack_ push:service];
    }
    return result;
}
- (BOOL)addRouteString:(NSString *)urlStr withDataHandler:(void (^)(id param))handler
{
    NSURL *url = [NSURL URLWithString:urlStr];
    return [self addRoute:url withDataHandler:handler];
}

//pop or dismiss
- (BOOL)dismissRoute
{
    UIViewController *_newTopVC = [self.transform mpTransformDismiss:[serviceStack_ top].generatedValue];
    if (_newTopVC) {
        [serviceStack_ popToGenValue:_newTopVC];
    }
    return _newTopVC;
}

- (BOOL)popRoute
{
    UIViewController *_newTopVC = [self.transform mpTransformPop:[serviceStack_ top].generatedValue];
    if (_newTopVC) {
        [serviceStack_ popToGenValue:_newTopVC];
    }
    return _newTopVC;
}

- (BOOL)popOrDismiss
{
    BOOL result = [self popRoute];
    if (!result) {
        result = [self dismissRoute];
    }
    return result;
}
@end

id mpGetRouterParameter(NSObject *object)
{
    return object.parameter;
}

MPRouterValueCallback mpGetRouterCallback(NSObject *object)
{
    return object.processorCallback;
}
