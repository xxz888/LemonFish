
#import "xxzHideAnnerView.h"
#import "xxzSettingController.h"
#import "xxzBaseEceiveController.h"

@implementation xxzHideAnnerView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzHideAnnerView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;


    [self.logoImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
}
@end
