//
//  SBJChannelData.m
//  FMMusic
//
//  Created by apple on 13-8-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJChannelData.h"
#import "JSONKit.h"
#import "SBJChannelModel.h"


static SBJChannelData *instance = nil;
@implementation SBJChannelData

+ (id)defaultManager
{
    if (instance == nil) {
        instance = [[SBJChannelData alloc]init];
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.channelArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)loadChannel_id
{
    [self.channelArray removeAllObjects];
    NSURL *url = [NSURL URLWithString:@"http://www.douban.com/j/app/radio/channels"];
    
    NSString *content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *channelDic = [content objectFromJSONString];
    NSArray *array = [channelDic objectForKey:@"channels"];
    //bianli
    for (NSDictionary *dic in array) {
        SBJChannelModel *model = [[SBJChannelModel alloc]initWithDictionary:dic];
        [self addChannelObject:model];
        
    }
    
}

- (void)addChannelObject:(SBJChannelModel *)model
{
    if (model != nil) {
        [self.channelArray addObject:model];
    }
}


@end
