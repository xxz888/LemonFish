
#import "xxzFriendsTouchView.h"
#import "xxzSizeUppot.h"
#import "xxzUnicodeCode.h"

#define UNIT_WIDTH  40 * SCREEN_RAT

static const NSInteger kRow         = 1 + 6;
static const NSInteger kCol         = 7;
static const NSInteger kTotalNum    = (kRow - 1) * kCol;
static const NSInteger kBtnStartTag = 100;

@interface xxzFriendsTouchView()
@property (nonatomic, strong) UIView         *contentBgView,*dateBgView;
@property (nonatomic, strong) UILabel        *separator;
@property (nonatomic, strong) UIButton       *tabbar;
@property (nonatomic, assign) int32_t        year,month;
@property (nonatomic, strong) NSDate         *today,*firstDay; 
@property (nonatomic, strong) NSMutableArray *currentMonthDaysArray,*selectArray;
@property (nonatomic, assign) CGRect         shuakaBout;
@end

@implementation xxzFriendsTouchView
- (NSDate *)today {
    if (!_today) {
        NSDate *reate = [NSDate date];

        
        NSDateFormatter* plan = [[NSDateFormatter alloc] init];
        [plan setDateFormat:@"yyyy-MM-dd"];
        _today = [plan dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(reate.year),@(reate.month),@(reate.day)]];
    }
    return _today;
}

- (NSDate *)firstDay {
    NSDateFormatter* planT = [[NSDateFormatter alloc] init];
    [planT setDateFormat:@"yyyy-MM-dd"];
    NSDate *qiandao =[planT dateFromString:[NSString stringWithFormat:@"%@-%@-%@",@(self.year),@(self.month),@(1)]];
    return qiandao;
}

- (id)initWithFrame:(CGRect)frame minDay:(NSInteger)minDay isSingle:(BOOL)isSingle zhangdanri:(NSString *)zhangdanri huankuanri:(NSString *)huankuanri{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.dateBgView = ({
            UIView *confirmView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            confirmView.alpha           = 0.3;
            confirmView.backgroundColor = [UIColor blackColor];
            [confirmView bk_whenTapped:^{
                [self hide];
            }];
            [self addSubview:confirmView];
            
            confirmView;
        });

        self.contentBgView = ({
            
            UIView        *confirmView         = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-UNIT_WIDTH*kCol)/2.0, 150, UNIT_WIDTH*kCol, 60+UNIT_WIDTH*kRow+50)];
            confirmView.layer.cornerRadius     = 2.0;
            confirmView.layer.masksToBounds    = YES;
            confirmView.userInteractionEnabled = YES;
            confirmView.backgroundColor        = [UIColor whiteColor];
            [self addSubview:confirmView];
            
            ({
                UIImageView *canshuImage = [UIImageView new];
                canshuImage.image        = [UIImage imageNamed:@"titleDingdanhao"];
                canshuImage.image        = [UIImage imageWithCGImage:canshuImage.image.CGImage scale:1 orientation:UIImageOrientationDown];
                [confirmView addSubview:canshuImage];
                canshuImage.frame        = CGRectMake(CGRectGetWidth(confirmView.frame)/3.0 - 18 - 10, (60-13)/2.0, 8, 13);
            });
            
            ({
                UIImageView *huankuanbishuImage = [UIImageView new];
                huankuanbishuImage.image        = [UIImage imageNamed:@"titleDingdanhao"];
                [confirmView addSubview:huankuanbishuImage];
                huankuanbishuImage.frame        = CGRectMake(CGRectGetWidth(confirmView.frame)*2/3.0 + 18, (60-13)/2.0, 8, 13);
            });
            
            confirmView;
        });

        self.separator = ({
            UILabel *xiaofeiLab               = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_contentBgView.frame), 60)];
            xiaofeiLab.backgroundColor        = [UIColor clearColor];
            xiaofeiLab.textColor              = [UIColor blackColor];
            xiaofeiLab.font                   = [UIFont systemFontOfSize:15];
            xiaofeiLab.textAlignment          = NSTextAlignmentCenter;
            xiaofeiLab.userInteractionEnabled = YES;
            xiaofeiLab.numberOfLines = 0;
            [_contentBgView addSubview:xiaofeiLab];
            
            ({
                UITapGestureRecognizer *ogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMonthTap:)];
                [xiaofeiLab addGestureRecognizer:ogin];
                
                UIView *data         = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(xiaofeiLab.frame) - 0.5, CGRectGetWidth(_contentBgView.frame), 0.5)];
                data.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
                [_contentBgView addSubview:data];
            });
            
            xiaofeiLab;
        });
        
        self.dateBgView = ({
            UIView *confirmView                = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_separator.frame), CGRectGetWidth(_contentBgView.frame), UNIT_WIDTH*kRow)];
            confirmView.userInteractionEnabled = YES;
            confirmView.backgroundColor        = [UIColor hexColorWithString:@"ededed"];
            [_contentBgView addSubview:confirmView];
            
            ({
                UIView *off         = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(confirmView.frame), CGRectGetWidth(_contentBgView.frame), 0.5)];
                off.backgroundColor = [UIColor hexColorWithString:@"dddddd"];
                [_contentBgView addSubview:off];
            });
            
            ({
                UITapGestureRecognizer *camera = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
                [confirmView addGestureRecognizer:camera];
            });
            confirmView;
        });

        self.tabbar = ({
            UIButton *cacheBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cacheBtn setFrame:CGRectMake((CGRectGetWidth(_contentBgView.frame) - 150) / 2.0, CGRectGetHeight(_contentBgView.frame) - 40, 150, 30)];
            [cacheBtn setTitleColor:[UIColor hexColorWithString:@"#333333"] forState:UIControlStateNormal];
            [cacheBtn setBackgroundColor:[UIColor hexColorWithString:@"#FED403"]];
            cacheBtn.layer.masksToBounds = YES;
            cacheBtn.layer.cornerRadius = 5;
            
            
            [cacheBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [cacheBtn setBackgroundImage:[[UIImage imageNamed:@"lblSectionOast"] stretchableImageWithLeftCapWidth:15 topCapHeight:10] forState:UIControlStateDisabled];
            [cacheBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [cacheBtn setTitle:@"确定" forState:UIControlStateNormal];
            cacheBtn.layer.masksToBounds = YES;
            [_contentBgView addSubview:cacheBtn];
            
            cacheBtn;
        });
        self.contentBgView.layer.masksToBounds = YES;
        self.contentBgView.layer.cornerRadius = 10;
        self.minDay = minDay;
        self.isSingle = isSingle;
        self.zhangdanri = zhangdanri;
        self.huankuanri = huankuanri;
        [self initData];
    }
    return self;
}

