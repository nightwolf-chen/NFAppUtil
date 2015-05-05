//
//  NFLoaderConfigCenter.h
//  NFAppUtil
//
//  Created by ChenJidong on 15/5/5.
//  Copyright (c) 2015年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NFHttpLoaderConfig;
@class NFHttpCmd;

@interface NFLoaderConfigCenter : NSObject

@property (nonatomic,strong) NSArray *configs;

+ (instancetype)sharedCenter;

- (void)setupConfigs;

- (NFHttpLoaderConfig *)configByCmd:(NFHttpCmd *)httpCmd;

@end
