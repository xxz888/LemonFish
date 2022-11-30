
#import "xxzUnicodeView.h"
#import "xxzSettingController.h"
#import "xxzOginEmptyController.h"

@implementation xxzUnicodeView




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;

    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
    [self.tuiguangImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController pushViewController:[xxzOginEmptyController new] animated:YES];

    }];

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzUnicodeView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
