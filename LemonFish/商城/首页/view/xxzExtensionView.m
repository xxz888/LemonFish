
#import "xxzExtensionView.h"

@implementation xxzExtensionView




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzExtensionView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
