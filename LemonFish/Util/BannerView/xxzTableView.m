
#import "xxzTableView.h"
#import "UIImageView+WebCache.h"
@interface xxzTableView()<CAAnimationDelegate>

@property (nonatomic,strong) UIImageView *shezhiOast;                  
@property (nonatomic,strong) NSArray *orget;                       
@property (nonatomic, strong) NSTimer *segment;                     
@property (nonatomic, strong) UIPageControl *forget;           
@end

@implementation xxzTableView
{
    CGFloat SELFWIDTH;
    CGFloat SELFHEIGHT;
    NSInteger totalNumber;
    NSInteger currentPage;
    NSMutableArray *bannerImageArray;
    NSInteger bannerSourceType;
}

- (void)handleSwipeFromRight{
    currentPage++;
    if (currentPage >= self.orget.count) {
        currentPage = 0;
    }
    self.forget.currentPage = currentPage;

    if (bannerSourceType == 0) {
        self.shezhiOast.image = [UIImage imageNamed:self.orget[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.shezhiOast sd_setImageWithURL:[NSURL URLWithString:self.orget[currentPage]]];
    }
    
    
    CATransition *clean = [[CATransition alloc] init];
    clean.type = @"cube";                
    clean.subtype = kCATransitionFromRight;
    clean.duration = 0.5;
    clean.delegate = self;
    [self.shezhiOast.layer addAnimation:clean forKey:nil];
    

}

#pragma mark - SetMethod

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    self.forget.pageIndicatorTintColor = pageIndicatorTintColor;
}

- (void)setTimeInterval:(CGFloat)timeInterval {
    _timeInterval = fabs(timeInterval);
    if (self.segment) {
        [self.segment invalidate];
        [self setupTimer:_timeInterval];
    }
}


- (void)setShowPageControl:(BOOL)showPageControl {
    if (showPageControl == YES) {
        [self addSubview:self.forget];
    }
}

#pragma mark - LazyLoad

- (void)setupTimer:(CGFloat)timeInterval {
    self.segment = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(handleSwipeFromRight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.segment forMode:NSDefaultRunLoopMode];
}


- (void)tapImgView{
    
    if ([self.delegate respondsToSelector:@selector(hhBannerView:didSelectItemAtIndex:)]) {
        [self.delegate hhBannerView:self didSelectItemAtIndex:currentPage];
    }
}

- (void)animationDidStart:(CAAnimation *)theAnimation{
    if (self.segment) {
        [self.segment invalidate];
    }
    self.shezhiOast.userInteractionEnabled = NO;
}


- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    self.forget.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}


- (instancetype)initWithFrame:(CGRect)frame WithBannerSource:(NinaBannerSource)bannerSource WithBannerArray:(NSArray *)bannerArray{
    if (self = [super initWithFrame:frame]) {
        SELFWIDTH = frame.size.width;
        SELFHEIGHT = frame.size.height;
        totalNumber = bannerArray.count;
        currentPage = 0;
        _orget = bannerArray;
        bannerSourceType = bannerSource;
        
        self.orget = bannerArray;
        self.shezhiOast = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.shezhiOast.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shezhiOast];
        self.shezhiOast.userInteractionEnabled = YES;
        if (bannerSourceType == 0) {
            self.shezhiOast.image = [UIImage imageNamed:self.orget[currentPage]];
        }else if (bannerSourceType == 1) {
            [self.shezhiOast sd_setImageWithURL:[NSURL URLWithString:self.orget[currentPage]]];
        }

        UISwipeGestureRecognizer *tixian = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight)];
        [tixian setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.shezhiOast addGestureRecognizer:tixian];

        UISwipeGestureRecognizer *slider = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft)];
        [slider setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.shezhiOast addGestureRecognizer:slider];
        
        UITapGestureRecognizer *r_manager = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView)];
        [self.shezhiOast addGestureRecognizer:r_manager];
        [self setupTimer:5];
    }
    return self;
}

- (void)handleSwipeFromLeft{
    
    currentPage--;
    if (currentPage < 0 ) {
        currentPage = self.orget.count-1;
    }
    self.forget.currentPage = currentPage;
    
    if (bannerSourceType == 0) {
        self.shezhiOast.image = [UIImage imageNamed:self.orget[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.shezhiOast sd_setImageWithURL:[NSURL URLWithString:self.orget[currentPage]]];
    }

    CATransition *oney = [[CATransition alloc] init];
    oney.type = @"cube";
    oney.subtype = kCATransitionFromLeft;
    oney.duration = 0.5;
    oney.delegate = self;
    [self.shezhiOast.layer addAnimation:oney forKey:nil];
    

}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.timeInterval > 0) {
        [self setupTimer:self.timeInterval];
    }else {
        [self setupTimer:5.0];
    }
    self.shezhiOast.userInteractionEnabled = YES;
}


- (UIPageControl *)forget {
    
    if (!_forget) {
        _forget = [UIPageControl new];
        _forget.numberOfPages = totalNumber;
        CGSize size = [_forget sizeForNumberOfPages:totalNumber];
        _forget.frame = CGRectMake(0, 0, size.width, size.height);
        _forget.center = CGPointMake(self.center.x, SELFHEIGHT - 8);
        _forget.currentPageIndicatorTintColor = [UIColor whiteColor];
        _forget.pageIndicatorTintColor = [UIColor grayColor];
        _forget.hidesForSinglePage = YES;
    }
    return _forget;
}
@end
