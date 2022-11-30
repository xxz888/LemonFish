
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "xxzInfoController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate



- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"applicationWillEnterForegroundAction" object:nil];

}


-(void)setRootViewController{
    xxzUnicodeController *library = [xxzUnicodeController new];
    self.window.rootViewController = library;
    
    


    
    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self setRootViewController];

    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    
    
    
    return YES;
}
@end
