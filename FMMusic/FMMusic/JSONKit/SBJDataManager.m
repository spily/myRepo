//
//  SBJDataManager.m
//  FMMusic
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJDataManager.h"
#import "JSONKit.h"
#import "SBJModelMusic.h"


static SBJDataManager *instance = nil;

@implementation SBJDataManager


+ (SBJDataManager *)defaultManager
{
    if (instance == nil) {
        instance = [[SBJDataManager alloc]init];
    }
    return instance;
}


- (id)init
{
    self = [super init];
    if (self ) {
        self.jsArray = [[NSMutableArray alloc]init];
    }
    return self;
}


//- (void)sendTheChannel:(NSInteger) key
//{
//    self.key = key;
//}

- (void)senderTag:(NSInteger)tag
{
    self.key = tag;
}



- (void)loadUrlJsonSong
{
    [self.jsArray removeAllObjects];
    NSString *str = [NSString stringWithFormat:@"http://www.douban.com/j/app/radio/people?type=n&channel=%d&version=83&app_name=radio_iphone",self.key];
    NSLog(@"%@",str);
    NSURL *url = [NSURL URLWithString:str];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    NSString *songData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *songData = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    //解析json文件
    NSDictionary *songDic = [songData objectFromJSONString];
    
    NSArray *array = [songDic objectForKey:@"song"];
    
    for (NSDictionary *dic in array) {
        SBJModelMusic *new = [[SBJModelMusic alloc] initWithDictionary:dic];
    
        [self addModelObject:new];
    }
    
    
}


- (void) addModelObject:(SBJModelMusic *)new
{
    if (new != 0) {
        [self.jsArray addObject:new];
    }
}

@end






