
#import "xxzConfirmToolView.h"
#import "xxzSettingController.h"
#import "xxzOginEmptyController.h"

@implementation xxzConfirmToolView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzConfirmToolView" owner:nil options:nil] firstObject];
    }
    return self;
}

- (IBAction)backAction:(id)sender {
    [self.viewController.tabBarController.xp_rootNavigationController popViewControllerAnimated:YES];

}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;

 
    [self.tuiguangImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController pushViewController:[xxzOginEmptyController new] animated:YES];

    }];

}
@end
