
#import "xxzTitleHuxukaView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzBoutRticlesController.h"



@implementation xxzTitleHuxukaView




- (void)drawRect:(CGRect)rect {
    self.navImvHeight.constant = kStatusBarHeight + 255;
    self.safeTopHeight.constant = kStatusBarHeight;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzTitleHuxukaView" owner:nil options:nil] firstObject];
    }
    return self;
}

- (IBAction)backAction:(id)sender {
    [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
}
@end
