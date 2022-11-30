

#import "xxzRticlesUppotView.h"
#import "XMPlayerConfig.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define STROKE_END_RADIAN 180/RADIANS_TO_DEGREES(M_PI)
#define STROKE_PROCESS_RADIAN(angle) angle/RADIANS_TO_DEGREES(M_PI)
static const float DRAW_LINE_RATE = 7.5; 
static const float RECURRENT = 4; 
static const float RADIUS_NONE = 15; 
static const float RADIUS_LOGO = 32.5; 
static const float STROKE_STEP = 170; 
static const float DRAW_LING_ROTATE = M_PI_4;

@interface xxzTitleAlendar : CAShapeLayer

- (instancetype)initWithFrame:(CGRect)frame;

+ (instancetype)layerWithFrame:(CGRect)frame;

@end

@implementation xxzTitleAlendar

+ (instancetype)layerWithFrame:(CGRect)frame {
    
    return [[self alloc]initWithFrame:frame];
}

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.lineWidth = RING_LINE_WIDTH;
        self.fillColor = [UIColor clearColor].CGColor;
        self.strokeColor = XMRefreshColor;
        self.lineCap = kCALineCapRound;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([self init]) {
        
        self.frame = frame;
    }
    return self;
}
@end

@interface xxzRticlesUppotView ()


@property(nonatomic, strong) CALayer *aliTeam;


@property(nonatomic, strong) xxzTitleAlendar *showed;


@property(nonatomic, strong) xxzTitleAlendar *runRaius;


@property(nonatomic, strong) UIImageView *zhituirenshu;

@property(nonatomic, strong) CABasicAnimation *trade;

@property(nonatomic, strong) CABasicAnimation *shoukuanrenInyongka;

@property(nonatomic, assign) RefreshLogo logoStyle;

@end

@implementation xxzRticlesUppotView

+ (instancetype)refreshViewWithFrame:(CGRect)frame logoStyle:(RefreshLogo)style{
    
    xxzRticlesUppotView *confirmView = [[self alloc]initWithFrame:frame logoStyle:style];
    return confirmView;
}

- (instancetype)initWithFrame:(CGRect)frame logoStyle:(RefreshLogo)style {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.logoStyle = style;
        
        if ([self isHasLogo]) {
            [self createLogo:style];
            [self registerNotification];
        }
        [self changeAnchor:NO];
        [self resetAnimation];
    }
    return self;
}

- (void)startAnimation {
    
    _isLoading = YES;
    [self clearAllAnimation];
    [self checkSeting];
    
    [self.showed addAnimation:self.trade forKey:self.trade.keyPath];
    [self.runRaius addAnimation:self.trade forKey:self.trade.keyPath];
    [self.aliTeam addAnimation:self.shoukuanrenInyongka forKey:self.shoukuanrenInyongka.keyPath];
}

- (void)stopAnimation {
    
    [self clearAllAnimation];
    _isLoading = NO;
}

- (void)drawLineWithPercent:(CGFloat)percent {
    
    [self checkSeting];
    if (percent >= STROKE_PROCESS_RADIAN(160)) {
        percent = STROKE_PROCESS_RADIAN(160);
    }
    [UIView animateWithDuration:0.1 animations:^{
        [self.showed setStrokeEnd:percent];
        [self.runRaius setStrokeEnd:percent];
        self.aliTeam.transform = CATransform3DMakeRotation(DRAW_LING_ROTATE * percent, 0, 0, 1);
    }];
}

#pragma mark - privateMethod
- (void)clearAllAnimation {
    
    [self.layer removeAllAnimations];
    [self resetAnimation];
}

- (void)resetAnimation {
    
    [self.showed removeAllAnimations];
    [self.runRaius removeAllAnimations];
    self.aliTeam.transform = CATransform3DIdentity;
    [self.aliTeam removeAllAnimations];
    [self.showed setStrokeEnd:0.01];
    [self.runRaius setStrokeEnd:0.01];
}

- (void)checkSeting {
    
    if (self.lineColor && self.lineColor.CGColor != self.showed.strokeColor) {
        [self changeLineColor:self.lineColor];
    }
}

- (void)changeAnchor:(BOOL)isEnd {
    
    CGPoint mine = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    
    CGFloat area6 = [self isHasLogo] ? RADIUS_LOGO : RADIUS_NONE;
    
    
    NSDictionary *yitixian = [self calculateAngle:30];
    
    if (isEnd) {
        yitixian = [self calculateAngle:-115];
    }
    CGFloat h_image = [[[yitixian objectForKey:@"left"] objectForKey:@"start"] doubleValue];
    CGFloat badge = [[[yitixian objectForKey:@"left"] objectForKey:@"end"] doubleValue];
    CGFloat sure = [[[yitixian objectForKey:@"right"] objectForKey:@"start"] doubleValue];
    CGFloat offset = [[[yitixian objectForKey:@"right"] objectForKey:@"end"] doubleValue];
    UIBezierPath *last = [UIBezierPath bezierPathWithArcCenter:mine radius:area6 startAngle:DEGREES_TO_RADIANS(h_image) endAngle:DEGREES_TO_RADIANS(badge) clockwise:YES];
    
    UIBezierPath *where_0 = [UIBezierPath bezierPathWithArcCenter:mine radius:area6  startAngle:DEGREES_TO_RADIANS(sure) endAngle:DEGREES_TO_RADIANS(offset) clockwise:YES];
    
    self.showed.path = last.CGPath;
    self.runRaius.path = where_0.CGPath;
}

