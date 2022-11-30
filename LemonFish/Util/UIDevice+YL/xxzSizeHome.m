
#import "xxzSizeHome.h"

#import <sys/utsname.h>

#import "AppDelegate.h"


@implementation UIDevice (YL)


+ (NSString *)getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}


+ (NSString *)getAppVersionName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}


+ (BOOL)isIphone12Mini {
    struct utsname abbar;
    uname(&abbar);
    
    NSString *shenqingbanka = [NSString stringWithCString:abbar.machine encoding:NSASCIIStringEncoding];
    if([shenqingbanka isEqualToString:@"iPhone13,1"]) {
        return YES;
    }else if ([shenqingbanka isEqualToString:@"x86_64"] || [shenqingbanka isEqualToString:@"i386"]) {
        if (([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !HX_UI_IS_IPAD : NO)) {
            return YES;
        }
    }
    return NO;
}


+ (BOOL)isPhoneX {
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {
        return NO;
    }
    
    if (@available(iOS 11.0, *)) {
        if ([self currentWindow].safeAreaInsets.bottom > 0) {
            return YES;
        }
    } else {
        
        if (![[UIApplication sharedApplication] isStatusBarHidden] && UIApplication.sharedApplication.statusBarFrame.size.height> 20) {
            return YES;
        }
    }
    
    return NO;
}


+ (NSString *)getAppVersionCode {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}



+ (CGFloat)statusBarHeight {
    CGFloat rticle = 0;
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *store = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        rticle = store.statusBarFrame.size.height;
        if ([self isIphone12Mini]) {
            rticle = 50;
        }else {
            if ([UIApplication sharedApplication].statusBarHidden) {
                rticle = HX_IS_IPhoneX_All ? 44: 20;
            }
        }
    }
    else {
        if ([UIApplication sharedApplication].statusBarHidden) {
            rticle = HX_IS_IPhoneX_All ? 44: 20;
        }else {
            rticle = [UIApplication sharedApplication].statusBarFrame.size.height;
        }
    }
    return rticle;
}



+ (UIWindow *)currentWindow {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return delegate.window;
}


+ (CGFloat)bottomSafeHeight {
    
    if ([self isPhoneX]) {
        return 36;
    }
    return 0;
}


@end
