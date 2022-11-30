
#import "xxzUppotDetailView.h"
#import "xxzErsionUppotController.h"


@interface xxzUppotDetailView()
@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;
@end

@implementation xxzUppotDetailView




- (IBAction)selectAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    xxzLoginSettingView *nlineView = [[xxzLoginSettingView alloc]init];
    nlineView.provinceAddress = self.provinceAddress;
    nlineView.cityAddress = self.cityAddress;
    nlineView.channelId = [NSString stringWithFormat:@"%@",self.startDic[@"id"]];
    nlineView.Block = ^(NSDictionary *startDic, NSDictionary *endDic) {
        self.xiaofeidiqvLbl.text = [NSString stringWithFormat:@"%@-%@",startDic[@"name"],endDic[@"name"]];
        self.xiaofeidiqvLbl.hidden = NO;
        self.cityCode = [NSString stringWithFormat:@"%@",endDic[@"id"]];
    };
    [nlineView show];
}

- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
    
    [self.priceTf addTarget:self action:@selector(changePrice:) forControlEvents:UIControlEventEditingChanged];
    
    __weak typeof(self) weakSelf = self;
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [weakSelf.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzUppotDetailView" owner:nil options:nil] firstObject];
    }
    return self;
}




-(void)changePrice:(UITextField * )tf{
    self.zongshouxufeiLbl.text = [NSString stringWithFormat:@"%.2f元",([self.priceTf.text doubleValue] * [self.startDic[@"costRate"] doubleValue]) + [self.startDic[@"costFee"] doubleValue]];
    self.daozhangjineLbl.text = [NSString stringWithFormat:@"%.2f元",[self.priceTf.text doubleValue] - [self.zongshouxufeiLbl.text doubleValue]];
}


- (IBAction)paizhaoAction:(id)sender {
    if (self.sendCodeBlock) {
        self.sendCodeBlock();
    }
    
}


- (IBAction)sendCodeAction:(id)sender {
    if (self.sendCodeBlock) {
        self.sendCodeBlock();
    }
}


- (IBAction)nextAction:(UIButton *)sender {
   
    if (self.nextblock) {
        self.nextblock();
    }
}


@end
