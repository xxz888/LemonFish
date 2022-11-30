
#import "xxzShopView.h"
#import <AVFoundation/AVFoundation.h>
#import "XMPlayerConfig.h"
#import "xxzInfo.h"
#import "xxzRticlesUppotView.h"
#import "xxzInfoView.h"
#import "xxzPdataSetting.h"
#import "xxzHideNameView.h"
#import "xxzPickerToast.h"
#import "xxzUpdate.h"

@interface xxzShopView ()<NSURLSessionDelegate>

@property (nonatomic, strong) AVPlayerItem *regJiaoyifei;
@property (nonatomic, strong) AVPlayerLayer *temp;
@property (nonatomic, strong) AVPlayer *tapPlay;

@property (nonatomic, strong) AVPlayerItem *topBounds;
@property (nonatomic, strong) AVPlayerLayer *data;
@property (nonatomic, strong) AVPlayer *raius;


@property (nonatomic,weak) UIView *cut;

@property(nonatomic, weak) xxzRticlesUppotView *shimingVersion;

@property (nonatomic,weak) UIImageView *hot;

@property (nonatomic, assign) BOOL enlarge;

@property (nonatomic,weak) UIButton *orderJiaoyijine;

@property (nonatomic,weak) UIView *back;

@property (nonatomic,strong) NSURLSessionDownloadTask *downloadTask;

@property (nonatomic, strong) xxzInfoView *keyMove;

@property (nonatomic, strong) NSURLSession *backgroundSession;

@property (nonatomic, weak) UIWindow *window;

@property (nonatomic, strong) xxzHideNameView *controlView;
@property (nonatomic, strong) id huxukaXinshoujiaochengblock;
@property (nonatomic, strong) id needWeekday;
@property (nonatomic, assign) CGRect xiaofei;  
@property (nonatomic, assign) float result; 
@property (nonatomic,assign) int middle;

@property (nonatomic,assign) int shengyushijian;
@property (nonatomic,assign) int nthDay;

@property (nonatomic,assign) BOOL imagesMargin;
@property (nonatomic, weak) UIButton *subviewChange;
@property (nonatomic, assign) CGRect formatter;


@property (nonatomic, assign) BOOL hourAgged;
@property (nonatomic, assign) BOOL tradingYouxiaoqi;  


@end

@implementation xxzShopView

#pragma mark - 懒加载


- (void)defaultConfiguration{
    
    
    self.isAllowDownload = YES;
    
    self.isAllowCyclePlay = YES;
}



- (void)loadTwoSynVideoTypeUI{
    
    
    UIView *downView = [[UIView alloc] init];
    downView.backgroundColor = [UIColor blackColor];
    downView.center = self.window.center;
    downView.bounds = self.window.bounds;
    downView.frame = self.frame;
    [self addSubview:downView];
    self.cut = downView;
    
    self.tradingYouxiaoqi = YES;
    
    
    
    self.regJiaoyifei = [AVPlayerItem playerItemWithURL:self.videoURL];
    
    self.tapPlay = [[AVPlayer alloc] initWithPlayerItem:self.regJiaoyifei];
    
    self.temp = [AVPlayerLayer playerLayerWithPlayer:self.tapPlay];
    self.temp.videoGravity = AVLayerVideoGravityResizeAspect;
    self.temp.frame = self.cut.bounds;
    
    [self.cut.layer addSublayer:self.temp];
    
    [self loadObserver:self.regJiaoyifei];
    
    [self loadNotification:self.regJiaoyifei];
    
    self.formatter = CGRectMake(0, 30, 100, 80);
    
    self.topBounds = [AVPlayerItem playerItemWithURL:self.subVideoURL];
    
    self.raius = [[AVPlayer alloc] initWithPlayerItem:self.topBounds];
    
    self.data = [AVPlayerLayer playerLayerWithPlayer:self.raius];
    self.data.videoGravity = AVLayerVideoGravityResizeAspect;
    self.data.frame = self.formatter;
    self.raius.volume = 0;
    
    [self.cut.layer addSublayer:self.data];
    [self.cut.layer insertSublayer:self.data above:self.temp];
    
    [self loadObserver:self.topBounds];
    
    [self loadNotification:self.topBounds];
    
    
    [self playerControlViewEvent];
    
    
    UIButton *zongshouxufeiBtn = [[UIButton alloc] init];
    zongshouxufeiBtn.frame = self.data.frame;
    zongshouxufeiBtn.backgroundColor = [UIColor clearColor];
    [zongshouxufeiBtn addTarget:self action:@selector(touchMinWindowVideoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:zongshouxufeiBtn];
    self.subviewChange = zongshouxufeiBtn;
    
    UIPanGestureRecognizer *yangkajigou = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(processgestureReconizer:)];
    [zongshouxufeiBtn addGestureRecognizer:yangkajigou];
}



