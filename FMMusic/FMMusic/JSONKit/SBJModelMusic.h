//
//  SBJModelMusic.h
//  FMMusic
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBJModelMusic : NSObject



@property (nonatomic,retain) NSString   *picture;
@property (nonatomic,retain) NSString   *url;
@property (nonatomic ,retain)NSString   *title;



- (id)initWithDictionary:(NSDictionary *)dic;

@end
