
#import "xxzUpdateNavigationView.h"
#import "xxzSettingController.h"
@implementation xxzUpdateNavigationView




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    
    
    
    

}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzUpdateNavigationView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
