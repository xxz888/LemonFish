
#import "xxzExtendFriends.h"
#import "xxzInfo.h"

#define SilderH 3
#define SlipW 12
#define ProSenderW 40

@implementation xxzExtendFriends

- (UIView *)tapView{
    
    if (_tapView == nil) {
        _tapView = [[UIView alloc] init];
    }
    return _tapView;
}

- (UIView *)baseView
{
    if (_baseView == nil) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    }
    return _baseView;
}

- (UIView *)bufferView
{
    if (_bufferView == nil) {
        _bufferView = [[UIView alloc] init];
        _bufferView.backgroundColor = [UIColor greenColor];
    }
    return _bufferView;
}

- (UIView *)trackView
{
    if (_trackView == nil) {
        _trackView = [[UIView alloc] init];
        _trackView.backgroundColor = [UIColor orangeColor];
    }
    return _trackView;
}

- (UIButton *)slipImgView{
    
    if (_slipImgView == nil) {
        _slipImgView = [[UIButton alloc] init];
        _slipImgView.contentMode = UIViewContentModeScaleAspectFit;
        [_slipImgView setImage:[UIImage imageNamed:@"btn_player_slider_thumb"] forState:UIControlStateNormal];
        _slipImgView.userInteractionEnabled = YES;
        [_slipImgView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slipImgPanGRAction:)]];
    }
    return _slipImgView;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        [self addSubview:self.tapView];
        [self.tapView addSubview:self.baseView];
        [self.tapView addSubview:self.bufferView];
        [self.tapView addSubview:self.trackView];
        [self addSubview:self.slipImgView];
        
        self.tapView.frame = CGRectMake(0, (self.frame.size.height - SlipW) / 2, self.frame.size.width, SlipW);
        self.baseView.frame = CGRectMake(0, (SlipW - SilderH) / 2, self.frame.size.width, SilderH);
        self.bufferView.frame = CGRectMake(0, (SlipW - SilderH) / 2, 0, SilderH);
        self.trackView.frame = CGRectMake(0, (SlipW - SilderH) / 2, 0, SilderH);
        self.slipImgView.frame = CGRectMake(0, (self.frame.size.height - SlipW) * 0.5, SlipW, SlipW);
    }
    return self;
}

- (void)slipImgPanGRAction:(UIPanGestureRecognizer *)panGR{
    
    
    CGFloat erson = [panGR translationInView:self].x;
    
    [panGR setTranslation:CGPointMake(0, 0) inView:self];
    
    CGFloat lbl = CGRectGetMaxX(self.slipImgView.frame) - ProSenderW * 0.5 + erson;
    
    
    if (lbl < 0) lbl = 0;
    if (lbl > self.bounds.size.width) lbl = self.bounds.size.width;
    
    self.trackValue = lbl / self.frame.size.width;
    if (panGR.state == UIGestureRecognizerStateChanged) {
        
        if (self.tapChangeimgValue) {
            self.tapChangeimgValue((CGRectGetMaxX(self.slipImgView.frame) - ProSenderW * 0.5) / self.frame.size.width);
        }
    }
    
    if (panGR.state == UIGestureRecognizerStateEnded) {
        if (self.tapChangedValue) {
            self.tapChangedValue((CGRectGetMaxX(self.slipImgView.frame) - ProSenderW * 0.5) / self.frame.size.width);
        }
    }
}

- (void)setBufferValue:(float)bufferValue
{
    _bufferValue = bufferValue;
    bufferValue = isnan(bufferValue)?0:bufferValue;
    self.bufferView.frame = CGRectMake(0, (SlipW - SilderH) / 2, self.frame.size.width * (bufferValue / 1.0), CGRectGetHeight(self.bufferView.frame));
}

- (void)setTrackValue:(float)trackValue
{
    _trackValue = trackValue;
    
    CGFloat controller = self.frame.size.width * trackValue;
    controller = isnan(controller)?0:controller;
    
    self.tapView.frame = CGRectMake(0, (self.frame.size.height - SlipW) / 2, self.frame.size.width, SlipW);
    self.baseView.frame = CGRectMake(0, (SlipW - SilderH) / 2, self.frame.size.width, SilderH);
    self.trackView.frame = CGRectMake(0, (SlipW - SilderH) / 2, controller, CGRectGetHeight(self.trackView.frame));
    self.slipImgView.frame = CGRectMake(controller - ProSenderW * 0.5, 0, ProSenderW, self.height);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    [self setTrackValue:self.trackValue];
    [self setBufferValue:self.bufferValue];
    
}

@end
