
#import "xxzOastView.h"
#import "xxzSettingController.h"
@implementation xxzOastView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzOastView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    
    
    
    [self.backImv bk_whenTapped:^{
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];

}
@end
