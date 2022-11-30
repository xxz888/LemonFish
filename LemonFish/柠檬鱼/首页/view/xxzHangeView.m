
#import "xxzHangeView.h"
#import "xxzSettingController.h"
#import "xxzBaseEceiveController.h"
#import "xxzCenterControlController.h"
#import "xxzAbberController.h"
#import "xxzSignInyongkaController.h"

@implementation xxzHangeView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzHangeView" owner:nil options:nil] firstObject];
    }
    return self;
}


- (IBAction)moreNewAction:(id)sender {
    
    [self.viewController.xp_rootNavigationController pushViewController:[xxzAbberController new] animated:YES];
}


- (void)drawRect:(CGRect)rect {
    self.safeTopHeight.constant = kStatusBarHeight;
    
    [self.logoImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController pushViewController:[xxzBaseEceiveController new] animated:YES];
    }];
    
    
    
    
    
    
    
    [self.view1 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.huabeiblock) {
            self.huabeiblock();
        }
    }];
    
    [self.view2 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.xinyongkablock) {
            self.xinyongkablock();
        }
    }];
    
    [self.view3 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.zaixiankefublock) {
            self.zaixiankefublock();
        }
    }];
    
    [self.view4 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self.viewController.xp_rootNavigationController pushViewController:[xxzSignInyongkaController new] animated:YES];
    }];
    
    [self.view10 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.shoukkuanblock) {
            self.shoukkuanblock();
        }
    }];
    
    [self.view11 rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.huankuanblock) {
            self.huankuanblock();
        }
    }];
    
    
    
    
    [self.messageImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        self.viewController.tabBarController.selectedIndex = 1;

    }];
    
    

    
    
    
}
@end
