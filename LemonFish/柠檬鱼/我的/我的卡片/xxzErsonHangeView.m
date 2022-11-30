
#import "xxzErsonHangeView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzToolFootController.h"



@implementation xxzErsonHangeView




- (void)drawRect:(CGRect)rect {
    self.navImvHeight.constant = kStatusBarHeight + 64;
    self.safeTopHeight.constant = kStatusBarHeight;
    
    
    
    [self.chuxukaImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        
        
        xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
        scriptController.empowerToken = self.empowerToken;
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.chuxukaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
        scriptController.empowerToken = self.empowerToken;

        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    
    [self.xinyongkaImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzToolFootController * scriptController = [[xxzToolFootController alloc]init];
        scriptController.empowerToken = self.empowerToken;
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzErsonHangeView" owner:nil options:nil] firstObject];
    }
    return self;
}

- (IBAction)backAction:(id)sender {
    if (self.empowerToken) {
        [self.viewController.tabBarController.xp_rootNavigationController popViewControllerAnimated:YES];

    }else{
        [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];

    }
}
@end
