//
//  NFHttpCmd.h
//  NFAppUtil
//
//  Created by ChenJidong on 15/5/5.
//  Copyright (c) 2015年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NFHttpCmd : NSObject

@property (nonatomic,copy) NSString *cmdId;

+ (id)cmdWithId:(NSString *)cmdId;

- (id)initWithId:(NSString *)cmdId;

@end
