
#import "xxzXplainSection.h"

@implementation UIViewController (BackButtonHandler)

@end

@implementation UINavigationController (ShouldPopOnBackButton)


+ (void)load {
    
    Method change = class_getInstanceMethod([self class], @selector(navigationBar:shouldPopItem:));
    Method come = class_getInstanceMethod([self class], @selector(overloaded_navigationBar:shouldPopItem:));
    
    method_setImplementation(change, method_getImplementation(come));
}


- (BOOL)overloaded_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {

	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

	BOOL circle = YES;
	UIViewController* scriptController = [self topViewController];
	if([scriptController respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
		circle = [scriptController navigationShouldPopOnBackButton];
	}

	if(circle) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	} else {
		
		for(UIView *subview in [navigationBar subviews]) {
			if(0. < subview.alpha && subview.alpha < 1.) {
				[UIView animateWithDuration:.25 animations:^{
					subview.alpha = 1.;
				}];
			}
		}
	}

	return NO;
}

@end
