
#import "xxzAddressMessageView.h"
#import "xxzErsionUppotController.h"


@interface xxzAddressMessageView()
@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;
@end

@implementation xxzAddressMessageView




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
        
  
    }];
    NSMutableArray * modity = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 31; i++) {
        [modity addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    comeView.MyearArray = modity;
    comeView.yearLabelColor = [UIColor clearColor];
    [comeView show];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzAddressMessageView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (IBAction)paizhaoAction:(id)sender {
    if (self.upLoadblock) {
        self.upLoadblock();
    }
}
@end
