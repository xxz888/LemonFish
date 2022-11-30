
#import "xxzSettingOginView.h"
#import "xxzErsionUppotController.h"


@interface xxzSettingOginView()
@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;
@end

@implementation xxzSettingOginView




- (IBAction)selectAction:(id)sender {
    
    xxzLoginSettingView *nlineView = [[xxzLoginSettingView alloc]init];
    nlineView.provinceAddress = self.provinceAddress;
    nlineView.cityAddress = self.cityAddress;
    
    nlineView.Block = ^(NSDictionary *startDic, NSDictionary *endDic) {
        self.adressTf.text = [NSString stringWithFormat:@"%@-%@",startDic[@"name"],endDic[@"name"]];
        self.adressTf.hidden = NO;
    };
    [nlineView show];
}


- (IBAction)nextAction:(id)sender {
   
    if (self.nextblock) {
        self.nextblock();
    }
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzSettingOginView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
    self.provinceAddress = @"";
    self.cityAddress = @"";
    
    self.adressTf.hidden = YES;
    __weak typeof(self) weakSelf = self;
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [weakSelf.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    

    
}
@end