- (NSDictionary *)calculateAngle:(CGFloat)leftStartPosition {
    
    CGFloat h_image7 = leftStartPosition;
    CGFloat badger = leftStartPosition > 0 ? (leftStartPosition + STROKE_STEP) - 360: STROKE_STEP + leftStartPosition;
    CGFloat surex = badger + 10;
    CGFloat offsetq = h_image7 - 10;
    
    return @{@"left" : @{@"start" : @(h_image7), @"end" : @(badger)}, @"right" : @{@"start" : @(surex), @"end" : @(offsetq)}};
}

- (BOOL)isHasLogo {
    
    return (self.logoStyle == RefreshLogoCommon || self.logoStyle == RefreshLogoAlbum) ? YES : NO;
}

- (void)createLogo:(RefreshLogo)style {
    
    if (style == RefreshLogoCommon) {
        self.zhituirenshu.image = [UIImage imageNamed:@"Applogo_opacity20_light"];
        [self changeLineColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
        self.showed.lineWidth = RING_LINE_WIDTH - 1;
        self.runRaius.lineWidth = RING_LINE_WIDTH - 1;
    }else if (style == RefreshLogoAlbum) {
        self.zhituirenshu.image = [UIImage imageNamed:@"Applogo_opacity20_dark"];
        [self changeLineColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:0.2]];
        self.showed.lineWidth = RING_LINE_WIDTH - 1;
        self.runRaius.lineWidth = RING_LINE_WIDTH - 1;
    }
    [self.zhituirenshu sizeToFit];
    self.zhituirenshu.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    [self addSubview:self.zhituirenshu];
    
}

- (void)changeLineColor:(UIColor *)color {
    
    self.showed.strokeColor = color.CGColor;
    self.runRaius.strokeColor = color.CGColor;
    
}


- (void)registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppActivity:)
                                                 name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppActivity:)
                                                 name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)handleAppActivity:(NSNotification *)notification {
    
    if (notification.name == UIApplicationDidEnterBackgroundNotification) {
        
        
        CFTimeInterval xinyongka =   [self.aliTeam convertTime:CACurrentMediaTime() fromLayer:nil];
        
        self.aliTeam.speed = 0;
        
        self.aliTeam.timeOffset = xinyongka;
        
    }else if (notification.name == UIApplicationWillEnterForegroundNotification) {
        
        
        CFTimeInterval xinyongka = self.aliTeam.timeOffset;
        
        self.aliTeam.speed = 1;
        
        self.aliTeam.timeOffset = 0;
        
        self.aliTeam.beginTime = 0;
        
        CFTimeInterval danbixiane = [self.aliTeam convertTime:CACurrentMediaTime() fromLayer:nil] - xinyongka;
        
        self.aliTeam.beginTime = danbixiane;
    }
}

#pragma mark - lazy
- (CALayer *)aliTeam {
    
    if (!_aliTeam) {
        _aliTeam = [CALayer layer];
        _aliTeam.frame = self.bounds;
        [self.layer addSublayer:_aliTeam];
    }
    return _aliTeam;
}

- (xxzTitleAlendar *)showed {
    
    if (!_showed) {
        _showed = [xxzTitleAlendar layerWithFrame:self.bounds];
        [self.aliTeam addSublayer:_showed];
    }
    return _showed;
}

- (xxzTitleAlendar *)runRaius {
    
    if (!_runRaius) {
        _runRaius = [xxzTitleAlendar layerWithFrame:self.bounds];
        [self.aliTeam addSublayer:_runRaius];
    }
    return _runRaius;
}

- (CABasicAnimation *)trade {
    
    if (!_trade) {
        _trade = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        _trade.fromValue = @(1 - STROKE_END_RADIAN);
        _trade.toValue = @(STROKE_PROCESS_RADIAN(160));
        _trade.duration = DRAW_LINE_RATE / SPEED;
        _trade.repeatCount = HUGE_VAL;
        _trade.removedOnCompletion = NO;
        _trade.autoreverses = YES;
    }
    return _trade;
}

- (CABasicAnimation *)shoukuanrenInyongka {
    
    if (!_shoukuanrenInyongka) {
        _shoukuanrenInyongka =[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _shoukuanrenInyongka.duration = self.trade.duration / RECURRENT;
        _shoukuanrenInyongka.fromValue = @(DRAW_LING_ROTATE + DEGREES_TO_RADIANS(30));
        _shoukuanrenInyongka.toValue = @(DRAW_LING_ROTATE + DEGREES_TO_RADIANS(30) + M_PI);
        _shoukuanrenInyongka.repeatCount = HUGE_VAL;
        _shoukuanrenInyongka.autoreverses = NO;
        _shoukuanrenInyongka.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    }
    return _shoukuanrenInyongka;
}

- (UIImageView *)zhituirenshu {
    if (!_zhituirenshu) {
        _zhituirenshu = [[UIImageView alloc]init];
    }
    return _zhituirenshu;
}

- (void)dealloc {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
