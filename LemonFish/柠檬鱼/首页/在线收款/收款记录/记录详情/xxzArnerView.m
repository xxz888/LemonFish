
#import "xxzArnerView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzToolFootController.h"
#import "xxzBoutRticlesController.h"



@implementation xxzArnerView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzArnerView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.navImvHeight.constant = kStatusBarHeight + 255;
    self.safeTopHeight.constant = kStatusBarHeight;
    
}

- (IBAction)backAction:(id)sender {
    [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
}
@end
