
#import "xxzHuxukaView.h"

@interface xxzHuxukaView()

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray<UIButton *> *colorBackground;

@property (nonatomic, weak) UIView *ziyongfanxianSearch;

@end

@implementation xxzHuxukaView


- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.ziyongfanxianSearch.backgroundColor = indicatorColor;
}


- (void)scrollRectToVisibleCenterAnimated:(BOOL)animated {
    UIButton *window_0Btn = self.colorBackground[self.selectedIndex];
    CGRect all = CGRectMake(window_0Btn.center.x - self.scrollView.frame.size.width / 2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:all animated:animated];
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupData];
    }
    return self;
}


- (void)setItemMinMargin:(CGFloat)itemMinMargin {
    _itemMinMargin = itemMinMargin;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *clearView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        clearView.scrollsToTop = NO;
        clearView.showsHorizontalScrollIndicator = NO;
        clearView.showsVerticalScrollIndicator = NO;
        [self addSubview:clearView];
        _scrollView = clearView;
    }
    return _scrollView;
}


- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    for (UIButton *btn in self.colorBackground) {
        [btn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    }
}

#pragma mark - public


- (void)setIndicatorHeight:(CGFloat)indicatorHeight {
    _indicatorHeight = indicatorHeight;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - getter


- (void)btnClick:(UIButton *)btn {
    NSInteger tuandui = btn.tag - 888;
    if (tuandui == self.selectedIndex) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentTitleView:selectedIndex:lastSelectedIndex:)]) {
        [self.delegate segmentTitleView:self selectedIndex:tuandui lastSelectedIndex:self.selectedIndex];
    }
    self.selectedIndex = tuandui;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupData];
}


- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex == selectedIndex
        || selectedIndex < 0
        || selectedIndex > self.colorBackground.count - 1
        || self.colorBackground.count <= 0) {
        return;
    }
    UIButton *cacheBtn = [self.scrollView viewWithTag:_selectedIndex + 888];
    cacheBtn.selected = NO;
    _selectedIndex = selectedIndex;
    UIButton *window_0BtnJ = [self.scrollView viewWithTag:_selectedIndex + 888];
    window_0BtnJ.selected = YES;
    [self setSelectedIndicatorFrame:YES];
}


#pragma mark - setter


- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    for (UIButton *btn in self.colorBackground) {
        btn.titleLabel.font = titleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



- (void)setupData {
    self.titleNormalColor = [UIColor blackColor];
    self.titleSelectedColor = [UIColor redColor];
    self.selectedIndex = 0;
    self.titleFont = [UIFont systemFontOfSize:14.f];
    self.indicatorColor = [UIColor redColor];
    self.indicatorHeight = 2.f;
    self.indicatorExtraW = 5.f;
    self.indicatorBottomMargin = 0;
    self.itemMinMargin = 25.f;
}


- (void)setSelectedIndicatorFrame:(BOOL)animated {
    UIButton *window_0Btn_ = self.colorBackground[self.selectedIndex];
    [UIView animateWithDuration:(animated? 0.02 : 0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.ziyongfanxianSearch.frame = CGRectMake(window_0Btn_.frame.origin.x - self.indicatorExtraW, self.scrollView.frame.size.height - self.indicatorHeight - self.indicatorBottomMargin, window_0Btn_.frame.size.width + 2 * self.indicatorExtraW, self.indicatorHeight);
    } completion:^(BOOL finished) {
        [self scrollRectToVisibleCenterAnimated:animated];
    }];
}


- (void)setSegmentTitles:(NSArray<NSString *> *)segmentTitles
{
    _segmentTitles = [segmentTitles copy];
    [self.colorBackground makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.colorBackground = nil;
    for (NSString *title in segmentTitles) {
        UIButton *cacheBtnt = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.selectedIndex == self.colorBackground.count) {
            cacheBtnt.selected = YES;
        }
        cacheBtnt.tag = 888 + self.colorBackground.count;
        [cacheBtnt setTitle:title forState:UIControlStateNormal];
        [cacheBtnt setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [cacheBtnt setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [cacheBtnt addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        cacheBtnt.titleLabel.font = self.titleFont;
        [self.scrollView addSubview:cacheBtnt];
        [self.colorBackground addObject:cacheBtnt];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)setIndicatorBottomMargin:(CGFloat)indicatorBottomMargin {
    _indicatorBottomMargin = indicatorBottomMargin;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)reloadData {
    
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(segmentTitlesOfSegmentTitleView:)]) {
        NSArray *info = [self.dataSource segmentTitlesOfSegmentTitleView:self];
        self.segmentTitles = info;
    }
}


- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    for (UIButton *btn in self.colorBackground) {
        [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }
}


- (UIView *)ziyongfanxianSearch {
    if (!_ziyongfanxianSearch) {
        UIView *bankView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.scrollView addSubview:bankView];
        _ziyongfanxianSearch = bankView;
    }
    return _ziyongfanxianSearch;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    if (self.colorBackground.count == 0) {
        return;
    }
    CGFloat one = 0;
    for (UIButton *btn in self.colorBackground) {
        [btn sizeToFit];
        one += btn.frame.size.width;
    }
    
    CGFloat manual = (self.scrollView.frame.size.width - one) / (self.colorBackground.count + 1);
    if (manual < self.itemMinMargin) {
        manual = self.itemMinMargin;
    }
    
    CGFloat fanmian = manual;
    for (UIButton *btn in self.colorBackground) {
        [btn sizeToFit];
        btn.frame = CGRectMake(fanmian, 0, btn.frame.size.width, self.scrollView.frame.size.height);
        fanmian += btn.frame.size.width + manual;
    }
    self.scrollView.contentSize = CGSizeMake(fanmian, self.scrollView.frame.size.height);
    [self setSelectedIndicatorFrame:NO];
}


- (void)setIndicatorExtraW:(CGFloat)indicatorExtraW {
    _indicatorExtraW = indicatorExtraW;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


#pragma mark - EventResponse


- (NSMutableArray<UIButton *> *)colorBackground {
    if (!_colorBackground) {
        _colorBackground = [[NSMutableArray alloc] init];
    }
    return _colorBackground;
}

@end
