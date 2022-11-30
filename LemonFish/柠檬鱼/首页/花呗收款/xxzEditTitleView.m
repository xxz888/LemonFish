
#import "xxzEditTitleView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzBoutRticlesController.h"
#import "xxzHangeController.h"



@implementation xxzEditTitleView




- (IBAction)recordAction:(id)sender {
    
    
    
   [self.viewController.xp_rootNavigationController pushViewController:[xxzHangeController new] animated:YES];
}


- (IBAction)backAction:(id)sender {
    [self.viewController.xp_rootNavigationController popViewControllerAnimated:YES];
}

- (void)drawRect:(CGRect)rect {
    self.navImvHeight.constant = kStatusBarHeight + 64;
    self.safeTopHeight.constant = kStatusBarHeight;
    
    
    
    [self.chuxukaImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        
        
        xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
        
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.chuxukaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzBoutRticlesController * scriptController = [[xxzBoutRticlesController alloc]init];
        scriptController.isChangeCome = YES;
        scriptController.isChuxukaCome = YES;
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzEditTitleView" owner:nil options:nil] firstObject];
    }
    return self;
}
@end
