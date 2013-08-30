//
//  SBJCustomCell.h
//  FMMusic
//
//  Created by apple on 13-8-27.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBJCustomCell : UITableViewCell



@property (nonatomic,assign)  NSInteger   channel_id;
@property (retain, nonatomic) IBOutlet UILabel *oneLabel;
@property (retain, nonatomic) IBOutlet UILabel *twoLabel;


@end