- (void)downLoadVideo{
    
    self.downloadTask = [self.backgroundSession downloadTaskWithURL:self.videoURL];
    [self.downloadTask resume];
    
}



- (void)loadObserver:(AVPlayerItem *)regJiaoyifei{
    
    
    
    [regJiaoyifei addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [regJiaoyifei addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [regJiaoyifei addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
    [regJiaoyifei addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
    [regJiaoyifei addObserver:self forKeyPath:@"playbackBufferFull" options:NSKeyValueObservingOptionNew context:nil];
    
    
    __weak typeof(self) weakSelf = self;
    self.huxukaXinshoujiaochengblock = [self.tapPlay addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        
        weakSelf.result = (double)weakSelf.tapPlay.currentItem.currentTime.value / weakSelf.tapPlay.currentItem.currentTime.timescale;
        [weakSelf updateVideoSlider:weakSelf.result];
    }];
    
    if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
        self.needWeekday = [self.raius addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            
            float share = (double)weakSelf.raius.currentItem.currentTime.value/ weakSelf.raius.currentItem.currentTime.timescale;
            [weakSelf updateVideoSlider2:share];
        }];
    }
}


- (void)applicationWillResignActive {
    [self pause];
}


- (void)show{
    
    if (self.playerViewType == XMPlayerViewWechatShortVideoType) {
        
        if (!self.currentImage) {
            NSLog(@"currentImage为null");
            return;
        }
        
        if (!self.videoURL) {
            NSLog(@"%@",XMVideoUrlText);
            return;
        }
        
        if (!self.sourceImagesContainerView) {
            NSLog(@"sourceImagesContainerView为null");
            return;
        }
        
        
        [self loadBgView];
        
        
        [self loadWechatShortVideoTypeUI];
        
    }else if (self.playerViewType == XMPlayerViewAiqiyiVideoType){
        
        
        [self loadAiqiyiVideoTypeUI];
        
    }else if (self.playerViewType == XMPlayerViewTwoSynVideoType){
        
        
        [self loadTwoSynVideoTypeUI];
    }
    
    
    CGFloat nvite = 40;
    CGFloat liebianrenshu = (self.cut.width - nvite)/2.0;
    CGFloat rgb = (self.cut.height - nvite)/2.0;
    xxzRticlesUppotView *alendarView = [xxzRticlesUppotView refreshViewWithFrame:CGRectMake(liebianrenshu, rgb, nvite, nvite) logoStyle:RefreshLogoNone];
    [self.cut addSubview:alendarView];
    [alendarView startAnimation];
    self.shimingVersion = alendarView;
}


- (void)tapAction{
    
    UIView *nearestView = [self.sourceImagesContainerView.subviews firstObject];
    
    CGRect confirm = [self.sourceImagesContainerView convertRect:nearestView.frame toView:self];
    self.window.windowLevel = UIWindowLevelNormal;
    
    self.keyMove = nil;
    
    [self removePlayer];
    
    [UIView animateWithDuration:XMImageAnimationDuration animations:^{

        self.hot.frame = confirm;
        self.backgroundColor = [UIColor clearColor];
        self.cut.backgroundColor = [UIColor clearColor];
        self.alpha = 0;

    } completion:^(BOOL finished) {
    
        
        self.shimingVersion.hidden = YES;
        self.hot.hidden = YES;
        self.cut.hidden = YES;
        self.shimingVersion = nil;
        self.hot = nil;
        self.keyMove = nil;
        self.hidden = YES;
        _regJiaoyifei = nil;
        self.temp = nil;
        
        [self.backgroundSession invalidateAndCancel];
        self.backgroundSession = nil;
        
        [self.downloadTask suspend];
        self.downloadTask = nil;
        
        [self removeAllSubviews];
        [self.keyMove removeFromSuperview];
        [self.back removeFromSuperview];
        [self.orderJiaoyijine removeFromSuperview];
        [self.cut removeFromSuperview];
        self.back = nil;
        self.keyMove = nil;
        self.cut = nil;
        self.window = nil;
    }];
}



- (void)twoVideoRotatingScreenLayoutSubviewsWithIsFullScreen:(BOOL)isFullScreen{
    
    self.cut.frame = self.frame;
    CGFloat offset = 1.6;
    if (self.subviewChange.selected) {  
        if (isFullScreen) {
            self.temp.frame = CGRectMake(self.formatter.origin.x, self.formatter.origin.y, self.formatter.size.width*offset, self.formatter.size.height*offset);
        }else{
            self.temp.frame = self.formatter;
        }
        self.data.frame = self.cut.frame;
        self.subviewChange.frame = self.temp.frame;
        [self.cut.layer insertSublayer:self.temp above:self.data];
    }else{ 
        self.temp.frame = self.cut.frame;
        if (isFullScreen) {
            self.data.frame = CGRectMake(self.formatter.origin.x, self.formatter.origin.y, self.formatter.size.width*offset, self.formatter.size.height*offset);
        }else{
            self.data.frame = self.formatter;
        }
        self.subviewChange.frame = self.data.frame;
        [self.cut.layer insertSublayer:self.data above:self.temp];
    }
}



- (void)updateVideoSlider:(float)result
{
    CMTime base = _regJiaoyifei.duration;
    self.controlView.totalTimeLabel.text = [xxzPickerToast getMMSSFromSS:[NSString stringWithFormat:@"%.0f", CMTimeGetSeconds(base)]];
    
    if (!self.imagesMargin){
        self.controlView.playTimeLabel.text = [xxzPickerToast getMMSSFromSS:[NSString stringWithFormat:@"%.0f", result]];
        self.controlView.playerSilder.trackValue = result / CMTimeGetSeconds(base);
    }
}



- (void)saveVideo{
    
    
    [self mengbanViewClick];
    
    xxzInfoView *suppotView = [[xxzInfoView alloc] initWithFrame:CGRectMake((WIDTH-80)/2.0, (HEIGHT-80)/2.0, 80, 80)];
    suppotView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    suppotView.progress = 0;
    [self.cut addSubview:suppotView];
    self.keyMove = suppotView;
    
    
    [self downLoadVideo];
}



- (void)layoutSubviews{
    
    if (self.playerViewType == XMPlayerViewWechatShortVideoType) {
        if (!_enlarge) {
            [self showFirstImage];
        }
    }else if (self.playerViewType == XMPlayerViewAiqiyiVideoType || self.playerViewType == XMPlayerViewTwoSynVideoType){
        self.controlView.frame = self.bounds;
    }
}


- (void)play{
    
    if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
        [self.raius play];
    }
    [self.tapPlay play];
    
    [self endAnimation];
}


