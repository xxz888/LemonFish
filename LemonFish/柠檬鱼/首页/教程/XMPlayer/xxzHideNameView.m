
#import "xxzHideNameView.h"
#import "xxzInfo.h"

#define TopMenuH 40
#define BotMenuH 40
#define TimeShowWidth 50
#define ImageWithName(imgStr)  [UIImage imageNamed:[NSString stringWithFormat:@"%@", imgStr]]

@interface xxzHideNameView ()

@property (nonatomic, assign) BOOL addressPay_a9;
@property (nonatomic, strong) NSTimer *nearestBanner;
@property (nonatomic, assign) NSInteger tuiguangPre;

@property (nonatomic, assign) CGFloat xinyongkablockRegtip;

@end

@implementation xxzHideNameView

- (NSTimer *)nearestBanner
{
    if (_nearestBanner == nil) {
        _nearestBanner = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRunAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_nearestBanner forMode:NSRunLoopCommonModes];
    }
    return _nearestBanner;
}

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TopMenuH)];
        _topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _topView;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - BotMenuH, self.frame.size.width, BotMenuH)];
        _bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    }
    return _bottomView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"btn_player_quit"] forState:UIControlStateNormal];
        _closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _closeButton.bounds = CGRectMake(0, 0, TopMenuH * 4, TopMenuH);
    }
    return _closeButton;
}

- (UIButton *)playButton
{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:ImageWithName(@"btn_player_play") forState:UIControlStateNormal];
        [_playButton setImage:ImageWithName(@"btn_player_pause") forState:UIControlStateSelected];
        _playButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _playButton.bounds = CGRectMake(0, 0, TopMenuH, TopMenuH);
    }
    return _playButton;
}

- (UIButton *)fullScreenButton
{
    if (!_fullScreenButton) {
        _fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fullScreenButton setImage:[UIImage imageNamed:@"btn_player_scale01"] forState:UIControlStateNormal];
        [_fullScreenButton setImage:[UIImage imageNamed:@"btn_player_scale02"] forState:UIControlStateSelected];
        _fullScreenButton.bounds = CGRectMake(0, 0, TopMenuH, TopMenuH);
    }
    return _fullScreenButton;
}

- (UILabel *)playTimeLabel{
    if (!_playTimeLabel) {
        _playTimeLabel = [[UILabel alloc] init];
        _playTimeLabel.backgroundColor = [UIColor clearColor];
        _playTimeLabel.font = [UIFont systemFontOfSize:11];
        _playTimeLabel.textColor = [UIColor whiteColor];
        _playTimeLabel.textAlignment = NSTextAlignmentCenter;
        _playTimeLabel.bounds = CGRectMake(0, 0, TopMenuH, TopMenuH);
        _playTimeLabel.text = @"00:00:00";
    }
    return _playTimeLabel;
}

- (UILabel *)totalTimeLabel{
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc] init];
        _totalTimeLabel.backgroundColor = [UIColor clearColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:11];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
        _totalTimeLabel.bounds = CGRectMake(0, 0, TopMenuH, TopMenuH);
        _totalTimeLabel.text = @"00:00:00";
    }
    return _totalTimeLabel;
}

- (xxzExtendFriends *)playerSilder
{
    if (_playerSilder == nil) {
        _playerSilder = [[xxzExtendFriends alloc] init];
        _playerSilder.trackValue = 0;
    }
    return _playerSilder;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        [self addSubview:self.topView];
        [self.topView addSubview:self.closeButton];

        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.fullScreenButton];
        [self.bottomView addSubview:self.playButton];
        [self.bottomView addSubview:self.playTimeLabel];
        [self.bottomView addSubview:self.totalTimeLabel];
        [self.bottomView addSubview:self.playerSilder];
        
        self.menuShow = YES;
        self.tuiguangPre = 0;
        [self.nearestBanner fire];
        UITapGestureRecognizer *hange = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controlViewTapGRAction:)];
        [self addGestureRecognizer:hange];
        
        
        self.xinyongkablockRegtip = 0;
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slipImgPanGRAction:)]];
    }
    return self;
}

