
#import "xxzLoginSettingView.h"
#define ANIMATION_DURATION   0.3f      
@implementation UIView (Frame)

- (void)setPosition:(CGPoint)point atAnchorPoint:(CGPoint)anchorPoint
{
    CGFloat liebianrenshu = point.x - anchorPoint.x * self.frame.size.width;
    CGFloat rgb = point.y - anchorPoint.y * self.frame.size.height;
    CGRect frame = self.frame;
    frame.origin = CGPointMake(liebianrenshu, rgb);
    self.frame = frame;
}

@end

@interface xxzLoginSettingView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    UIButton *cancelButton;
    UIButton *sureButton;

    UIPickerView *LeftPicker;
    UIPickerView *RightPicker;
    
    NSDictionary *LeftDic;
    NSDictionary *RightDic;
    
}

@property (nonatomic, strong) UIWindow *window;                     
@property (nonatomic, strong) UIView *titleDismiss;                    
@property (nonatomic, strong) UIView *acc;                   

@end

@implementation xxzLoginSettingView



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        [self addSubview:self.titleDismiss];

        [self.acc setPosition:CGPointMake(0, DEVICE_HEIGHT) atAnchorPoint:CGPointZero];
        [self addSubview:self.acc];

        UITapGestureRecognizer *hange = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        hange.numberOfTapsRequired = 1;
        hange.numberOfTouchesRequired = 1;
        [self.titleDismiss addGestureRecognizer:hange];
        LeftDic = [NSDictionary dictionary];
        RightDic = [NSDictionary dictionary];
        [self LoadUI];
        
        
        
        
        [self getAddProvince];
        
    }
    return self;
}

- (void)LoadUI{

    
    cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.acc addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.width.offset(100);
        make.height.offset(46);
    }];

    sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.acc addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.right.offset(0);
        make.width.offset(100);
        make.height.offset(46);
    }];

    UIView *shouxufei = [UIView new];
    shouxufei.backgroundColor = [UIColor colorWithHexString:@"#999999"];
    [self.acc addSubview:shouxufei];
    [shouxufei mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(DEVICE_WIDTH);
        make.height.offset(0.5);
        make.centerX.equalTo(self);
        make.top.equalTo(cancelButton.mas_bottom);
    }];

    
    
    LeftPicker = [[UIPickerView alloc]init];
    LeftPicker.delegate = self;
    LeftPicker.dataSource = self;
    [self.acc addSubview:LeftPicker];
    [LeftPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shouxufei.mas_bottom).offset(10);
        make.left.offset(10);
        make.width.offset((DEVICE_WIDTH - 30)/2);
        make.bottom.offset(-10);
    }];

    RightPicker = [[UIPickerView alloc]init];
    RightPicker.delegate = self;
    RightPicker.dataSource = self;
    [self.acc addSubview:RightPicker];
    [RightPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shouxufei.mas_bottom).offset(10);
        make.right.offset(-10);
        make.width.offset((DEVICE_WIDTH - 30)/2);
        make.bottom.offset(-10);
    }];

}

- (NSArray *)LeftArray{
    if (!_LeftArray) {
        _LeftArray = [NSArray array];
    }
    return _LeftArray;
}
- (NSArray *)RightArray{
    if (!_RightArray) {
        _RightArray = [NSArray array];
    }
    return _RightArray;
}

- (void)getAddProvince{
    @weakify(self);
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    
    if (![NSString isBlankString:self.channelId]) {
        [pass setObject:self.channelId forKey:@"channelId"];
    }
    
    [[UIViewController currentViewController] NetWorkingPostWithAddressURL:[UIViewController currentViewController] hiddenHUD:NO url:@"/api/payment/province/list" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            weak_self.LeftArray = responseObject[@"data"];
            [self->LeftPicker reloadAllComponents];
            if (weak_self.LeftArray.count > 0) {
                if (self.provinceAddress.length > 0) {
                    for (int i = 0 ; i < weak_self.LeftArray.count ; i++) {
                        NSDictionary *date = weak_self.LeftArray[i];
                        if ([date[@"name"] isEqualToString:self.provinceAddress]) {
                            [self getAddCity:date[@"id"]];
                            self->LeftDic = date;
                            [self->LeftPicker selectRow:i inComponent:0 animated:YES];
                        }
                    }
                }else{
                    [self getAddCity:weak_self.LeftArray[0][@"id"]];
                    self->LeftDic =weak_self.LeftArray[0];
                    
                }
            }
        }else{
            [self hide];
            [xxzBase showCenterWithText:responseObject[@"message"]];
        }
    } failure:^(NSString * _Nonnull error) {
        [self hide];
    }];
    
}