- (void)endAnimation{
    
    XMLog(@"结束旋转");
    [self.shimingVersion stopAnimation];
    self.shimingVersion.hidden = YES;
}


- (void)orientationHandler {
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        
        if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) { 
            
            _isFullScreen = YES;
            self.controlView.fullScreenButton.selected = YES;
            [self deviceLandscape];
            
        }else { 
            
        }
    }else if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) { 
            _isFullScreen = NO;
            self.controlView.fullScreenButton.selected = NO;
            [self devicePortrait];
        }else{
            
        }
    }
    self.shimingVersion.center = self.cut.center;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (!_isFullScreen) {
        _xiaofei = frame;
    }
}



- (void)playbackFinished{
    
    if (self.isAllowCyclePlay) {
        
        [self.tapPlay seekToTime:CMTimeMake(0, 1)];
        [self.tapPlay play];
        
    }else{
        
        [self tapAction];
    }
    
    [self.regJiaoyifei seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        
    }];
    self.controlView.playButton.selected = NO;
    [self pause];
}



- (void)updateVideoSlider2:(float)result{
    
    CMTime baseG = self.topBounds.duration;
}



- (void)processgestureReconizer:(UIGestureRecognizer *)gesture {
    
    if (self.playerViewType == XMPlayerViewWechatShortVideoType) {
        
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]] &&
            gesture.state == UIGestureRecognizerStateBegan) { 
            if (!self.keyMove) { 
                _back.hidden = NO;
                self.orderJiaoyijine.hidden = NO;
                [UIView animateWithDuration:0.2 animations:^{
                    self.orderJiaoyijine.alpha = 0.5;
                    if (IS_PhoneX) { 
                        _back.y = HEIGHT - (106 + 36);
                    }else{
                        _back.y = HEIGHT - 106;
                    }
                }];
            }
        }
    }else if (self.playerViewType == XMPlayerViewTwoSynVideoType){
        
        if ([gesture isKindOfClass:[UIPanGestureRecognizer class]]) { 
            
            UIPanGestureRecognizer *tip = (UIPanGestureRecognizer *)gesture;
            static CGPoint bottom;
            if (tip.state == UIGestureRecognizerStateBegan) {
                bottom = self.subviewChange.center;
            }else if (tip.state == UIGestureRecognizerStateChanged) {
                
                CGPoint pre = [tip translationInView:self.subviewChange];
                XMLog(@"translation:%@",NSStringFromCGPoint(pre));
                CGFloat lbl = bottom.x + pre.x;
                CGFloat upgrade = bottom.y + pre.y;
                CGFloat jiaoyishijian = self.subviewChange.width/2.0;
                CGFloat ali = self.width - self.subviewChange.width/2.0;
                CGFloat register_so = self.subviewChange.height/2.0;
                CGFloat nav = self.height - self.subviewChange.height/2.0;
                if (lbl <= jiaoyishijian) {
                    lbl = jiaoyishijian;
                }
                if (lbl >= ali) {
                    lbl = ali;
                }
                if (upgrade <= register_so) {
                    upgrade = register_so;
                }
                if (upgrade >= nav) {
                    upgrade = nav;
                }
                
                self.subviewChange.center = CGPointMake(lbl, upgrade);
                if (self.subviewChange.selected) {  
                    self.temp.frame = self.subviewChange.frame;
                }else{ 
                    
                    self.data.frame = self.subviewChange.frame;
                }
            }else if (tip.state == UIGestureRecognizerStateEnded) {
                bottom = CGPointZero;
            }
        }
    }
}


