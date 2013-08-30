//
//  SBJModelMusic.m
//  FMMusic
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJModelMusic.h"

@implementation SBJModelMusic

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.url = [dic objectForKey:@"url"];
        self.picture = [dic objectForKey:@"picture"];
        self.title = [dic objectForKey:@"title"];
    }
    return self;
}



@end
