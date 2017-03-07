//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshNormalHeader.h"

@interface MJRefreshNormalHeader()
{
    __unsafe_unretained UIImageView *_arrowView;
}
@property (weak, nonatomic) UIImageView *loadingView;

@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:@"fresh_1"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
    }
    return _arrowView;
}

- (UIImageView *)loadingView
{
    if (!_loadingView) {
        UIImageView *loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fresh_3"]];
        [self rotate360Degree:_loadingView];
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}

- (void)rotate360Degree:(UIImageView *)imageView{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];

    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:

                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 0.4;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;

    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [imageView.layer addAnimation:animation forKey:nil];
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    [self setTitle:@"释放更新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    CGFloat arrowCenterY = self.mj_h * 0.3;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.arrowView.mj_size = CGSizeMake(25, 25);
        self.arrowView.center = arrowCenter;
    }
        
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.mj_size = CGSizeMake(25, 25);
        self.loadingView.center = arrowCenter;
    }
    self.stateLabel.center = CGPointMake(self.stateLabel.center.x, self.mj_h*0.8);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState

    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 0.0;
                [self.loadingView.layer removeAllAnimations];
                self.arrowView.hidden = NO;
            }];
        } else {
            self.loadingView.alpha = 0.0;
            [self.loadingView.layer removeAllAnimations];
            self.arrowView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView.layer removeAllAnimations];
        self.arrowView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self rotate360Degree:self.loadingView];
        self.arrowView.hidden = YES;
        [self setTitle:@"加载中..." forState:MJRefreshStateIdle];
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
    if (pullingPercent > 0) {
        [self setTitle:@"下拉更新" forState:MJRefreshStateIdle];
    }
}
@end
