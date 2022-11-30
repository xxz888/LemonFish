
#import "xxzImageRecordView.h"


@interface xxzImageRecordView()

@end

@implementation xxzImageRecordView




- (IBAction)nextAction:(id)sender {
   

}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
 
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzImageRecordView" owner:nil options:nil] firstObject];
    }
    return self;
}


@end
