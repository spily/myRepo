//
//  SBJViewController.m
//  FMMusic
//
//  Created by apple on 13-8-26.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SBJViewController.h"
#import "SBJDataManager.h"
#import "SBJModelMusic.h"
#import "UIImageView+WebCache.h"
#import "SBJCustomCell.h"
#import "SBJChannelData.h"
#import "SBJCustomCell.h"
#import "SBJChannelModel.h"
#import "SBJScrollerView.h"

@interface SBJViewController ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate,AVAudioPlayerDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSURLConnection  *_connection;
    UIView         *_sliderView;
    UISlider        *_slider;
    UIScrollView    *_scrollView;
    UIView  *_buttomView;

}

@property (nonatomic,retain)  AVAudioPlayer   *player;
@property (nonatomic,retain)  NSMutableArray  *songArray;
@property (nonatomic,assign)  NSInteger     currentIndex;
@property (nonatomic,retain)  NSString       *filePath;
@property (nonatomic,retain)  NSFileHandle    *fileHandel;

@end

@implementation SBJViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    
    self.songArray = [[NSMutableArray alloc]init];;
    // Do any additional setup after loading the view from its nib.
    

    
    
    //get the  array
    SBJDataManager *dataManager = [SBJDataManager defaultManager];
    self.delegate = dataManager;
    [dataManager loadUrlJsonSong];
    
    //
    SBJChannelData *channel = [SBJChannelData defaultManager];
    [channel loadChannel_id];
    self.songArray = dataManager.jsArray;
  //创建一个tableview
//    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    _tableView.delegate  = self;
//    _tableView.dataSource = self;
//
    //创建一个手势
    UIPanGestureRecognizer  *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    self.songImage.userInteractionEnabled = YES;
    self.songImage.backgroundColor = [UIColor orangeColor];
    [self.songImage addGestureRecognizer:pan];
   
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //creat a scrollerview
    _scrollView = [[SBJScrollerView alloc]creatScorllerView];
//    _scrollView = [ [UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,480)];
    [self.view addSubview:_scrollView];
    
    
    //创建一个小的uiView
    _buttomView =[[UIView alloc]initWithFrame:CGRectMake(0, 420, 320, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 220, 20)];
    label.text = @"           NARUTO小纯洁";
    label.backgroundColor = [UIColor clearColor];
    [_buttomView addSubview:label];
    _buttomView.hidden = YES;
    _buttomView.backgroundColor =[UIColor purpleColor];
    
    //链接一个手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [_buttomView addGestureRecognizer:tap];
    
    //creat a view
    _sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 320, 80)];
    _sliderView.alpha = 0.5;
    _sliderView.hidden = YES;
    _sliderView.backgroundColor = [UIColor orangeColor];
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(60, 20, 200, 20)];
   // [_slider addTarget:self action:@selector(sliderValueChange) forControlEvents:UIControlEventValueChanged];
    _slider.minimumValue = 1.0 ;
    _slider.maximumValue = 3.0;
    
    [_sliderView addSubview:_slider];
    [self.view addSubview:_sliderView];
    [self.view addSubview:_tableView];
    
    [self.view sendSubviewToBack:_scrollView];
    [self.view addSubview:_buttomView];
    

    
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [UIView animateWithDuration:1 animations:^ {
        UIView *subView = [self.view viewWithTag:119];
        subView.frame = CGRectMake(0, 0, 320, 480);
        _buttomView.hidden = YES;
    
    } completion:^ (BOOL finished)
     {
         NSLog(@"success");
     }];
    
}



//手势的实现
- (void)panAction:(UIPanGestureRecognizer *)panGesture
{
    CGPoint  first;
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        first = [panGesture locationInView:self.songImage];
    }
    
    CGPoint second = [panGesture translationInView:self.songImage];
    
    NSLog(@"手势:%@",NSStringFromCGPoint(second));
    
    [UIView animateWithDuration:0.5 animations:^ {
        UIView *subView = [self.view viewWithTag:119];
        subView.frame = CGRectMake(0, second.y - first.y, 320, 480);
        if ((second.y - first.y )  >  100) {
            subView.frame = CGRectMake(0, 480, 320, 480);
            _buttomView.hidden = NO;
        }
        if ((second.y - first.y )  <=  100) {
            subView.frame = CGRectMake(0, 0, 320, 480);
        }
        
       
    
    } completion:^ (BOOL finished) {
        NSLog(@"success");
    }];
}


//UItabelviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SBJChannelData *channel = [SBJChannelData defaultManager];

    return [channel.channelArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    SBJCustomCell *cell = (SBJCustomCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SBJCustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    SBJChannelData *channel = [SBJChannelData defaultManager];
    SBJChannelModel *model = [channel.channelArray objectAtIndex:indexPath.row];
    cell.oneLabel.text = model.name;
    cell.twoLabel.text = model.name_en;
    cell.channel_id = model.channel_id;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 145;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.hidden =YES;
    SBJChannelData *channel = [SBJChannelData defaultManager];
    SBJChannelModel *model = [channel.channelArray objectAtIndex:indexPath.row];
    NSInteger key = model.channel_id;
    if (_delegate && [_delegate respondsToSelector:@selector(sendTheChannel:)]) {
        [_delegate sendTheChannel:key];
    }
    
    SBJDataManager *dataManager = [SBJDataManager defaultManager];
//    self.delegate = dataManager;
    [dataManager loadUrlJsonSong];
    
}
//异步下载
- (void)downLoadConnection
{
    //creat a url
    if (_connection) {
        [_connection cancel];
        [_connection release];
        
    }
    SBJModelMusic *model = [_songArray objectAtIndex:self.currentIndex];
    NSURL *url = [NSURL URLWithString:model.url];
    NSString *str = model.picture;
    NSURL  *pictureUrl = [NSURL URLWithString:str];
    [self.songImage  setImageWithURL:pictureUrl];
    self.titleSong.text = model.title;
    //creat a request
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //creat a connection
   
     _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (_connection ) {
        [_connection start];
    }
 
   
}

//一步下载的协议的实现
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@",connection);
    if ([(NSHTTPURLResponse *)response statusCode] == 200) {
        NSLog(@"相应成功");
        
    }
    SBJModelMusic *model = [_songArray objectAtIndex:self.currentIndex];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    self.filePath = [NSString stringWithFormat:@"%@/%@",path,[model.url lastPathComponent]];
    NSFileManager *file = [NSFileManager defaultManager];
    [file createFileAtPath:self.filePath contents:nil attributes:nil];
//    
    _fileHandel = [NSFileHandle fileHandleForUpdatingAtPath:self.filePath];
    [_fileHandel retain];
    
}


//datasource的方法
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_fileHandel writeData:data];
    
   // [data writeToFile:_filePath atomically:YES];
}

//下载完成后
- (void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    [_fileHandel closeFile];
    if (self.filePath == nil) {
        return;
    } else {
        
    //用文件的url给url初始化
    NSURL *url = [NSURL fileURLWithPath:self.filePath];
    
    //给AVAUdioaPlay
    AVAudioPlayer *play = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    
    if (play == nil) {
        return;
    }
        //enable 在prepare前面;
    play.delegate = self;
    self.player = play;
    self.player.enableRate = YES;
    //[play release];
        
    [self.player prepareToPlay];
    [self.player play];
    self.player.rate = _slider.value;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hiddenTableView:(id)sender {
}

//the next song

- (IBAction)nextSong:(id)sender {
    
    if (self.player != nil) {
        [self.player stop];
    }
    self.currentIndex += 1;
    SBJDataManager *dataManager = [SBJDataManager defaultManager];
    
    if (self.currentIndex == [dataManager.jsArray count]) {
        
        //SBJDataManager *dataManager = [SBJDataManager defaultManager];
        [dataManager loadUrlJsonSong];
        self.currentIndex = 0;
//        [self.songArray removeAllObjects];
//        self.songArray = dataManager.jsArray;
        [self downLoadConnection];
    }else
    {
        [self downLoadConnection];
    
    }

    
}

//delegate来判断是否播放完成
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (flag ) {
        self.currentIndex += 1;
        [self downLoadConnection];
    }
    
}

- (IBAction)startPlay:(id)sender {
    //异步下载
    if (self.player.playing) {
        [self.player pause];
       
         
        [self.playButtom setImage:[UIImage imageNamed:@"ic_player_pause_off_highlight.png"] forState:UIControlStateSelected];
        self.playButtom.selected = YES;

        return;
    }
    else {
        if (self.player == nil) {
            [self.playButtom setImage:[UIImage imageNamed:@"ic_player_pause_on.png"] forState:UIControlStateSelected];
            self.playButtom.selected = YES;

             [self downLoadConnection];
        }
        else
        {
        
            [self.playButtom setImage:[UIImage imageNamed:@"ic_player_pause_on.png"] forState:UIControlStateSelected];
            self.playButtom.selected = YES;

            [self.player play];
        }
   
    }
    
}

- (IBAction)pushSelectView:(id)sender {
    if (_tableView.hidden) {
        _tableView.hidden = NO;
    } else {
        _tableView.hidden = YES;
    }
    
}

- (IBAction)speedButton:(id)sender {
    if (_sliderView.hidden) {
        _sliderView.hidden = NO;
    }
    else
        _sliderView.hidden = YES;
}
- (void)dealloc {
    [_buttomView release];
    [_slider release];
    [_sliderView release];
    [_songImage release];
    [_playButtom release];
    [super dealloc];
}
@end
