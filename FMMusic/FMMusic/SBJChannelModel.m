//
//  SBJChannelModel.m
//  FMMusic
//
//  Created by apple on 13-8-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJChannelModel.h"

@implementation SBJChannelModel

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {

    self.name = [dic objectForKey:@"name"];
    self.name_en = [dic objectForKey:@"name_en"];
    self.channel_id = [[dic objectForKey:@"channel_id"]integerValue];
    
    }
    return self;
}

@end
