
#import "xxzNewsView.h"


@implementation xxzNewsView




- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    self.navHeight.constant = kStatusBarHeight+44;
    
    
    __weak typeof(self) weakSelf = self;
    [self.backImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [weakSelf.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
    [self.zhengmianImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (weakSelf.upLoadblock) {
            weakSelf.upLoadblock(1);
        }
    }];
    
    
    [self.fanmianImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (weakSelf.upLoadblock) {
            weakSelf.upLoadblock(2);
        }
    }];
    
}


- (IBAction)nextAction:(id)sender {
    if (self.nextblock) {
        self.nextblock();
    }
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzNewsView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
