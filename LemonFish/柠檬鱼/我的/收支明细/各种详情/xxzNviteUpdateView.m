
#import "xxzNviteUpdateView.h"

@implementation xxzNviteUpdateView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzNviteUpdateView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
