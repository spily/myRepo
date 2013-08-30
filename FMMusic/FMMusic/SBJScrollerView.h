//
//  SBJScrollerView.h
//  FMMusic
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KellWidth (320 - 30) / 2
#define KellHeigth   88
#define Kmindistance 10

@protocol SenderTag <NSObject>

@optional

- (void)senderTag:(NSInteger)tag;

@end

@interface SBJScrollerView : NSObject



@property (nonatomic,retain) UIScrollView *scrollView;
@property (nonatomic,assign) id<SenderTag>  delegate;

- (UIScrollView *)creatScorllerView;


@end
