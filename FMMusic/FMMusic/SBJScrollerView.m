//
//  SBJScrollerView.m
//  FMMusic
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJScrollerView.h"
#import "SBJChannelData.h"
#import "SBJChannelModel.h"
#import "SBJDataManager.h"

@implementation SBJScrollerView
@synthesize delegate = _delegate;

- (id)init
{
    self =[super init];
    if (self != nil) {
        
    }
    return  self;
}

- (UIScrollView *)creatScorllerView
{
    CGRect rect = CGRectMake(0, 0, 320, 480);
    self.scrollView = [[UIScrollView alloc]initWithFrame:rect];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    [self leftCellView];
    return self.scrollView;
}




- (void)leftCellView
{
    SBJChannelData *channel = [SBJChannelData defaultManager];
    [channel loadChannel_id];
    NSInteger num = [channel.channelArray count];
    NSInteger row = num / 2 + num % 2;
    NSLog(@"%ld,%ld",row,num);
    self.scrollView.contentSize = CGSizeMake(320, row * KellHeigth);
    
    for ( NSInteger i = 0; i < row; i ++) {
        UIControl  *cellView = [[UIControl alloc]initWithFrame:CGRectMake(Kmindistance, KellHeigth * i + 10, KellWidth, KellHeigth)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KellWidth, KellHeigth)];
        imageView.image = [UIImage imageNamed:@"fz.png"];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, KellWidth, 30)];
        label.backgroundColor = [UIColor clearColor];
        UILabel *labelen = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, KellWidth, 30)];
        labelen.backgroundColor = [UIColor clearColor];
        
        
        SBJChannelModel *model =[channel.channelArray objectAtIndex:i];
        label.text = model.name;
        labelen.text = model.name_en;
        cellView.tag = model.channel_id;
        
        [cellView addSubview:imageView];
        [cellView addSubview:label];
        [self.scrollView addSubview:cellView];
        [cellView addSubview:labelen];
        
        [cellView addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];

      
    }
    
    //邮编的小时图
    NSInteger rightRow = num - row;
    
    for (NSInteger i = 0; i < rightRow; i ++) {
        
        UIControl  *cellView = [[UIControl alloc]initWithFrame:CGRectMake(Kmindistance * 2 + KellWidth,10 + KellHeigth * i, KellWidth, KellHeigth)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, KellWidth, 30)];
        label.backgroundColor = [UIColor clearColor];
         UILabel *labelen = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, KellWidth, 30)];
        labelen.backgroundColor = [UIColor clearColor];

        SBJChannelModel *model =[channel.channelArray objectAtIndex:(row + i) ];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KellWidth, KellHeigth)];
        imageView.image = [UIImage imageNamed:@"fz.png"];
        
        label.text = model.name;
        labelen.text = model.name_en;
        cellView.tag = model.channel_id;
        
        [cellView addSubview:imageView];
        [cellView addSubview:label];
        [cellView addSubview:labelen];
        [self.scrollView addSubview:cellView];
        
        [cellView addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];


    }
    
}


- (void )touchAction:(id)sender
{
    UIControl *view = (UIControl *)sender;
    SBJDataManager *dataManager = [SBJDataManager defaultManager];
    self.delegate = dataManager;
    if (_delegate && [_delegate respondsToSelector:@selector(senderTag:)]) {

        //[self.scrollView ];
        [_delegate senderTag:view.tag];
        [dataManager loadUrlJsonSong];

      
    }
    
    NSLog(@"tag");
 
}


@end