- (void)initData {
    _selectArray        = @[].mutableCopy;

    
    NSDate *reate8 = [NSDate date];
    self.month          = (int32_t)reate8.month;
    self.year           = (int32_t)reate8.year;
    [self refreshDateTitle];

    _currentMonthDaysArray = [NSMutableArray array];
    for (int i = 0; i < kTotalNum; i++) {
        [_currentMonthDaysArray addObject:@(0)];
    }

    [self showDateView];
}

- (void)switchMonthTap:(UITapGestureRecognizer *)tap {
   CGPoint search =  [tap locationInView:_separator];
    CGFloat erson = CGRectGetWidth(_separator.frame);
    if (search.x <= erson/3.0) {
        [self leftSwitch];
    }else if(search.x >= erson/3.0*2.0){
        [self rightSwitch];
    }
}

- (void)leftSwitch{
    if (self.month > 1) {
        self.month -= 1;
    }else {
        self.month = 12;
        self.year -= 1;
    }
    
    [self refreshDateTitle];
}

- (void)rightSwitch {
    if (self.month < 12) {
        self.month += 1;
    }else {
        self.month = 1;
        self.year += 1;
    }
    
    [self refreshDateTitle];
}


- (void)refreshDateTitle {
    NSString * magnification = @"";
    if (self.isSingle) {
        magnification = @"请选择1天";
    }else{
        magnification = [NSString stringWithFormat:@"至少选择%ld天",self.minDay];
    }
    
    
    
    _separator.text = [NSString stringWithFormat:@"%@年,%@月 \n（%@）",@(self.year),@(self.month),magnification];
    
    [self showDateView];
}

- (void)drawTitleView {
    CGRect origin2 = CGRectMake(0.0,0.0, UNIT_WIDTH, UNIT_WIDTH);
    NSArray *indicator = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    for(int i = 0 ;i < 7; i++)
    {
        UILabel *xiaofeiLabR        = [[UILabel alloc] initWithFrame:origin2];
        xiaofeiLabR.textColor       = [UIColor hexColorWithString:@"848484"];
        xiaofeiLabR.textAlignment   = NSTextAlignmentCenter;
        xiaofeiLabR.font            = [UIFont systemFontOfSize:13];
        xiaofeiLabR.backgroundColor = [UIColor clearColor];
        xiaofeiLabR.text            = [indicator objectAtIndex:i];
        [_dateBgView addSubview:xiaofeiLabR];
        
        origin2.origin.x   += origin2.size.width;
    }
}

