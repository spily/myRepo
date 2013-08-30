//
//  SBJViewController.h
//  FMMusic
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol channelDelegate <NSObject>
@optional

- (void)sendTheChannel:(NSInteger) key;
@end

@interface SBJViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *playButtom;

@property (retain,nonatomic) IBOutlet UILabel  *titleSong;
@property (retain, nonatomic) IBOutlet UIImageView *songImage;
@property (nonatomic,assign) id<channelDelegate> delegate;


- (IBAction)nextSong:(id)sender;

- (IBAction)startPlay:(id)sender;
- (IBAction)pushSelectView:(id)sender;
- (IBAction)speedButton:(id)sender;


@end
