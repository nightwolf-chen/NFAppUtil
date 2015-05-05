//
//  NFLoaderConfigCenter.m
//  NFAppUtil
//
//  Created by ChenJidong on 15/5/5.
//  Copyright (c) 2015年 nirvawolf. All rights reserved.
//

#import "NFLoaderConfigCenter.h"
#import "NFHttpCmd.h"
#import "NFHttpLoaderConfig.h"

@interface NFLoaderConfigCenter ()

@property (nonatomic,strong) NSCache *configCache;

@end

@implementation NFLoaderConfigCenter

+ (instancetype)sharedCenter
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[NFLoaderConfigCenter alloc] init];
    });
    
    return s_instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _configCache = [[NSCache alloc] init];
        [self setupConfigs];
    }
    
    return self;
}


- (NFHttpLoaderConfig *)configByCmd:(NFHttpCmd *)httpCmd
{
    NFHttpLoaderConfig *config = [_configCache objectForKey:httpCmd.cmdId];
    if (config) {
        return config;
    }
    
    for(NFHttpLoaderConfig *anotherConfig in _configs){
        if ([anotherConfig.httpCmd.cmdId isEqual:httpCmd.cmdId]) {
            return anotherConfig;
        }
    }
    
    return nil;
}

- (void)setupConfigs
{
    _configs = @[];
}

@end