- (void)slipImgPanGRAction:(UIPanGestureRecognizer *)panGR
{
    
    CGFloat erson = [panGR translationInView:self].x;
    
    [panGR setTranslation:CGPointMake(0, 0) inView:self];
    
    self.xinyongkablockRegtip = self.xinyongkablockRegtip + erson;
    if (panGR.state == UIGestureRecognizerStateChanged) {
       
        if (self.tapChangeimgValue) {
            self.tapChangeimgValue(self.xinyongkablockRegtip);
        }
        
        
    }else if (panGR.state == UIGestureRecognizerStateEnded) {
        
        if (self.tapChangedValue) {
            self.tapChangedValue(self.xinyongkablockRegtip);
        }
        self.xinyongkablockRegtip = 0;
    }
}

- (void)timerRunAction
{
    self.tuiguangPre++;
    if (self.tuiguangPre == 4) {
        self.tuiguangPre = 0;
        [self.nearestBanner setFireDate:[NSDate distantFuture]];
        [self hideAnimate];
    }
}

- (void)hideAnimate
{
    if (_addressPay_a9) {
        return;
    }
    self.tuiguangPre = 0;
    _addressPay_a9 = YES;
    [UIView animateWithDuration:0.5 animations:^{
        self.topView.frame = CGRectMake(0, -CGRectGetHeight(self.topView.frame), CGRectGetWidth(self.topView.frame), CGRectGetHeight(self.topView.frame));
        self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.bottomView.frame), CGRectGetWidth(self.bottomView.frame), CGRectGetHeight(self.bottomView.frame));
    } completion:^(BOOL finished) {
        self.topView.hidden = YES;
        self.bottomView.hidden = YES;
        self.menuShow = NO;
        _addressPay_a9 = NO;
    }];
}

- (void)showAnimate
{
    if (_addressPay_a9) {
        return;
    }
    self.topView.hidden = NO;
    self.bottomView.hidden = NO;
    _addressPay_a9 = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.topView.frame = CGRectMake(0, 0, self.frame.size.width, TopMenuH);
        self.bottomView.frame = CGRectMake(0, self.frame.size.height - BotMenuH, self.frame.size.width, BotMenuH);
    } completion:^(BOOL finished) {
        self.menuShow = YES;
        _addressPay_a9 = NO;
        [self.nearestBanner setFireDate:[NSDate distantPast]];
    }];
}

- (void)controlViewTapGRAction:(UITapGestureRecognizer *)tapGR
{
    [self.nearestBanner setFireDate:[NSDate distantFuture]];
    self.tuiguangPre = 0;
    if (tapGR.numberOfTapsRequired == 1) {
        if (self.menuShow) {
            [self hideAnimate];
        }else
        {
            [self showAnimate];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topView.frame = CGRectMake(0, 0, self.frame.size.width, TopMenuH);
    self.closeButton.frame = CGRectMake(10, CGRectGetMinX(self.topView.bounds), CGRectGetWidth(self.closeButton.bounds), CGRectGetHeight(self.closeButton.bounds));
    self.bottomView.frame = CGRectMake(0, self.frame.size.height - BotMenuH, self.frame.size.width, BotMenuH);
    self.playButton.frame = CGRectMake(10, (BotMenuH - CGRectGetHeight(self.playButton.bounds))/2.0, CGRectGetWidth(self.playButton.bounds), CGRectGetHeight(self.playButton.bounds));
    self.playTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.playButton.frame), 0, TimeShowWidth, CGRectGetHeight(self.playTimeLabel.bounds));
    self.fullScreenButton.frame = CGRectMake(CGRectGetWidth(self.bottomView.bounds) - CGRectGetWidth(self.fullScreenButton.bounds) - 10, (CGRectGetHeight(self.bottomView.frame)-CGRectGetHeight(self.fullScreenButton.bounds))/2.0, CGRectGetWidth(self.fullScreenButton.bounds), CGRectGetHeight(self.fullScreenButton.bounds));
    self.totalTimeLabel.frame = CGRectMake(self.fullScreenButton.x-TimeShowWidth, 0, TimeShowWidth, CGRectGetHeight(self.playTimeLabel.bounds));
    self.playerSilder.frame = CGRectMake(CGRectGetMaxX(self.playTimeLabel.frame)+5, (CGRectGetHeight(self.bottomView.frame) - BotMenuH) * 0.5, self.totalTimeLabel.x-(CGRectGetMaxX(self.playTimeLabel.frame)+10), BotMenuH);
}

- (void)dealloc
{
    [_nearestBanner invalidate];
    _nearestBanner = nil;
}

@end
