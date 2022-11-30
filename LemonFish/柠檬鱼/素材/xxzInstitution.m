
#import "xxzInstitution.h"

@interface xxzInstitution()

@end

@implementation xxzInstitution


- (void)itemTouched:(QMUIButton *)sender {
    NSInteger alendar = sender.tag - 1000;
    __weak __typeof(self)weakSelf = self;
    [self hideWithAnimated:YES completion:^(BOOL finished) {
        weakSelf.selectedBlock(alendar);
    }];
}


- (UIView *)creatContentView {
    UIView *confirmView = [[UIView alloc] initWithFrame:self.bounds];
    confirmView.backgroundColor = [UIColor qmui_colorWithHexString:@"#444444"];
    confirmView.layer.cornerRadius = 4;
    UIStackView *city = [[UIStackView alloc] initWithFrame:confirmView.bounds];
    city.axis = UILayoutConstraintAxisHorizontal;
    city.alignment = UIStackViewAlignmentFill;
    city.distribution = UIStackViewDistributionFillEqually;
    city.spacing = 0;
    QMUIButton *interval_vsBtn = [self creatItemButtonTitle:@"复制文案" icon:[UIImage imageNamed:@"article_copy"]];
    interval_vsBtn.tag = 1000;
    [interval_vsBtn addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    QMUIButton *goodsBtn = [self creatItemButtonTitle:@"保存图片" icon:[UIImage imageNamed:@"article_save"]];
    goodsBtn.tag = 1001;
    [goodsBtn addTarget:self action:@selector(itemTouched:) forControlEvents:UIControlEventTouchUpInside];
    
    [city addArrangedSubview:interval_vsBtn];
    [city addArrangedSubview:goodsBtn];
    [confirmView addSubview:city];
    
    return confirmView;
}


- (QMUIButton *)creatItemButtonTitle:(NSString *)title icon:(UIImage *)img {
    QMUIButton *jiaoyishijianButton = [QMUIButton buttonWithType:UIButtonTypeCustom];
    [jiaoyishijianButton setTitle:title forState:UIControlStateNormal];
    [jiaoyishijianButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    jiaoyishijianButton.titleLabel.font = UIFontBoldMake(13);
    [jiaoyishijianButton setImage:img forState:UIControlStateNormal];
    jiaoyishijianButton.imagePosition = QMUIButtonImagePositionLeft;
    jiaoyishijianButton.spacingBetweenImageAndTitle = 6;

    return jiaoyishijianButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self creatContentView]];
    }
    return self;
}
@end
