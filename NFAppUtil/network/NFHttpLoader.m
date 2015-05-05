//
//  NFHttpLoader.m
//  BeautifulGirls
//
//  Created by nirvawolf on 11/1/15.
//  Copyright (c) 2015 Nirvawolf. All rights reserved.
//

#import "NFHttpLoader.h"
#import "NFHttpResponse.h"

#import <AFNetworking.h>

@interface NFHttpLoader ()
@property (nonatomic,strong) AFHTTPRequestOperationManager *httpManager;
@end

@implementation NFHttpLoader

+ (id)loader
{
    return [[[self class] alloc] init];
}

- (id)init
{
    if (self = [super init]) {
        _httpManager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)load:(NSDictionary *)param completion:(NFHttpLoaderCompletion)block
{
    NSString *requestUrl = _requestUrl;
    
    void (^successBlock)(AFHTTPRequestOperation *,id) = ^(AFHTTPRequestOperation *op,id obj){
        [self notifyBlock:block
                  success:YES
                      obj:obj];
    };
    
    void (^failureBlock)(AFHTTPRequestOperation *,NSError *) = ^(AFHTTPRequestOperation *op,NSError * err){
        [self notifyBlock:block
                  success:NO
                      obj:err];
    };
    
    if (self.requestMethod == NFHttpLoaderMethodGET) {
        [_httpManager GET:requestUrl
               parameters:param
                  success:successBlock
                  failure:failureBlock];
    }else{
        [_httpManager POST:requestUrl
                parameters:param
                   success:successBlock
                   failure:failureBlock];
    }
}


- (void)addContentType:(NSString *)contentType
{
    [self addContentTypes:@[contentType]];
}

- (void)addContentTypes:(NSArray *)types
{
     NSMutableSet *contentTypes = [NSMutableSet setWithSet:_httpManager.responseSerializer.acceptableContentTypes];
    [contentTypes addObjectsFromArray:types];
    
    _httpManager.responseSerializer.acceptableContentTypes = contentTypes;
}

- (void)notifyBlock:(NFHttpLoaderCompletion)block success:(BOOL)suc obj:(id)obj
{
    NFHttpResponse *response = [[NFHttpResponse alloc] initWithObj:obj];
    dispatch_async(dispatch_get_main_queue(), ^{
        block(self,response);
    });
}

@end
