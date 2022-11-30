
#import "xxzOginView.h"
#import "xxzErsionUppotController.h"


@interface xxzOginView()
@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;
@end

@implementation xxzOginView




- (IBAction)nextAction:(id)sender {
   
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzOginView" owner:nil options:nil] firstObject];
    }
    return self;
}




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
    self.provinceAddress = @"";
    self.cityAddress = @"";
    
    __weak typeof(self) weakSelf = self;
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [weakSelf.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
 
    
}



@end
