//
//  WUNetworkService.m
//  WashingUser
//
//  Created by nirvawolf on 18/1/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//

#import "NFNetworkService.h"
#import "NFHttpLoader.h"
#import "NFhttpCmd.h"

dispatch_queue_t queue;
dispatch_queue_t get_queue(){
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.nirvawolf.MyQueue", NULL);
    });
    return queue;
}

@interface NFNetworkService ()
@property (nonatomic,strong) NSMutableDictionary *loaders;
@property (nonatomic,strong) NSMutableDictionary *callbacks;
@end

@implementation NFNetworkService

+ (id)sharedInstance
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _loaders = [NSMutableDictionary dictionary];
        _callbacks = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (AFNetworkReachabilityStatus)networkReachility
{
    return [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
}


- (void)sendReqeustWithCmdId:(NSString *)name
                      params:(NSDictionary *)params
                  completion:(NFHttpLoaderCompletion)completionBlock
{
    dispatch_async(get_queue(), ^{
        
        NFHttpLoader *loader = _loaders[name];
        NFHttpCmd *httpCmd =  [NFHttpCmd cmdWithId:name];
        if (!loader) {
            loader = [[NFHttpLoaderFactory sharedInstance] createLoaderWithCmd:httpCmd];
            _loaders[name] = loader;
        }
        
        [self addCallback:completionBlock name:name];
        
        __weak id weakSelf = self;
        [loader load:[self paramsWithHeader:params] completion:^(NFHttpLoader *loader, NFHttpResponse *response){
            [weakSelf notifyCallbacksLoader:loader response:response cmdId:name];
        }];
        
    });
}

- (NSDictionary *)paramsWithHeader:(NSDictionary *)params
{
    return params;
}

- (void)addCallback:(NFHttpLoaderCompletion)aCallback name:(NSString *)name
{
    NSMutableArray *callbacks = _callbacks[name];
    if (!callbacks) {
        callbacks = [NSMutableArray array];
        _callbacks[name] = callbacks;
    }
    
    [callbacks addObject:aCallback];
}

- (void)notifyCallbacksLoader:(NFHttpLoader *)loader response:(NFHttpResponse *)response cmdId:(NSString *)cmdId
{
    NSString *name = cmdId;
    
    NSArray *callbacks = _callbacks[name];
    
    for(NFHttpLoaderCompletion callBack in callbacks){
        callBack(loader,response);
    }
    
    [_callbacks removeObjectForKey:name];
}

@end
