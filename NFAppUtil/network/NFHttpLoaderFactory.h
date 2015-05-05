//
//  NFHttpLoaderFactory.h
//  WashingUser
//
//  Created by nirvawolf on 18/1/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NFHttpLoader;
@class NFHttpCmd;

@interface NFHttpLoaderFactory : NSObject

+ (id)sharedInstance;

- (NFHttpLoader *)createLoaderWithCmd:(NFHttpCmd *)httpCmd;

@end
