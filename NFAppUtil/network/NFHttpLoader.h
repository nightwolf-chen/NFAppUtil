//
//  NFHttpLoader.h
//  BeautifulGirls
//
//  Created by nirvawolf on 11/1/15.
//  Copyright (c) 2015 Nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NFHttpLoader;
@class NFHttpResponse;

typedef void (^NFHttpLoaderCompletion)(NFHttpLoader *loader ,NFHttpResponse *response);

typedef NS_ENUM(NSUInteger, NFHttpLoaderMethod){
    NFHttpLoaderMethodGET,
    NFHttpLoaderMethodPOST
};

@interface NFHttpLoader : NSObject
@property (nonatomic,assign) NFHttpLoaderMethod requestMethod;
@property (nonatomic,copy) NSString *requestUrl;

+ (id)loader;

- (id)init;

- (void) load:(NSDictionary *)param
   completion:(NFHttpLoaderCompletion)block;

- (void)addContentType:(NSString *)contentType;
- (void)addContentTypes:(NSArray *)contentTypes;

@end
