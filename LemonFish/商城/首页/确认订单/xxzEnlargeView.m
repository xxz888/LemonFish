
#import "xxzEnlargeView.h"
#import "xxzSettingController.h"
@implementation xxzEnlargeView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzEnlargeView" owner:nil options:nil] firstObject];
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
