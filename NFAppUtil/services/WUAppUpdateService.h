//
//  WUAppUpdateService.h
//  WashingUser
//
//  Created by nirvawolf on 1/2/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WUAppUpdateService : NSObject

+ (id)sharedInstance;

- (void)startCheck:(void (^)(BOOL,BOOL))completionBlock;
- (void)gotoLatestVersion;

@end