- (void)getAddCity:(NSString *)parent{
    @weakify(self);
    NSMutableDictionary *passs = [NSMutableDictionary dictionary];
    [passs setValue:parent forKey:@"parent"];

    [[UIViewController currentViewController] NetWorkingPostWithAddressURL:[UIViewController currentViewController] hiddenHUD:YES url:@"/api/payment/city/list" Params:passs success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            weak_self.RightArray = responseObject[@"data"];
            [self->RightPicker reloadAllComponents];
            if (weak_self.RightArray.count > 0) {
                if (self.cityAddress.length > 0) {
                    BOOL tixianjine = NO;
                    for (int i = 0 ; i < weak_self.RightArray.count ; i++) {
                        NSDictionary *datex = weak_self.RightArray[i];
                        if ([datex[@"name"] isEqualToString:self.cityAddress]) {
                            self->RightDic = datex;
                            [self->RightPicker selectRow:i inComponent:0 animated:YES];
                            tixianjine = YES;
                        }
                    }
                    if(!tixianjine){
                        self->RightDic =weak_self.RightArray[0];
                    }
                }else{
                    self->RightDic =weak_self.RightArray[0];
                }
                
            }else{
                self->RightDic = nil;
            }
            
        }else{
            [xxzBase showCenterWithText:responseObject[@"message"]];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];

}





#pragma mark - pickerView的delegate方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if (pickerView == LeftPicker) {
        LeftDic = _LeftArray[row];
        [self getAddCity:self.LeftArray[row][@"id"]];
        
    }else{
        RightDic = _RightArray[row];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (pickerView == LeftPicker) {
        return _LeftArray.count;
    }else{
        return _RightArray.count;
    }

}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{

    return 40;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *downLabel = [[UILabel alloc]init];
    downLabel.textAlignment = NSTextAlignmentCenter;
    downLabel.backgroundColor = [UIColor whiteColor];
    downLabel.frame = CGRectMake(0, 0, 40,self.frame.size.width);
    downLabel.font = [UIFont systemFontOfSize:17];
    downLabel.textColor = [UIColor blackColor];
    [downLabel sizeToFit];
    if (pickerView == LeftPicker) {
        downLabel.text = _LeftArray[row][@"name"];
    }else{
        downLabel.text = _RightArray[row][@"name"];
    }


    return downLabel;
}

- (void)sureAction{
    if (self.Block) {
        [self hide];
        self.Block(LeftDic, RightDic);
    }
}

- (void)show {
    [self.window addSubview:self];
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.titleDismiss.alpha = 0.2f;
        [self.acc setPosition:CGPointMake(0, DEVICE_HEIGHT - KBottomHeight) atAnchorPoint:CGPointMake(0, 1)];
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.titleDismiss.alpha = 0.0f;
        [self.acc setPosition:CGPointMake(0, DEVICE_HEIGHT) atAnchorPoint:CGPointMake(0, 0)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (UIWindow *)window {
    if (!_window) {
        _window = [UIApplication sharedApplication].keyWindow;
    }
    return _window;
}

- (UIView *)titleDismiss {
    if (!_titleDismiss) {
        _titleDismiss = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _titleDismiss.clipsToBounds = YES;
        _titleDismiss.alpha = 0.0f;
        _titleDismiss.backgroundColor = [UIColor blackColor];
    }
    return _titleDismiss;
}

- (UIView *)acc {
    if (!_acc) {
        _acc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 300)];
        _acc.backgroundColor = [UIColor whiteColor];
        _acc.clipsToBounds = YES;
    }
    return _acc;
}

@end

