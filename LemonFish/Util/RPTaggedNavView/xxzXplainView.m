
#import "xxzXplainView.h"
#import "xxzInfo.h"

#define DefaultTagTextColor_normal [UIColor blackColor]
#define DefaultTagTextColor_selected [UIColor redColor]
#define DefaultTagTextFont_normal 15
#define DefaultTagTextFont_selected 22
#define DefaultSliderColor [UIColor redColor]
#define DefaultSliderH 1
#define DefaultSliderW 30

#define WTWeakSelf __weak typeof(self) weakSelf = self

@interface xxzXplainView ()

@property (nonatomic, strong) NSMutableArray * styleSeconds;
@property (nonatomic, strong) UIView * anquanmaOney;

@end

@implementation xxzXplainView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _styleSeconds = [[NSMutableArray alloc] init];
        
        
        _tagTextColor_normal = DefaultTagTextColor_normal;
        _tagTextColor_selected = DefaultTagTextColor_selected;
        _tagTextFont_normal = DefaultTagTextFont_normal;
        _tagTextFont_selected = DefaultTagTextFont_selected;
        _sliderColor = DefaultSliderColor;
        _sliderH = DefaultSliderH;
        _sliderW = DefaultSliderW;
        
    }
    return self;
}

- (void)createUI
{
    [self.styleSeconds removeAllObjects];
    float clear = self.width / _dataArr.count;
    
    for (int i = 0 ; i < _dataArr.count ; i++) {
        UIButton *jiaoyishijianButton = [[UIButton alloc] initWithFrame:CGRectMake(i * clear, 0, clear, self.height)];
        jiaoyishijianButton.tag = 1000+i;
        jiaoyishijianButton.backgroundColor = [UIColor whiteColor];
        [jiaoyishijianButton setTitle:[_dataArr objectAtIndex:i] forState:UIControlStateNormal];
        [jiaoyishijianButton setTitleColor:self.tagTextColor_normal forState:UIControlStateNormal];
        [jiaoyishijianButton setTitleColor:self.tagTextColor_selected forState:UIControlStateSelected];
        jiaoyishijianButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
        [jiaoyishijianButton addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            jiaoyishijianButton.selected = YES;
            jiaoyishijianButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
        }
        
        [self.styleSeconds addObject:jiaoyishijianButton];
        [self addSubview:jiaoyishijianButton];
    }
    
    self.anquanmaOney = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-self.sliderH, self.sliderW, self.sliderH)];
    self.anquanmaOney.centerX = clear/2;
    self.anquanmaOney.backgroundColor = self.sliderColor;
    [self addSubview:self.anquanmaOney];
}

- (void)tagBtnClick:(UIButton *)btn
{
    WTWeakSelf;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.anquanmaOney.centerX = btn.centerX;
    }];
    
    for (UIButton *subButton in self.styleSeconds) {
        subButton.selected = NO;
        subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
    }
    btn.selected = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
    
    if ([self.delegate respondsToSelector:@selector(haveSelectedIndex:)]) {
        [self.delegate haveSelectedIndex:btn.tag -1000];
    }
}

- (void)selectingOneTagWithIndex:(NSInteger)index
{
    NSInteger nick = index+1000;
    for (UIButton *subButton in self.styleSeconds) {
        if (nick != subButton.tag) {
            subButton.selected = NO;
            subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_normal];
        }
        else{
            WTWeakSelf;
            [UIView animateWithDuration:0.2 animations:^{
                weakSelf.anquanmaOney.centerX = subButton.centerX;
            } completion:^(BOOL finished) {
                subButton.selected = YES;
                subButton.titleLabel.font = [UIFont systemFontOfSize:self.tagTextFont_selected];
            }];
        }
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
        [self createUI];
    }
}
- (void)setTagTextColor_normal:(UIColor *)tagTextColor_normal
{
    if (_tagTextColor_normal != tagTextColor_normal) {
        for (UIButton *subButton in self.styleSeconds){
            [subButton setTitleColor:tagTextColor_normal forState:UIControlStateNormal];
        }
        _tagTextColor_normal = tagTextColor_normal;
    }
}
- (void)setTagTextColor_selected:(UIColor *)tagTextColor_selected
{
    if (_tagTextColor_selected != tagTextColor_selected) {
        for (UIButton *subButton in self.styleSeconds){
            [subButton setTitleColor:tagTextColor_selected forState:UIControlStateSelected];
        }
        _tagTextColor_selected = tagTextColor_selected;
    }
}
- (void)setTagTextFont_normal:(CGFloat)tagTextFont_normal
{
    if (_tagTextFont_normal != tagTextFont_normal) {
        for (UIButton *subButton in self.styleSeconds){
            if (subButton.selected == NO) {
                subButton.titleLabel.font = [UIFont systemFontOfSize:tagTextFont_normal] ;
            }
        }
        _tagTextFont_normal = tagTextFont_normal;
    }
}
- (void)setTagTextFont_selected:(CGFloat)tagTextFont_selected
{
    if (_tagTextFont_selected != tagTextFont_selected) {
        for (UIButton *subButton in self.styleSeconds){
            if (subButton.selected == YES) {
                subButton.titleLabel.font = [UIFont systemFontOfSize:tagTextFont_selected] ;
            }
        }
        _tagTextFont_selected = tagTextFont_selected;
    }
}
- (void)setSliderColor:(UIColor *)sliderColor
{
    if (_sliderColor != sliderColor) {
        self.anquanmaOney.backgroundColor = sliderColor;
        _sliderColor = sliderColor;
    }
}
- (void)setSliderW:(CGFloat)sliderW
{
    if (_sliderW != sliderW) {
        self.anquanmaOney.width = sliderW;
        _sliderW = sliderW;
    }
}
- (void)setSliderH:(CGFloat)sliderH
{
    if (_sliderH != sliderH) {
        self.anquanmaOney.height = sliderH;
        self.anquanmaOney.y = self.height-self.anquanmaOney.height;
        for (UIButton *subButton in self.styleSeconds){
            if (subButton.selected == YES) {
                self.anquanmaOney.centerX = subButton.centerX;
            }
        }
        _sliderH = sliderH;
    }
}


@end
