//
//  WUAppUpdateService.m
//  WashingUser
//
//  Created by nirvawolf on 1/2/15.
//  Copyright (c) 2015 WashingUser. All rights reserved.
//

#import "WUAppUpdateService.h"

#import "NFHttpLoader.h"
#import "NFHttpResponse.h"

#import <UIKit/UIKit.h>

@interface WUAppUpdateService ()
@property (nonatomic,strong) NFHttpLoader *updateLoder;
@property (nonatomic,copy) NSString *trackUrl;
@end

@implementation WUAppUpdateService

+ (id)sharedInstance
{
    static id s_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_instance = [[[self class] alloc] init];
    });
    
    return s_instance;
}

- (NSString *)p_appId
{
    return @"0";
}

- (NSString *)currentVersion
{
    NSDictionary *localDic =[[NSBundle mainBundle] infoDictionary];
    NSString *localVersion =[localDic objectForKey:@"CFBundleShortVersionString"];
    
    return localVersion;
}

- (NSString *)p_updateUrl
{
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",[self p_appId]];
    
    NSLog(@"Update url : %@",[self p_appId]);
    
    return url;
}


- (void)startCheck:(void (^)(BOOL, BOOL))completionBlock
{
    if (!_updateLoder) {
        _updateLoder = [NFHttpLoader loader];
        _updateLoder.requestUrl = [self p_updateUrl];
        _updateLoder.requestMethod = NFHttpLoaderMethodPOST;
        [_updateLoder addContentType:@""];
    }
    
    [_updateLoder load:@{} completion:^(NFHttpLoader *loader, NFHttpResponse *response){
        if (response.success) {
            NSDictionary *rightDic = response.obj;
            NSArray *results = rightDic[@"results"];
            if (results.count > 0) {
                NSDictionary *resultDic = results[0];
                //获取appstore最新的版本号
                NSString *newVersion = [resultDic objectForKey:@"version"];
                //获取应用程序的地址
                self.trackUrl = [resultDic objectForKey:@"trackViewUrl"];
                if ([newVersion isEqual:[self currentVersion]]) {
                    [self notify:completionBlock suc:YES needUpdate:NO];
                }else{
                    [self notify:completionBlock suc:YES needUpdate:YES];
                }
            }else{
                [self notify:completionBlock suc:YES needUpdate:NO];
            }
            
        }else{
            [self notify:completionBlock suc:NO needUpdate:NO];
        }
    }];
    
    
}

- (void)notify:(void (^)(BOOL, BOOL))completionBlock suc:(BOOL)suc needUpdate:(BOOL)needUpdate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock(suc,needUpdate);
    });
}

- (void)gotoLatestVersion
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackUrl]];
}

@end
