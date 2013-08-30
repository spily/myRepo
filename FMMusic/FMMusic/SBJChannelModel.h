//
//  SBJChannelModel.h
//  FMMusic
//
//  Created by apple on 13-8-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBJChannelModel : NSObject

@property (nonatomic,retain)   NSString *name;
@property (nonatomic,retain)   NSString *name_en;
@property (nonatomic,assign)    NSInteger  channel_id;


- (id)initWithDictionary:(NSDictionary *)dic;

@end
