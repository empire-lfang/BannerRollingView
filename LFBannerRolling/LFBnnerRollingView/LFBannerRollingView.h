//
//  LFBannerRolling.h
//  LFBannerRolling
//
//  Created by daoxiu on 2016/11/22.
//  Copyright © 2016年 aowokeji. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    LFBannerRollDirectionUp,//向上滚动
    LFBannerRollDirectionDown,//向下滚动
    LFBannerRollDirectionLeft,//向左滚动
    LFBannerRollDirectionRight,//向右滚动
}LFBannerRollDirection;

@protocol BannerRollingDelegate <NSObject>
//需要设置点击事件的代理方法
-(void)bannerRollingViewDidSelect:(NSInteger)index;
@end
@interface LFBannerRollingView : UIView
@property(nonatomic,assign)LFBannerRollDirection rollDirection;//default LFBannerRollDirectionUp
@property(nonatomic,assign)NSTimeInterval interval;//default 3.0s
@property(nonatomic,weak)id <BannerRollingDelegate> delegate;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)NSTextAlignment textAligentment;//文字对齐位置
-(void)stopTimer;
@end
