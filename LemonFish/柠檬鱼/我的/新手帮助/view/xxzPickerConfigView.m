
#import "xxzPickerConfigView.h"
#import "xxzSettingController.h"
#import "xxzBaseEceiveController.h"

@implementation xxzPickerConfigView




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;


    [self.logoImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzPickerConfigView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
