//
//  ViewController.m
//  LFBannerRolling
//
//  Created by daoxiu on 2016/11/22.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import "ViewController.h"
#import "LFBannerRollingView.h"
@interface ViewController ()<BannerRollingDelegate>
@property (weak, nonatomic) IBOutlet LFBannerRollingView *sbRollView;

@property(nonatomic,strong)LFBannerRollingView *rollView;
@property(nonatomic,strong)LFBannerRollingView *rollViewDown;
@property(nonatomic,strong)LFBannerRollingView *rollViewLeft;
@property(nonatomic,strong)LFBannerRollingView *rollViewRight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *dataArr =[[NSMutableArray alloc]initWithObjects:@"我",@"PDD洪荒之力",@"无人认领",@"一夜城",@"独活",@"可惜我不是水瓶座", nil];
    self.rollView = [[LFBannerRollingView alloc]initWithFrame:CGRectMake(30, 100, 200, 30)];
    self.rollView.delegate = self;
    self.rollView.dataArr = dataArr;
    self.rollView.layer.borderColor = [UIColor orangeColor].CGColor;
    self.rollView.layer.borderWidth = 1.0;
    [self.view addSubview:self.rollView];
    
    self.rollViewDown= [[LFBannerRollingView alloc]initWithFrame:CGRectMake(50, 150, 200, 30)];
    self.rollViewDown.delegate = self;
    self.rollViewDown.rollDirection = LFBannerRollDirectionDown;
    self.rollViewDown.dataArr = dataArr;
    self.rollViewDown.layer.borderColor = [UIColor orangeColor].CGColor;
    self.rollViewDown.layer.borderWidth = 1.0;
    [self.view addSubview:self.rollViewDown];
    
    self.rollViewLeft= [[LFBannerRollingView alloc]initWithFrame:CGRectMake(70, 200, 200, 30)];
    self.rollViewLeft.backgroundColor = [UIColor whiteColor];
    self.rollViewLeft.delegate = self;
    self.rollViewLeft.rollDirection = LFBannerRollDirectionLeft;
    self.rollViewLeft.dataArr = dataArr;
    self.rollViewLeft.layer.borderColor = [UIColor orangeColor].CGColor;
    self.rollViewLeft.layer.borderWidth = 1.0;
    [self.view addSubview:self.rollViewLeft];
    
    self.rollViewRight= [[LFBannerRollingView alloc]initWithFrame:CGRectMake(90, 250, 200, 30)];
    self.rollViewRight.delegate = self;
    self.rollViewRight.rollDirection = LFBannerRollDirectionRight;
    self.rollViewRight.dataArr = dataArr;
    self.rollViewRight.layer.borderColor = [UIColor orangeColor].CGColor;
    self.rollViewRight.layer.borderWidth = 1.0;
    [self.view addSubview:self.rollViewRight];
    
//    self.sbRollView.delegate = self;
//    self.sbRollView.dataArr = dataArr;
//    self.sbRollView.layer.borderColor = [UIColor orangeColor].CGColor;
//    self.sbRollView.layer.borderWidth = 1.0;
//    self.sbRollView.textAligentment = NSTextAlignmentCenter;
}
-(void)bannerRollingViewDidSelect:(NSInteger)index{
    NSLog(@"点了第%ld个",(long)index);
}
- (IBAction)click:(id)sender {
    NSMutableArray *dataArr =[[NSMutableArray alloc]initWithObjects:@"你最珍贵",@"Wind Of Change",@"大雨将至",@"相依为命",@"告白气球",@"失落沙洲", nil];
    self.rollView.dataArr = dataArr;
    self.rollView.textAligentment = NSTextAlignmentCenter;
}
-(void)viewWillAppear:(BOOL)animated{
    

}
-(void)dealloc{
    [self.rollView stopTimer];
    [self.rollViewDown stopTimer];
    [self.rollViewLeft stopTimer];
    [self.rollViewRight stopTimer];
}
@end
