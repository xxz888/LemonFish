
#import "xxzIrcleView.h"
#import "xxzSettingController.h"
#import "xxzOginEmptyController.h"

@implementation xxzIrcleView




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;

    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
  

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzIrcleView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
