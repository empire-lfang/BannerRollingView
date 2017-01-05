//
//  LFBannerRolling.m
//  LFBannerRolling
//
//  Created by daoxiu on 2016/11/22.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import "LFBannerRollingView.h"

@interface LFBannerRollingView ()
@property(nonatomic,strong)UILabel *showView;
@property(nonatomic,strong)UILabel *hideView;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)BOOL flag;/** < 判断当前view的标志位 */
@end
@implementation LFBannerRollingView
static NSTimeInterval const RollTimeInterval = 3.0;
static CGFloat const ShowLableFontsize = 14;
-(UILabel *)showView{
    if (!_showView) {
        _showView = [[UILabel alloc]init];
        _showView.font = [UIFont systemFontOfSize:ShowLableFontsize];
        _showView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_showView];
    }
    return _showView;
}
-(UIView *)hideView{
    if (!_hideView) {
        _hideView = [[UILabel alloc]init];
        _hideView.font = [UIFont systemFontOfSize:ShowLableFontsize];
        _hideView.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_hideView];
    }
    return _hideView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self setupUI];
}
-(void)setup{
    self.count = 0;
    self.flag = NO;
    self.clipsToBounds = YES;
    self.rollDirection = LFBannerRollDirectionUp;
    self.interval = RollTimeInterval;
    [self addTap];
}
//默认是向上滚动，如果需要其他方向滚动则需要重新赋值
-(void)setRollDirection:(LFBannerRollDirection)rollDirection{
    _rollDirection = rollDirection;
    switch (_rollDirection) {
        case LFBannerRollDirectionUp:
            self.hideView.frame = CGRectMake(0,self.frame.size.height, self.frame.size.width, self.frame.size.height);
            break;
        case LFBannerRollDirectionDown:
            self.hideView.frame = CGRectMake(0,-self.frame.size.height, self.frame.size.width, self.frame.size.height);
            break;
        case LFBannerRollDirectionLeft:
            self.hideView.frame = CGRectMake(self.frame.size.width,0, self.frame.size.width, self.frame.size.height);
            break;
        case LFBannerRollDirectionRight:
            self.hideView.frame = CGRectMake(-self.frame.size.width,-self.frame.size.height, self.frame.size.width, self.frame.size.height);
            break;
        default:
            break;
    }
}
-(void)setupUI{
    
    self.showView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.hideView.frame = CGRectMake(0,self.frame.size.height, self.frame.size.width, self.frame.size.height);
}
-(void)setInterval:(NSTimeInterval)interval{
    _interval = interval;
    [self setupTimer:_interval];
}
-(void)setTextAligentment:(NSTextAlignment)textAligentment{
    _textAligentment = textAligentment;
    self.showView.textAlignment = _textAligentment;
    self.hideView.textAlignment = _textAligentment;
}
#pragma mark - 添加手势
-(void)addTap{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}
-(void)tap{
    if ([self.delegate respondsToSelector:@selector(bannerRollingViewDidSelect:)]) {
        [self.delegate bannerRollingViewDidSelect:self.count];
    }
}
#pragma mark - 创建timer
-(void)setupTimer:(NSTimeInterval)interval{
    if (self.timer) {
        [self.timer invalidate];
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(changeLayoutAndData) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)changeLayoutAndData{
    switch (self.rollDirection) {
        case LFBannerRollDirectionUp:
            [self directionUp];
            break;
        case LFBannerRollDirectionDown:
            [self directionDown];
            break;
        case LFBannerRollDirectionLeft:
            [self directionLeft];
            break;
        case LFBannerRollDirectionRight:
            [self directionRight];
            break;
        default:
            break;
    }
}

-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    self.showView.text = _dataArr[self.count];
}
/** ⬆️ */
-(void)directionUp{
    [self setupAnimationOriginX:0 originY:-self.frame.size.height];
}
/** ⬇️ */
-(void)directionDown{
    [self setupAnimationOriginX:0 originY:self.frame.size.height];
}
/** ⬅️ */
-(void)directionLeft{
    [self setupAnimationOriginX:-self.frame.size.width originY:0];
}
/** ➡️ */
-(void)directionRight{
    [self setupAnimationOriginX:self.frame.size.width originY:0];
}
#pragma mark - 动画效果
-(void)setupAnimationOriginX:(CGFloat)x originY:(CGFloat)y{
    if (++self.count==self.dataArr.count) {
        self.count = 0;
    }
    if (!self.flag) {
        NSLog(@"跑123");
        self.hideView.text = self.dataArr[self.count];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:3 options:UIViewAnimationOptionCurveLinear animations:^{
            self.showView.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
            self.hideView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            self.flag = YES;
            self.showView.frame = CGRectMake(-x, -y, self.frame.size.width, self.frame.size.height);
        }];
    }else{
        NSLog(@"跑456");
        self.showView.text = self.dataArr[self.count];
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:3 options:UIViewAnimationOptionCurveLinear animations:^{
            self.hideView.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
            self.showView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        } completion:^(BOOL finished) {
            self.flag = NO;
            self.hideView.frame = CGRectMake(-x, -y, self.frame.size.width, self.frame.size.height);
        }];
    }
}
-(CGSize)calculateString:(NSString *)str fontSize:(CGFloat)size{
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:13]}];
    return strSize;
}
-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
@end
