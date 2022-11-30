
#import "xxzConfigGoodsView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzToolFootController.h"



@implementation xxzConfigGoodsView




- (IBAction)backAction:(id)sender {
    [self.viewController.tabBarController.xp_rootNavigationController popViewControllerAnimated:YES];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzConfigGoodsView" owner:nil options:nil] firstObject];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.navImvHeight.constant = kStatusBarHeight + 64;
    self.safeTopHeight.constant = kStatusBarHeight;
    
    
    
    [self.chuxukaImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        
        
        xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.chuxukaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    
    [self.xinyongkaImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzToolFootController * scriptController = [[xxzToolFootController alloc]init];
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    
}
@end
