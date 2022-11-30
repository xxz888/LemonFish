
#import "xxzMainEgmentView.h"


@interface xxzMainEgmentView()

@end

@implementation xxzMainEgmentView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzMainEgmentView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (IBAction)nextAction:(id)sender {
   

}




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
 
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
}


@end
