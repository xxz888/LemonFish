
#import "xxzScreenView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzToolFootController.h"



@implementation xxzScreenView




- (IBAction)backAction:(id)sender {
    [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
}


- (void)drawRect:(CGRect)rect {
    self.navImvHeight.constant = kStatusBarHeight + 64;
    self.safeTopHeight.constant = kStatusBarHeight;
    
    
    

    
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzScreenView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
