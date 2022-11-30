
#import "xxzToastNewsView.h"
#import "xxzErsionUppotController.h"
#import "xxzTeamView.h"


@interface xxzToastNewsView()
@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;
@end

@implementation xxzToastNewsView




- (IBAction)nextAction:(UIButton *)sender {
   
    if (self.nextblock) {
        self.nextblock();
    }
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
    
    __weak typeof(self) weakSelf = self;
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [weakSelf.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
    
    
}




- (IBAction)selectAction:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    xxzConfirmView *comeView = [[xxzConfirmView alloc]initWithDateStyle:DateStyleShowOtherString CompleteBlock:^(NSDate *Data, NSString *Str, id OtherString) {
        
        if (sender.tag == 10) {
            weakSelf.zhangdanriTf.text = Str;
            self.zhangdanriTf.hidden = NO;

        }
        if (sender.tag == 11) {
            weakSelf.huankuanriTf.text = Str;
            self.huankuanriTf.hidden = NO;
        }
    }];
    NSMutableArray * modity = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 31; i++) {
        [modity addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    comeView.MyearArray = modity;
    comeView.yearLabelColor = [UIColor clearColor];
    [comeView show];
}


- (IBAction)cvn2Action:(id)sender {
    xxzTeamView * jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzTeamView class]) owner:nil options:nil] lastObject];
    __weak typeof(self) weakSelf = self;
    jihuajine.vImv.image = [UIImage imageNamed:@"textShiming"];
    jihuajine.vTitle.text = @"CVN2(信用卡反面)";
    jihuajine.vTip.text = @"如此：CVN2三位数字填写567";
    
    LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                  popStyle:LSTPopStyleSpringFromTop
                                              dismissStyle:LSTDismissStyleSmoothToTop];

    LSTPopViewWK(xplainView);
    [jihuajine.closeBtn bk_whenTapped:^{
        [wk_xplainView dismiss];
    }];
    
    
    
    [jihuajine.btnCopy bk_whenTapped:^{
        [wk_xplainView dismiss];
    }];


    [xplainView pop];
}


- (IBAction)paizhaoAction:(id)sender {
    if (self.upLoadblock) {
        self.upLoadblock();
    }
}


- (IBAction)youxiaoqiAction:(id)sender {
    xxzTeamView * jihuajineP = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzTeamView class]) owner:nil options:nil] lastObject];
    __weak typeof(self) weakSelf = self;

    
    LSTPopView *xplainViewE = [LSTPopView initWithCustomView:jihuajineP
                                                  popStyle:LSTPopStyleSpringFromTop
                                              dismissStyle:LSTDismissStyleSmoothToTop];
    
    jihuajineP.vImv.image = [UIImage imageNamed:@"stringRefreshOther"];
    jihuajineP.vTitle.text = @"有效期(信用卡正面)";
    jihuajineP.vTip.text = @"如此：有效期请填写0621";
    LSTPopViewWK(xplainViewE);
    [jihuajineP.closeBtn bk_whenTapped:^{
        [wk_xplainViewE dismiss];
    }];
    
    
    
    [jihuajineP.btnCopy bk_whenTapped:^{
        [wk_xplainViewE dismiss];
    }];


    [xplainViewE pop];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzToastNewsView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
