

#import "xxzOneyFriendsView.h"


static CGFloat const AniDuration = 1.8;

@interface xxzOneyFriendsView ()

@property (nonatomic, weak) UILabel *fullLijitixian;

@property (nonatomic, weak) UILabel *qitajiangli;

@property (nonatomic, assign) BOOL photo;

@property (nonatomic, assign) BOOL forget;

@property (nonatomic, assign) NSInteger lab;

@property (nonatomic, strong) NSTimer *nearestBanner;

@end

@implementation xxzOneyFriendsView

#pragma mark - public method

- (void)showNext:(id)sender {
    if (self.forget) {
        return;
    }
    self.forget = YES;
    [UIView animateWithDuration:AniDuration animations:^{
        if (self.photo == YES) {
            self.fullLijitixian.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.qitajiangli.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }else {
            self.qitajiangli.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.fullLijitixian.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        }
    } completion:^(BOOL finished) {
        if (self.photo == YES) {
            
            self.fullLijitixian.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.photo = NO;
        }else {
            
            self.qitajiangli.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.photo = YES;
        }
        self.forget = NO;
        
        [self setLabelTxt];
    }];
}


- (UILabel *)fullLijitixian {
    if (!_fullLijitixian) {
        UILabel *collectionview = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:collectionview];
        _fullLijitixian = collectionview;
        collectionview.font = [UIFont getUIFontSize:15 IsBold:YES];
        collectionview.textColor = [UIColor blackColor];
        collectionview.textAlignment = NSTextAlignmentLeft;
        collectionview.userInteractionEnabled = YES;
        [collectionview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    }
    return _fullLijitixian;
}


- (void)addTimer {
    if (!self.nearestBanner) {
        self.nearestBanner = [NSTimer scheduledTimerWithTimeInterval:AniDuration target:self selector:@selector(showNext:) userInfo:nil repeats:YES];
    }
}
#pragma mark - life cycle

- (void)showNext {
    [self showNext:nil];
}

#pragma mark - setter

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.photo = YES;
        self.forget = NO;
        self.clipsToBounds = YES;
        self.lab = 0;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - private method


- (void)removeTimer {
    [self.nearestBanner invalidate];
    self.nearestBanner = nil;
}

- (void)setLabelTxt {
    if (self.lab == self.dataSource.count) {
        self.lab = 0;
    }
    if (self.lab % 2 == 0) {
        self.fullLijitixian.text = [self.dataSource objectAtIndex:self.lab];
    }else {
        self.qitajiangli.text = [self.dataSource objectAtIndex:self.lab];
    }
    self.lab ++;
}


- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.block) {
        self.block([tap.view valueForKey:@"text"]);
    }
}

#pragma mark - getter

- (UILabel *)qitajiangli {
    if (!_qitajiangli) {
        UILabel *ani = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        [self addSubview:ani];
        _qitajiangli = ani;
        ani.font = [UIFont getUIFontSize:15 IsBold:YES];
        ani.textColor = [UIColor blackColor];
        ani.textAlignment = NSTextAlignmentLeft;
        ani.userInteractionEnabled = YES;
        [ani addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    }
    return _qitajiangli;
}


- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    if (self.dataSource.count == 0) {
        return;
    }
    if (dataSource.count%2 == 1) {
        
        [dataSource addObjectsFromArray:dataSource];
    }
    
    [self setLabelTxt];
    [self setLabelTxt];
    [self addTimer];
}


@end
