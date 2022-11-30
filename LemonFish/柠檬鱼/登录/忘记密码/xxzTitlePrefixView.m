
#import "xxzTitlePrefixView.h"
#import "xxzSettingController.h"
@implementation xxzTitlePrefixView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzTitlePrefixView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    
 
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

@end
