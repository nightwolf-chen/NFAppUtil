//
//  NFHttpLoaderFactory.m
//  WashingUser
//
//  Created by nirvawolf on 18/1/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//

#import "NFHttpLoaderFactory.h"

#import "NFHttpLoader.h"
#import "NFHttpCmd.h"
#import "NFLoaderConfigCenter.h"
#import "NFHttpLoaderConfig.h"

@implementation NFHttpLoaderFactory

+ (id)sharedInstance
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] init];
    });
    
    return s_instance;
}

- (NFHttpLoader *)createLoaderWithCmd:(NFHttpCmd *)httpCmd
{
    NFHttpLoader *loader =[NFHttpLoader loader];
    NFHttpLoaderConfig *config = [[NFLoaderConfigCenter sharedCenter] configByCmd:httpCmd];
    
    if (config) {
        loader.requestMethod = config.method;
        loader.requestUrl = config.url;
        [loader addContentType:config.contentType];
    }else{
        NSAssert(NO, @"Cannot find NFHttpLoader cmd!");
    }
    
    return loader;
}

@end
