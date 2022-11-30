
#import "xxzInsiToastView.h"
#import "xxzSettingController.h"
#import "xxzOginEmptyController.h"

@implementation xxzInsiToastView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzInsiToastView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;

    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController dismissViewControllerAnimated:YES completion:nil ];
    }];
    


}
@end