- (void)playerControlViewEvent{
    
    self.controlView = [[xxzHideNameView alloc] initWithFrame:self.bounds];
    [self addSubview:self.controlView];
    
    
    
    [self.controlView.closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.controlView.fullScreenButton addTarget:self action:@selector(fullScreenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.controlView.playButton addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak typeof(self) weakSelf = self;
    
    
    self.controlView.tapChangeimgValue = ^(float moveX) {
        [weakSelf dragTheInterfaceWithMoveX:moveX withIsDraging:YES];
    };
    
    self.controlView.tapChangedValue = ^(float moveX) {
        [weakSelf dragTheInterfaceWithMoveX:moveX withIsDraging:NO];
    };
    
    
    self.controlView.playerSilder.tapChangeimgValue = ^(float value) {
        [weakSelf videoProgressWithChangeimgValue:value];
    };
    
    self.controlView.playerSilder.tapChangedValue = ^(float value) {
        [weakSelf videoProgressWithchangedValue:value];
    };
}


- (void)loadGesture{
    
    
    UITapGestureRecognizer *camera =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    
    camera.numberOfTapsRequired =1;
    
    
    
    [self addGestureRecognizer:camera];
    
    
    if (self.isAllowDownload) {
        
        UILongPressGestureRecognizer *tuandui = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(processgestureReconizer:)];
        tuandui.minimumPressDuration = 1.0;
        [self addGestureRecognizer:tuandui];
    }
}


- (void)applicationWillEnterForeground {
    
    [self play];
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    
    NSString *unicode=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    
    
    NSString *ketixian=[unicode stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:ketixian] error:nil];
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(ketixian)) {
        
        UISaveVideoAtPathToSavedPhotosAlbum(ketixian, self, nil, nil);
    }
}


