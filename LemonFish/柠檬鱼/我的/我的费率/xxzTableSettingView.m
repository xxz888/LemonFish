
#import "xxzTableSettingView.h"
#import "xxzSettingController.h"
#import "xxzOginEmptyController.h"

@implementation xxzTableSettingView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzTableSettingView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;

    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
    [self.tuiguangImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController pushViewController:[xxzOginEmptyController new] animated:YES];

    }];

}
@end
