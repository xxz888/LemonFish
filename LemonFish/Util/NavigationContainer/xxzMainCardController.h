


#import <UIKit/UIKit.h>




@interface xxzModityController : UINavigationController



@end


@interface xxzMainCardController : xxzModityController

@property (nonatomic, strong) IBInspectable UIImage *backIconImage;

@end


@interface UIViewController (XPNavigationContainer)


- (Class)xp_navigationControllerClass;

- (xxzMainCardController *)xp_rootNavigationController;
- (void)changeTheNavigationBarStyle:(UIColor *)returnColor navTitle:(UIColor *)titleColor navBackgroundColor:(UIColor *)backgroundColor;
+ (UIViewController*)currentViewController;

#pragma 返回指定界面 -----在线收款------
- (void)backToAppointedController:(UIViewController *)VC;

@end