- (void)videoProgressWithchangedValue:(CGFloat)value{
    
    CMTime baseW = self.regJiaoyifei.duration;
    
    [self.tapPlay seekToTime:CMTimeMake(CMTimeGetSeconds(baseW)*value, 1)];
    if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
        [self.raius seekToTime:CMTimeMake(CMTimeGetSeconds(baseW)*value, 1)];
    }
    self.imagesMargin = NO;;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    AVPlayerItem *lineItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        
        AVPlayerStatus anner = [[change objectForKey:@"new"] intValue]; 
        
        if (anner == AVPlayerStatusReadyToPlay) {
            
            XMLog(@"AVPlayerStatusReadyToPlay");
            
            
            
            
            
            if (self.playerViewType == XMPlayerViewWechatShortVideoType) {
                [self play];
            }else if (self.playerViewType == XMPlayerViewAiqiyiVideoType){
                self.controlView.playButton.selected = NO;
                [self play];
            }
            
        } else if (anner == AVPlayerStatusFailed) {
            XMLog(@"AVPlayerStatusFailed");
            
            [self playFailed];
        } else {
            
            XMLog(@"AVPlayerStatusUnknown");
            
            [self playFailed];
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  
        
        NSArray *suppot = lineItem.loadedTimeRanges;
        
        CMTimeRange rate = [suppot.firstObject CMTimeRangeValue];
        float footer = CMTimeGetSeconds(rate.start);
        float titles = CMTimeGetSeconds(rate.duration);
        
        NSTimeInterval zaixiankefublock = footer + titles;
        [self updateVideoBufferProgress:zaixiankefublock];
        
        self.middle = [[NSString stringWithFormat:@"%.0f", zaixiankefublock] intValue];
        
        if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
            
            if (lineItem == self.regJiaoyifei) {
                            XMLog(@"当前缓存时间视频1:%@",[NSString stringWithFormat:@"%.0f", zaixiankefublock]);
                self.shengyushijian = [[NSString stringWithFormat:@"%.0f", zaixiankefublock] intValue];
            }else if (lineItem == self.topBounds){
                
                            XMLog(@"当前缓存时间视频2:%@",[NSString stringWithFormat:@"%.0f", zaixiankefublock]);
                self.nthDay = [[NSString stringWithFormat:@"%.0f", zaixiankefublock] intValue];
            }
            
//            self.middle = (self.shengyushijian <= self.nthDay)?self.playBufferTime1:self.nthDay;
            
            XMLog(@"当前缓存时间视频最小值:%d",self.middle);
            
            if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
                
                if (self.tradingYouxiaoqi) {
                    if (self.middle>=10) {
                        [self play];
                        self.tradingYouxiaoqi = NO;
                    }else{
                        [self pause];
                    }
                }
            }
        }
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { 
        
        XMLog(@"缓冲不足暂停了");
        [self pause];
        [self startAnimation];
        
    } else if ([keyPath isEqualToString:@"playbackLikelyToKeepUp"]) {
        
        XMLog(@"缓冲达到可播放程度了");
        if (!self.hourAgged) { 
            if (self.regJiaoyifei.playbackLikelyToKeepUp) {  
                
                if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
                    if (!self.tradingYouxiaoqi) {
                        
                        [self endAnimation];
                        
                        [self play];
                    }
                }else{
                    
                    [self play];
                }
            }
        }
    } else if ([keyPath isEqualToString:@"playbackBufferFull"]) {
        
        XMLog(@"缓冲区满了");
    }
}



- (void)updateVideoBufferProgress:(NSTimeInterval)buffer
{
    CMTime basef = _regJiaoyifei.duration;
    self.controlView.playerSilder.bufferValue = buffer / CMTimeGetSeconds(basef);
}



- (void)loadWechatShortVideoTypeUI{
    
    
    self.regJiaoyifei = [AVPlayerItem playerItemWithURL:self.videoURL];
    
    self.tapPlay = [[AVPlayer alloc] initWithPlayerItem:self.regJiaoyifei];
    
    self.temp = [AVPlayerLayer playerLayerWithPlayer:self.tapPlay];
    self.temp.videoGravity = AVLayerVideoGravityResizeAspect;
    self.temp.frame = self.cut.bounds;
    self.temp.delegate = self;
    
    
    [self.cut.layer addSublayer:self.temp];
    
    
    
    [self loadObserver:self.regJiaoyifei];
    
    [self loadNotification:self.regJiaoyifei];
    
    
    [self loadGesture];
}



