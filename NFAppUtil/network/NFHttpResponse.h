//
//  NFHttpResponse.h
//  BeautifulGirls
//
//  Created by nirvawolf on 11/1/15.
//  Copyright (c) 2015 Nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFHttpEntity.h"

@interface NFHttpResponse : NFHttpEntity

- initWithObj:(id)obj;

- (BOOL)success;

- (id)obj;


@end
