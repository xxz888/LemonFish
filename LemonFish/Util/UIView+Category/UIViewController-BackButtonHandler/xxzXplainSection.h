

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


@protocol BIxxzEmptyAbbar <NSObject>

@optional

-(BOOL)navigationShouldPopOnBackButton;

@end

@interface UIViewController (BackButtonHandler) <BIxxzEmptyAbbar>

@end
