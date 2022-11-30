
#import "xxzScreenListView.h"
#import "xxzSettingController.h"
#import "xxzBaseEceiveController.h"

@implementation xxzScreenListView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzScreenListView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;


   
    
}
@end