- (CGFloat)calculateStartIndex:(NSDate *)firstDay {
    CGFloat huankuanblock = [NSDate acquireWeekDayFromDate:firstDay];
    
    if (huankuanblock == 1) {
        
        huankuanblock = 6;
    }else {
        
        huankuanblock -= 2;
    }
    return huankuanblock;
}

- (void)createBtn:(NSInteger)i frame:(CGRect)baseRect {
    UIButton *cacheBtnf              = [UIButton buttonWithType:UIButtonTypeCustom];
    cacheBtnf.tag                    = kBtnStartTag + i;
    [cacheBtnf setFrame:baseRect];
    cacheBtnf.userInteractionEnabled = NO;
    cacheBtnf.backgroundColor        = [UIColor clearColor];
    [cacheBtnf.titleLabel setFont:[UIFont systemFontOfSize:12]];
    
    CGFloat huankuanblockg = [self calculateStartIndex:self.firstDay];
    NSDate * borderA = [self.firstDay dateByAddingTimeInterval: (i - huankuanblockg)*24*60*60];
    _currentMonthDaysArray[i] = @([borderA timeIntervalSince1970]);
    NSString *cell = INTTOSTR(borderA.day);
    if ([borderA isToday]) {
        cell = @"今天";
        cacheBtnf.layer.borderColor = [UIColor hexColorWithString:@"f49e79"].CGColor;
        cacheBtnf.layer.borderWidth = 0.5;
        cacheBtnf.layer.cornerRadius = UNIT_WIDTH/2;
    }
    else if(borderA.day == 1) {
        
        UILabel *selectLab        = [[UILabel alloc] initWithFrame:CGRectMake(baseRect.origin.x, baseRect.origin.y + baseRect.size.height - 7, baseRect.size.width, 7)];
        selectLab.backgroundColor = [UIColor clearColor];
        selectLab.textAlignment   = NSTextAlignmentCenter;
        selectLab.font            = [UIFont systemFontOfSize:7];
        selectLab.textColor       = [UIColor hexColorWithString:@"c0c0c0"];
        selectLab.text            = [NSString stringWithFormat:@"%@月",@(borderA.month)];
        [_dateBgView addSubview:selectLab];
    } else if(borderA.day == [self.zhangdanri integerValue]) {
        
        cell = @"账单日";
        cacheBtnf.layer.cornerRadius = UNIT_WIDTH/2;
    }else if(borderA.day == [self.huankuanri integerValue]) {
        
        cell = @"还款日";

        cacheBtnf.layer.cornerRadius = UNIT_WIDTH/2;
    }
    
    [cacheBtnf setTitle:cell forState:UIControlStateNormal];
    if ([self.today compare:borderA] < 0) {
        
        [cacheBtnf setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
    }else {
        [cacheBtnf setTitleColor:[UIColor hexColorWithString:@"bfbfbf"] forState:UIControlStateNormal];
    }
    [cacheBtnf setBackgroundColor:[UIColor clearColor]];
    
    
     if(borderA.day == [self.zhangdanri integerValue]) {
       
       cell = @"账单日";

       [cacheBtnf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [cacheBtnf setBackgroundColor:[UIColor hexColorWithString:@"00A4FF"]];
   }else if(borderA.day == [self.huankuanri integerValue]) {
       
       cell = @"还款日";
       [cacheBtnf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       [cacheBtnf setBackgroundColor:[UIColor hexColorWithString:@"FF9300"]];
   }
    [_dateBgView addSubview:cacheBtnf];
}

- (void)showDateView {
    
    [_dateBgView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    
    [self drawTitleView];

    CGFloat huankuanblockT       = [self calculateStartIndex:self.firstDay];
    CGRect origin2J             = CGRectMake(UNIT_WIDTH * huankuanblockT,UNIT_WIDTH, UNIT_WIDTH, UNIT_WIDTH);
    
    self.shuakaBout = ({
        CGRect corner = CGRectZero;
        corner.origin      = origin2J.origin;
        corner.origin.x    = 0;
        corner.size.width  = kCol * UNIT_WIDTH;
        corner.size.height = kRow * UNIT_WIDTH;
        
        corner;
    });
    
    for(int i = huankuanblockT; i < kTotalNum;i++) {
        
        if (i % kCol == 0 && i != 0) {
            origin2J.origin.y += (origin2J.size.height);
            origin2J.origin.x = 0.0;
        }
        
        [self createBtn:i frame:origin2J];

        origin2J.origin.x += (origin2J.size.width);
    }
    
    
    [self refreshDateView];
}

- (void)setDefaultDays:(NSArray *)defaultDays {
    _defaultDays = defaultDays;
    
    if (defaultDays) {
        _selectArray = [defaultDays mutableCopy];
    }else {
        _selectArray = @[].mutableCopy;
    }
    
    [self refreshDateView];
}

- (void)refreshDateView {
    for(int i = 0; i < kTotalNum; i++) {
        UIButton *cacheBtnk = (UIButton *)[_dateBgView viewWithTag:kBtnStartTag + i];
        NSNumber *interval = [_currentMonthDaysArray objectAtIndex:i];

        if (i < [_currentMonthDaysArray count] && cacheBtnk) {
            if ([_selectArray containsObject:interval]) {
                [cacheBtnk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cacheBtnk setBackgroundColor:[UIColor hexColorWithString:@"FF9426"]];
                cacheBtnk.layer.cornerRadius = UNIT_WIDTH/2;;
                
            }
        }
    }
}

-(void)tap:(UITapGestureRecognizer *)gesture{
    CGPoint tabbar = [gesture locationInView:_dateBgView];
    if (CGRectContainsPoint(_shuakaBout, tabbar)) {
        CGFloat nvite       = (CGRectGetWidth(_dateBgView.frame)) / kCol;
        CGFloat tint       = (CGRectGetHeight(_dateBgView.frame)) / kRow;
        int xiaofeidiqv         = (int)((tabbar.y - _shuakaBout.origin.y) / tint);
        int chuxuka         = (int)((tabbar.x) / nvite);

        NSInteger container = xiaofeidiqv * kCol + chuxuka;
        [self clickForIndex:container];
    }
}

- (void)clickForIndex:(NSInteger)index
{
    UIButton *cacheBtnZ = (UIButton *)[_dateBgView viewWithTag:kBtnStartTag + index];
    
    

    if (self.isSingle && [_selectArray count] != 0) {
        for (NSInteger i = 0; i < [_selectArray count]; i++) {
            for (NSInteger k = 0; k < [_currentMonthDaysArray count]; k++) {
                if ([_selectArray[i] integerValue] == [_currentMonthDaysArray[k] integerValue]) {
                    UIButton *cacheBtnZ = (UIButton *)[_dateBgView viewWithTag:kBtnStartTag+k];
                    [cacheBtnZ setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
                    [cacheBtnZ setBackgroundColor:[UIColor clearColor]];
                }

            }
        }
   
        [_selectArray removeAllObjects];
    }

    if (index < [_currentMonthDaysArray count]) {
        NSNumber *interval = [_currentMonthDaysArray objectAtIndex:index];
        NSDate *border = [NSDate dateWithTimeIntervalSince1970:interval.doubleValue];
        if ([self.today  compare:border] < 0) {
            
        }else {
            return;
        }
        
        if ([_selectArray containsObject:interval]) {
            
            [_selectArray removeObject:interval];
            [cacheBtnZ setTitleColor:[UIColor hexColorWithString:@"2b2b2b"] forState:UIControlStateNormal];
            [cacheBtnZ setBackgroundColor:[UIColor clearColor]];
        }
        else {
            
            [_selectArray addObject:interval];
            
            [cacheBtnZ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [cacheBtnZ setBackgroundColor:[UIColor hexColorWithString:@"FF9426"]];
            cacheBtnZ.layer.cornerRadius = UNIT_WIDTH/2;
            
            if (border.month > self.month) {
                [self rightSwitch];
            }
        }
    }
}

- (void)doneBtnClick:(id)sender {
    if (_complete) {
        if (self.minDay <= _selectArray.count) {
            _complete([_selectArray mutableCopy]);
            [self hide];
        }else{
            [xxzBase showBottomWithText:@"您选择的时间小于计划最小天数" duration:3.0];
        }
    }
    
}





- (void)show {
    self.hidden = NO;
}

- (void)hide {
    self.hidden = YES;
}
@end
