
#import "xxzListTitleView.h"
@interface xxzListTitleView()<UIScrollViewDelegate>
{
  NSInteger _currentPage; 
  NSTimer *_timer; 
}
@property (nonatomic,assign) BOOL sing;
@property (nonatomic,strong) NSMutableArray *numCycle;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *forget;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@end

@implementation xxzListTitleView


-(void)createSro{
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _scrollView.contentSize = CGSizeMake(_width*self.numCycle.count, _height);
    for (int i = 0; i < self.numCycle.count; i++) {
        UIImageView *wideoView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_width, 0, _width, _height)];
        if ([self.numCycle[i] isKindOfClass:[UIImage class]]) {
            wideoView.image = self.numCycle[i];
        }else{
            [wideoView sd_setImageWithURL:self.numCycle[i] placeholderImage:[UIImage imageNamed:@"home_banner_blank"]];
        }
        wideoView.userInteractionEnabled = YES;
        wideoView.tag = 200+i;
        UITapGestureRecognizer *camera = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [wideoView addGestureRecognizer:camera];
        [_scrollView addSubview:wideoView];
    }
    _scrollView.layer.cornerRadius = 5;
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _scrollView.bounces = NO;
    
    _scrollView.contentOffset = CGPointMake(_width, 0);
    
    _scrollView.delegate = self;
    
    _scrollView.pagingEnabled = YES;
    [self addSubview:_scrollView];
  
}

-(void)createTimer{
  if (_sing == YES) {
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(change) userInfo:nil repeats:YES ];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];  }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  if (_timer) {
    
    [_timer setFireDate:[NSDate distantFuture]];
  }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  if (_timer) {
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
  }
  
  
  
  CGPoint tabbar = _scrollView.contentOffset;
  if (tabbar.x == (self.numCycle.count-1)*_width) {
    scrollView.contentOffset = CGPointMake(_width, 0);
  }
  if (tabbar.x == 0) {
    scrollView.contentOffset = CGPointMake((self.numCycle.count-2)*_width, 0);
  }
  
  CGPoint button = scrollView.contentOffset;
  _currentPage = button.x/_width;
  _forget.currentPage = _currentPage-1;
}

-(id)initWithFrame:(CGRect)frame andImageNameArray:(NSMutableArray *)imageNameArray andIsRunning:(BOOL)isRunning{
  self = [super initWithFrame:frame];
  if (self) {
    _width = self.frame.size.width;
    _height = self.frame.size.height;
    
    self.numCycle = [NSMutableArray arrayWithArray:imageNameArray];
    
    [self.numCycle addObject:[imageNameArray firstObject]];
    
    [self.numCycle insertObject:[imageNameArray lastObject] atIndex:0];
    self.sing = isRunning;
    _currentPage = 0;
    [self createSro];
    [self createPageControl];
    [self createTimer];
  }
  return self;
}

-(void)createPageControl{
  _forget = [[UIPageControl alloc]initWithFrame:CGRectMake(_width-200, _height-30, 100, 30)];
  _forget.centerX = _width/2;
  _forget.numberOfPages = self.numCycle.count-2;
  _forget.pageIndicatorTintColor = [UIColor whiteColor];
  _forget.currentPageIndicatorTintColor = [UIColor whiteColor];
  _forget.userInteractionEnabled = NO;
  [self addSubview:_forget];
}
#pragma mark UIScrollViewDelegate

-(void)tap:(UITapGestureRecognizer *)tap{
  if(_delegate&&[_delegate respondsToSelector:@selector(sendImageName:)]){
    [_delegate sendImageName:tap.view.tag-201];
  }else{
    NSLog(@"没有设置代理或者没有事先协议的方法");
  }
}

-(void)change{
  
  CGPoint tabbarz = _scrollView.contentOffset;
  
  CGPoint buttonz = CGPointMake(tabbarz.x+_width, 0);
  
  if (buttonz.x == (self.numCycle.count-1)*_width) {
    [UIView animateWithDuration:0.25 animations:^{
        self->_scrollView.contentOffset = CGPointMake(buttonz.x, 0);
    } completion:^(BOOL finished) {
      
        self->_scrollView.contentOffset = CGPointMake(self->_width, 0);
        CGPoint remenhuodong = self->_scrollView.contentOffset;
        
        self->_currentPage = remenhuodong.x/self->_width;
        self->_forget.currentPage = self->_currentPage-1;
    }];
  }
  else{
    
      [UIView animateWithDuration:0.25 animations:^{
          self->_scrollView.contentOffset = buttonz;
    } completion:^(BOOL finished) {
    }];
        CGPoint remenhuodong = _scrollView.contentOffset;
    
    _currentPage = remenhuodong.x/_width;
    _forget.currentPage = _currentPage-1;
  }
}

@end