- (void)fullScreenButtonClick {
    
    self.controlView.fullScreenButton.selected = !self.controlView.fullScreenButton.isSelected;
    if (self.controlView.fullScreenButton.selected) {
        [xxzUpdate interfaceOrientation:UIInterfaceOrientationLandscapeRight];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }else{
        [xxzUpdate interfaceOrientation:UIInterfaceOrientationPortrait];
        self.frame = _xiaofei;
    }
    
    if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
        
        [self twoVideoRotatingScreenLayoutSubviewsWithIsFullScreen:self.controlView.fullScreenButton.selected];
    }
    self.shimingVersion.center = self.cut.center;
}

#pragma mark - 菊花状态

- (void)loadNotification:(AVPlayerItem *)regJiaoyifei{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification object:regJiaoyifei];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFailed) name:AVPlayerItemFailedToPlayToEndTimeNotification object:regJiaoyifei];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFailed) name:AVPlayerItemFailedToPlayToEndTimeErrorKey object:regJiaoyifei];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationHandler)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}


- (void)loadAiqiyiVideoTypeUI{
    
    
    UIView *downView1 = [[UIView alloc] init];
    downView1.backgroundColor = [UIColor blackColor];
    downView1.center = self.window.center;
    downView1.bounds = self.window.bounds;
    downView1.frame = self.frame;
    [self addSubview:downView1];
    self.cut = downView1;
    
    
    
    self.regJiaoyifei = [AVPlayerItem playerItemWithURL:self.videoURL];
    
    self.tapPlay = [[AVPlayer alloc] initWithPlayerItem:self.regJiaoyifei];
    
    self.temp = [AVPlayerLayer playerLayerWithPlayer:self.tapPlay];
    self.temp.videoGravity = AVLayerVideoGravityResizeAspect;
    self.temp.frame = self.cut.bounds;
    
    [self.cut.layer addSublayer:self.temp];
    
    [self loadObserver:self.regJiaoyifei];
    
    [self loadNotification:self.regJiaoyifei];
    
    [self playerControlViewEvent];
}

#pragma mark 长按手势

