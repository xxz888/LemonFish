
#import "xxzLoginReateView.h"
#import "xxzSettingController.h"
#import "xxzHeaderController.h"
#import "xxzToolFootController.h"
#import "xxzBoutRticlesController.h"



@implementation xxzLoginReateView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"xxzLoginReateView" owner:nil options:nil] firstObject];
    }
    return self;
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
    
    
    [self.xinyongkaImv rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzToolFootController * scriptController = [[xxzToolFootController alloc]init];
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.xinyongkaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzBoutRticlesController * scriptController = [[xxzBoutRticlesController alloc]init];
        scriptController.isChangeCome = YES;
        scriptController.isChuxukaCome = NO;
        [self.viewController.navigationController pushViewController:scriptController animated:YES];
    }];
}
@end
