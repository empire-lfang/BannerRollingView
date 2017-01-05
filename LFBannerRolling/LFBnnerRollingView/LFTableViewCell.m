//
//  LFTableViewCell.m
//  LFBannerRolling
//
//  Created by daoxiu on 2016/12/1.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import "LFTableViewCell.h"
#import "LFBannerRollingView.h"
@interface LFTableViewCell ()
@property (weak, nonatomic) IBOutlet LFBannerRollingView *rollView;

@end
@implementation LFTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    }


-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    self.rollView.dataArr = _dataArr;
}
-(void)dealloc{
    [self.rollView stopTimer];
}
@end
