//
//  NFHttpCmd.m
//  NFAppUtil
//
//  Created by ChenJidong on 15/5/5.
//  Copyright (c) 2015年 nirvawolf. All rights reserved.
//

#import "NFHttpCmd.h"

@implementation NFHttpCmd

- (id)initWithId:(NSString *)cmdId
{
    if (self = [super init]) {
        _cmdId = cmdId;
    }
    
    return self;
}

+ (id)cmdWithId:(NSString *)cmdId
{
    return [[[self class] alloc] initWithId:cmdId];
}

@end
