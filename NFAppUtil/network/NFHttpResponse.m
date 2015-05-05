//
//  NFHttpResponse.m
//  BeautifulGirls
//
//  Created by nirvawolf on 11/1/15.
//  Copyright (c) 2015 Nirvawolf. All rights reserved.
//

#import "NFHttpResponse.h"

@interface NFHttpResponse ()
@property (nonatomic,strong) id obj;
@property (nonatomic,assign) BOOL success;
@end

@implementation NFHttpResponse

- (id)initWithObj:(id)obj
{
    if (self =  [super init]) {
        
        _obj = obj;
        
        if ([_obj isKindOfClass:[NSError class]] || !_obj) {
            _success = NO;
        }else{
            _success = YES;
        }
    }
    
    return self;
}

- (instancetype)init
{
    return [self initWithObj:nil];
}


- (id)obj
{
    return _obj;
}


@end
