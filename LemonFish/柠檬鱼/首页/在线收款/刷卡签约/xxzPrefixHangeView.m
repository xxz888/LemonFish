
#import "xxzPrefixHangeView.h"
#import "xxzErsionUppotController.h"


@interface xxzPrefixHangeView()
@property (nonatomic , strong) NSString *provinceAddress;
@property (nonatomic , strong) NSString *cityAddress;
@end

@implementation xxzPrefixHangeView




- (IBAction)nextAction:(id)sender {
   
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzPrefixHangeView" owner:nil options:nil] firstObject];
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
