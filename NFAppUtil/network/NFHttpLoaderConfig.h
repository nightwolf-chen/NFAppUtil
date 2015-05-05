//
//  NFHttpLoaderConfig.h
//  NFAppUtil
//
//  Created by ChenJidong on 15/5/5.
//  Copyright (c) 2015年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

#include "NFHttpLoader.h"

@class NFHttpCmd;

@interface NFHttpLoaderConfig : NSObject

@property (nonatomic,strong) NFHttpCmd *httpCmd;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) NFHttpLoaderMethod method;
@property (nonatomic,copy) NSString *contentType;

@end
