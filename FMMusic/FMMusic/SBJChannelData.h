//
//  SBJChannelData.h
//  FMMusic
//
//  Created by apple on 13-8-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBJChannelData : NSObject

@property (nonatomic,retain)NSMutableArray *channelArray;

+ (id)defaultManager;

- (void)loadChannel_id;

@end
