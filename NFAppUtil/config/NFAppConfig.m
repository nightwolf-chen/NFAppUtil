//
//  WUAppConfig.m
//  WashingUser
//
//  Created by nirvawolf on 31/1/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//

#import "NFAppConfig.h"

@implementation NFAppConfig

+ (instancetype)sharedInstance
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[self alloc] init];
    });
    
    return s_instance;
}


@end
