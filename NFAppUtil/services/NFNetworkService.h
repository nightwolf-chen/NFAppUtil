//
//  WUNetworkService.h
//  WashingUser
//
//  Created by nirvawolf on 18/1/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//
#import <AFNetworking.h>

#import "NFHttpLoaderFactory.h"
#import "NFHttpLoader.h"

//@class WUNetworkResponse;

@interface NFNetworkService : NSObject

+ (id)sharedInstance;
- (AFNetworkReachabilityStatus)networkReachility;

/*
 {
 "pf": "android",
 "imei": "123",
 "pver": 1,
 "proid": "1",
 "resolution": "480_320",
 "version": "1.0.0",
 "vcode": 1,
 "phtype": "htc-g3",
 "extParam": {
 "status":"1"
 }
 }
 
 params: 只需要填写extParam里面的字段
 */
- (void)sendReqeustWithCmdId:(NSString *)cmdId
                     params:(NSDictionary *)params
                 completion:(NFHttpLoaderCompletion)completionBlock;

@end
