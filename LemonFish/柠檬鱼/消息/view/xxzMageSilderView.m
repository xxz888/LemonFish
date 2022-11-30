
#import "xxzMageSilderView.h"
#import "xxzSettingController.h"
#import "xxzBaseEceiveController.h"

@implementation xxzMageSilderView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzMageSilderView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;


   
    
}
@end
