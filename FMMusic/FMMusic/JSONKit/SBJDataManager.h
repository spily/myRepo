//
//  SBJDataManager.h
//  FMMusic
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJViewController.h"
#import "SBJScrollerView.h"

@interface SBJDataManager : NSObject <channelDelegate, SenderTag >


@property (nonatomic,retain) NSMutableArray   *jsArray;
@property (nonatomic,assign) NSInteger   key;



+ (SBJDataManager *)defaultManager;
- (void)loadUrlJsonSong;



@end