- (void)removePlayer{
    
    if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
        [self.raius pause];
        [self.raius setRate:0];
        [self.raius.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        [self.raius.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
        [self.raius.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty" context:nil];
        [self.raius.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:nil];
        [self.raius.currentItem removeObserver:self forKeyPath:@"playbackBufferFull" context:nil];
        [self.raius replaceCurrentItemWithPlayerItem:nil];
        [self.raius removeTimeObserver:self.needWeekday];
        self.raius = nil;
    }
    
    [self.tapPlay pause];
    [self.tapPlay setRate:0];
    [self.tapPlay.currentItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.tapPlay.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [self.tapPlay.currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty" context:nil];
    [self.tapPlay.currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp" context:nil];
    [self.tapPlay.currentItem removeObserver:self forKeyPath:@"playbackBufferFull" context:nil];
    [self.tapPlay replaceCurrentItemWithPlayerItem:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    if (self.temp != XMPlayerViewWechatShortVideoType) {
        [self.tapPlay removeTimeObserver:self.huxukaXinshoujiaochengblock];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.tapPlay = nil;
}

#pragma mark - 下载视频


- (void)deviceLandscape{
    
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self twoVideoRotatingScreenLayoutSubviewsWithIsFullScreen:YES];
}



- (void)showFirstImage{
    
    UIView *nearestViewo = [self.sourceImagesContainerView.subviews firstObject];
    
    CGRect corner = [self.sourceImagesContainerView convertRect:nearestViewo.frame toView:self];
    
    
    
    UIImageView *short_nView = [[UIImageView alloc] init];
    short_nView.frame = corner;
    short_nView.image = self.currentImage;
    [self addSubview:short_nView];
    self.hot = short_nView;
    short_nView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat yangkajigou5 = short_nView.image.size.width;
    CGFloat score = short_nView.image.size.height;
    CGRect confirmO;
    
    CGFloat sub_ = (score * WIDTH)/yangkajigou5;
    if (sub_ <= HEIGHT) {
        confirmO = CGRectMake(0, (HEIGHT - sub_) * 0.5 , WIDTH, sub_);
    } else {
        confirmO = CGRectMake(0, 0, WIDTH, sub_);
    }
    
    [UIView animateWithDuration:XMImageAnimationDuration animations:^{
        
        short_nView.frame = confirmO;
    } completion:^(BOOL finished) {
        
        _enlarge = YES;
    }];
}

#pragma mark NSSessionUrlDelegate


- (void)loadBgView{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.window = window;
    
    
    UIView *downViewp = [[UIView alloc] init];
    downViewp.backgroundColor = [UIColor blackColor];
    downViewp.center = self.window.center;
    downViewp.bounds = self.window.bounds;
    self.center = CGPointMake(downViewp.bounds.size.width * 0.5, downViewp.bounds.size.height * 0.5);
    self.bounds = CGRectMake(0, 0, downViewp.bounds.size.width, downViewp.bounds.size.height);
    [downViewp addSubview:self];
    self.cut = downViewp;
    
    
    [self.window addSubview:downViewp];
    
    self.window.windowLevel = UIWindowLevelStatusBar + 10.0f;
}



- (void)setIsFullScreen:(BOOL)isFullScreen
{
    _isFullScreen = isFullScreen;
    if (isFullScreen) {
        [self fullScreenButtonClick];
    }
}



- (void)mengbanViewClick{
    
    [UIView animateWithDuration:0.1 animations:^{
        self.orderJiaoyijine.alpha = 0;
        _back.y = HEIGHT;
    } completion:^(BOOL finished) {
        _back.hidden = YES;
        self.orderJiaoyijine.hidden = YES;
    }];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        
        
        [self defaultConfiguration];
    }
    return self;
}



- (void)pause
{
    if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
        [self.raius pause];
    }
    [self.tapPlay pause];
}



- (void)closeButtonClick{
    
    if (_isFullScreen) { 
        
        self.controlView.fullScreenButton.selected = NO;
        [xxzUpdate interfaceOrientation:UIInterfaceOrientationPortrait];
        self.frame = _xiaofei;
        self.shimingVersion.center = self.cut.center;
        if (self.playerViewType == XMPlayerViewTwoSynVideoType) {
            
            [self twoVideoRotatingScreenLayoutSubviewsWithIsFullScreen:self.controlView.fullScreenButton.selected];
        }
    }else{ 
        
    }
}


- (void)progressOverAndChangeViewContents {
    
    XMLog(@"下载完成");
    [xxzPdataSetting xm_showText:XMVideoDownFinish];
    
    [self.backgroundSession finishTasksAndInvalidate];
    self.keyMove.progress = 0;
    self.keyMove.hidden = YES;
    self.keyMove = nil;
}

- (void)playFailed{
    
    [xxzPdataSetting xm_showText:XMVideoPlayFialText];
    
    [self.tapPlay pause];
    
    
    [self endAnimation];
}


- (void)playClick:(UIButton *)sender{
    
    sender.selected = !sender.isSelected;
    self.hourAgged = sender.selected;
    if (sender.selected) {
        [self pause];
    }else{
        [self play];
    }
}


- (void)touchMinWindowVideoBtnClick:(UIButton *)sender{
    
    CGRect xinyongkablock = self.data.frame;
    self.data.frame = self.temp.frame;
    self.temp.frame = xinyongkablock;
    sender.selected = !sender.isSelected;
    if (sender.selected) {
        [self.cut.layer insertSublayer:self.temp above:self.data];
    }else{
        [self.cut.layer insertSublayer:self.data above:self.temp];
    }
}


- (UIButton *)orderJiaoyijine{
    
    if (_orderJiaoyijine == nil) {
        
        
        UIButton *channelView = [[UIButton alloc] init];
        channelView.frame = self.bounds;
        channelView.hidden = YES;
        channelView.backgroundColor = [UIColor blackColor];
        channelView.alpha = 0;
        [channelView addTarget:self action:@selector(mengbanViewClick) forControlEvents:UIControlEventTouchUpInside];
        [self.cut addSubview:channelView];
        _orderJiaoyijine = channelView;
        
        
        UIView *zhituirenshuView = [[UIView alloc] init];
        zhituirenshuView.backgroundColor = XMRGBColor(160, 160, 160);
        [self.cut addSubview:zhituirenshuView];
        _back = zhituirenshuView;
        
        if (IS_PhoneX) { 
            zhituirenshuView.frame = CGRectMake(0, HEIGHT, WIDTH , 106 + 36);
        }else{
            zhituirenshuView.frame = CGRectMake(0, HEIGHT, WIDTH , 106);
        }
        
        
        UIButton *goodsBtn = [[UIButton alloc] init];
        goodsBtn.frame = CGRectMake(0, 0, WIDTH, 50);
        goodsBtn.backgroundColor = [UIColor whiteColor];
        [goodsBtn setTitle:@"保存" forState:UIControlStateNormal];
        [goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        goodsBtn.titleLabel.font = XM18Font;
        [goodsBtn addTarget:self action:@selector(saveVideo) forControlEvents:UIControlEventTouchUpInside];
        [zhituirenshuView addSubview:goodsBtn];
        
        
        UIButton *changedBtn = [[UIButton alloc] init];
        changedBtn.frame = CGRectMake(0, 56, WIDTH, 50);
        changedBtn.backgroundColor = [UIColor whiteColor];
        [changedBtn setTitle:@"取消" forState:UIControlStateNormal];
        [changedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        changedBtn.titleLabel.font = XM18Font;
        [changedBtn addTarget:self action:@selector(mengbanViewClick) forControlEvents:UIControlEventTouchUpInside];
        [zhituirenshuView addSubview:changedBtn];
    }
    
    return  _orderJiaoyijine;
}


- (void)devicePortrait{
    
    self.frame = _xiaofei;
    [self twoVideoRotatingScreenLayoutSubviewsWithIsFullScreen:NO];
}


- (NSURLSession *)backgroundSession {
    
    if (!_backgroundSession) {
        NSURLSessionConfiguration *seconds = [NSURLSessionConfiguration defaultSessionConfiguration];
        _backgroundSession = [NSURLSession sessionWithConfiguration:seconds delegate:self delegateQueue:nil];
    }
    return _backgroundSession;
}


- (void)startAnimation{
    
    XMLog(@"开始旋转");
    [self.shimingVersion startAnimation];
    self.shimingVersion.hidden = NO;
}


- (void)videoProgressWithChangeimgValue:(CGFloat)value{
    
    self.imagesMargin = YES;
    CMTime base9 = self.regJiaoyifei.duration;
    self.controlView.playTimeLabel.text = [xxzPickerToast getMMSSFromSS:[NSString stringWithFormat:@"%.0f", CMTimeGetSeconds(base9) * value]];
    self.controlView.playerSilder.trackValue = value;
}


- (void)dealloc{
    
    XMLog(@"XMPlayer_dealloc");
    [self removePlayer];
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.tapPlay = nil;
    self.raius = nil;
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    CGFloat shoukuanren = totalBytesWritten / (double)totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
    
        
        XMLog(@"进度：%f",shoukuanren);
        self.keyMove.progress = shoukuanren;
        
        if (shoukuanren==1) {
            [self progressOverAndChangeViewContents];
        }
    });
}


- (void)dragTheInterfaceWithMoveX:(CGFloat)moveX withIsDraging:(BOOL)imagesMargin{
    
    CMTime baseJ = self.regJiaoyifei.duration;
    
    CGFloat dengji = self.width/2.0;
    
    CGFloat save =  (self.result/([[NSString stringWithFormat:@"%.0f", CMTimeGetSeconds(baseJ)] intValue]*1.0)) * dengji;
    
    CGFloat camerav = (save + moveX) / dengji;
    
    if (camerav>=1) {
        camerav = 1;
    }else if (camerav <= 0){
        camerav = 0;
        self.tradingYouxiaoqi = YES;
    }
    
    if (imagesMargin) {
        [self videoProgressWithChangeimgValue:camerav];
    }else{
        [self videoProgressWithchangedValue:camerav];
    }
}


@end
