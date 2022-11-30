
#import "xxzMainCardController.h"
#import <objc/runtime.h>


#pragma mark - 容器控制器
@interface xxzTitleHideController : UIViewController

@property (nonatomic, weak) UIViewController *contentViewController;
+ (instancetype)containerViewControllerWithViewController:(UIViewController *)viewController;

@end

@implementation xxzTitleHideController

+ (instancetype)containerViewControllerWithViewController:(UIViewController *)viewController {
    if (viewController.parentViewController) {
        [viewController willMoveToParentViewController:nil];
        [viewController removeFromParentViewController];
    }
    
    Class mengban = [viewController xp_navigationControllerClass];
    NSAssert(![mengban isKindOfClass:UINavigationController.class], @"`-xp_navigationControllerClass` must return UINavigationController or its subclasses.");
    
    UINavigationController *inyongkaView = [[mengban alloc] initWithRootViewController:viewController];
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *status = [[UINavigationBarAppearance alloc] init];
        status.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        [status configureWithOpaqueBackground];
        status.backgroundColor = [UIColor whiteColor];
        status.backgroundImage = [UIImage imageNamed:@"zhengmianfanmianCollectionviewMin"];
        status.shadowImage = nil;
        status.titleTextAttributes = @{NSFontAttributeName:[UIFont getUIFontSize:18 IsBold:YES], NSForegroundColorAttributeName:FontThemeColor};
        [inyongkaView.navigationBar setTranslucent:false];
        inyongkaView.navigationBar.scrollEdgeAppearance = status;
        inyongkaView.navigationBar.standardAppearance = status;
    }else{
        
        inyongkaView.navigationBar.shadowImage = [UIImage new];
        
        UIImage *naviD =[UIImage imageWithColor:[UIColor whiteColor]];
        naviD = [naviD resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [inyongkaView.navigationBar setBackgroundImage:naviD forBarMetrics:UIBarMetricsDefault];
        
        [inyongkaView.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19], NSForegroundColorAttributeName:FontThemeColor}];
        
        [inyongkaView.navigationBar setBackgroundImage:[UIImage imageNamed:@"zhengmianfanmianCollectionviewMin"] forBarMetrics:UIBarMetricsDefault];
    }
    
    
    
    inyongkaView.navigationBar.tintColor = FontThemeColor;
    inyongkaView.interactivePopGestureRecognizer.enabled = NO;
    
    
    
    xxzTitleHideController *tabController = [[xxzTitleHideController alloc] init];
    tabController.contentViewController = viewController;
    tabController.hidesBottomBarWhenPushed = viewController.hidesBottomBarWhenPushed;
    [tabController addChildViewController:inyongkaView];
    [tabController.view addSubview:inyongkaView.view];
    [inyongkaView didMoveToParentViewController:tabController];
    
    
    
    return tabController;
}

@end


#pragma mark - 全局函数

UIKIT_STATIC_INLINE UIViewController* XPWrapViewController(UIViewController *vc)
{
    if ([vc isKindOfClass:xxzTitleHideController.class]) {
        return vc;
    }
    return [xxzTitleHideController containerViewControllerWithViewController:vc];
}

UIKIT_STATIC_INLINE UIViewController* XPUnwrapViewController(UIViewController *vc)
{
    if ([vc isKindOfClass:xxzTitleHideController.class]) {
        return ((xxzTitleHideController*)vc).contentViewController;
    }
    return vc;
}


#pragma mark - 导航栏控制器

@interface xxzMainCardController ()<UIGestureRecognizerDelegate>
@end

@implementation xxzMainCardController

#pragma mark Lifecycle

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.interactivePopGestureRecognizer.enabled = NO;
    self.backIconImage = [UIImage imageNamed:@"cardXiaofeidiqvTemp"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        
        UIImage *playImage = self.backIconImage ?: [self navigationBarBackIconImage];
        
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        UIBarButtonItem *animationItem = [[UIBarButtonItem alloc] initWithImage:[playImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:viewController action:@selector(xp_popViewController)];
#pragma clang diagnostic pop
        viewController.navigationItem.leftBarButtonItem = animationItem;
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:XPWrapViewController(viewController) animated:animated];

}
- (void)handleNavigationTransition:(UIPanGestureRecognizer *)sender{
    
}
#pragma mark <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    
    CGPoint outsidew = [gestureRecognizer locationInView:self.view];
    CGPoint jiaoyifei   = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    BOOL    buy   = (0 < jiaoyifei.x && outsidew.x <= (DEVICE_WIDTH/4.0));
    return buy;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    
    
    
    
    return (gestureRecognizer == self.interactivePopGestureRecognizer);
}

#pragma mark Private

- (void)commonInit {
    UIViewController *weekController = self.topViewController;

    if (weekController) {
        UIViewController *footController = XPWrapViewController(weekController);
        [super setViewControllers:@[footController] animated:NO];
    }
    [self setNavigationBarHidden:YES animated:NO];
}

- (UIImage *)navigationBarBackIconImage {
    CGSize const size = CGSizeMake(15.0, 21.0);
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    
    UIColor *d_image = [UIColor colorWithRed:0.0 green:0.48 blue:1.0 alpha:1.0];
    [d_image setFill];
    [d_image setStroke];
    
    UIBezierPath* price = [UIBezierPath bezierPath];
    [price moveToPoint: CGPointMake(10.9, 0)];
    [price addLineToPoint: CGPointMake(12, 1.1)];
    [price addLineToPoint: CGPointMake(1.1, 11.75)];
    [price addLineToPoint: CGPointMake(0, 10.7)];
    [price addLineToPoint: CGPointMake(10.9, 0)];
    [price closePath];
    [price moveToPoint: CGPointMake(11.98, 19.9)];
    [price addLineToPoint: CGPointMake(10.88, 21)];
    [price addLineToPoint: CGPointMake(0.54, 11.21)];
    [price addLineToPoint: CGPointMake(1.64, 10.11)];
    [price addLineToPoint: CGPointMake(11.98, 19.9)];
    [price closePath];
    [price setLineWidth:1.0];
    [price fill];
    [price stroke];
    
    UIImage *huankuanblockImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return huankuanblockImage;
}

#pragma mark setter & getter

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    [super setNavigationBarHidden:YES];
}

- (void)setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    [super setNavigationBarHidden:YES animated:NO];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    NSMutableArray<UIViewController *> *aViewControllers = [NSMutableArray array];
    for (UIViewController *vc in viewControllers) {
        [aViewControllers addObject:XPWrapViewController(vc)];
    }
    [super setViewControllers:aViewControllers animated:animated];
}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    NSMutableArray<UIViewController *> *aViewControllers = [NSMutableArray array];
    for (UIViewController *vc in viewControllers) {
        [aViewControllers addObject:XPWrapViewController(vc)];
    }
    [super setViewControllers:[NSArray arrayWithArray:aViewControllers]];
}

- (NSArray<UIViewController *> *)viewControllers {
    
    NSMutableArray<UIViewController *> *vcs = [NSMutableArray array];
    NSArray<UIViewController *> *viewControllers = [super viewControllers];
    for (UIViewController *vc in viewControllers) {
        [vcs addObject:XPUnwrapViewController(vc)];
    }
    return [NSArray arrayWithArray:vcs];
}

@end


#pragma mark -

@implementation UIViewController (XPNavigationContainer)

- (Class)xp_navigationControllerClass {
#ifdef kXPNavigationControllerClassName
    return NSClassFromString(kXPNavigationControllerClassName);
#else
    return [xxzModityController class];
#endif
}

- (xxzMainCardController *)xp_rootNavigationController {
    UIViewController *arnerController = self.navigationController.parentViewController;
    
    if (arnerController && [arnerController isKindOfClass:xxzTitleHideController.class]) {
        xxzTitleHideController *dingdanzhuangkuang = (xxzTitleHideController*)arnerController;
        return (xxzMainCardController*)dingdanzhuangkuang.navigationController;
    }
    return nil;
}

- (void)xp_popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma 返回指定界面
- (void)backToAppointedController:(UIViewController *)VC{
    UINavigationController *unicodeController = self.xp_rootNavigationController;
    NSMutableArray *shadow = [[NSMutableArray alloc] init];
    for (UIViewController *vc in unicodeController.viewControllers) {
        [shadow addObject:vc];
        if ([vc isKindOfClass:[VC class]]) {
            break;
        }
    }
    if (shadow.count == unicodeController.viewControllers.count) {
        [self.xp_rootNavigationController popViewControllerAnimated:YES];
    }
    else {
        [unicodeController setViewControllers:shadow animated:YES];
    }
}
- (void)changeTheNavigationBarStyle:(UIColor *)returnColor navTitle:(UIColor *)titleColor navBackgroundColor:(UIColor *)backgroundColor{
    
    titleColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = returnColor;
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *statuso = [[UINavigationBarAppearance alloc] init];
        statuso.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        [statuso configureWithOpaqueBackground];
        statuso.backgroundColor = backgroundColor;
        statuso.shadowImage = [UIImage imageWithColor:[UIColor clearColor]];
        statuso.titleTextAttributes = @{NSFontAttributeName:[UIFont getUIFontSize:18 IsBold:YES], NSForegroundColorAttributeName:titleColor};
        
        self.navigationController.navigationBar.scrollEdgeAppearance = statuso;
        self.navigationController.navigationBar.standardAppearance = statuso;
    }else{
        
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        
        UIImage *naviDc =[UIImage imageWithColor:backgroundColor];
        naviDc = [naviDc resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
        [self.navigationController.navigationBar setBackgroundImage:naviDc forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont getUIFontSize:18 IsBold:YES], NSForegroundColorAttributeName:titleColor}];
    }
}
+ (UIViewController*)currentViewController{
    UIViewController* scriptController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (1) {
        if ([scriptController isKindOfClass:[UITabBarController class]]) {
            scriptController = ((UITabBarController*)scriptController).selectedViewController;
        }
        if ([scriptController isKindOfClass:[xxzMainCardController class]]) {
            scriptController = ((xxzMainCardController*)scriptController).visibleViewController;
        }
        if (scriptController.presentedViewController) {
            scriptController = scriptController.presentedViewController;
        }else{
            break;
        }
    }
    return scriptController;
}

@end


#pragma mark -

@interface UINavigationController (XPNavigationContainer)
@end

@implementation UINavigationController (XPNavigationContainer)

+ (void)load {
    static dispatch_once_t actionse;
    dispatch_once(&actionse, ^{
        NSArray *pre = @[
                             NSStringFromSelector(@selector(pushViewController:animated:)),
                             NSStringFromSelector(@selector(popViewControllerAnimated:)),
                             NSStringFromSelector(@selector(popToViewController:animated:)),
                             NSStringFromSelector(@selector(popToRootViewControllerAnimated:)),
                             NSStringFromSelector(@selector(viewControllers))
                             ];
        
        for (NSString *str in pre) {
            Method hand = class_getInstanceMethod(self, NSSelectorFromString(str));
            Method list = class_getInstanceMethod(self, NSSelectorFromString([@"xp_" stringByAppendingString:str]));
            method_exchangeImplementations(hand, list);
        }
    });
    
}

#pragma mark Private

- (xxzMainCardController *)rootNavigationController {
    if (self.parentViewController && [self.parentViewController isKindOfClass:xxzTitleHideController.class]) {
        xxzTitleHideController *tabControllerL = (xxzTitleHideController *)self.parentViewController;
        xxzMainCardController *empowerController = (xxzMainCardController *)tabControllerL.navigationController;
        return empowerController;
    }
    return nil;
}

#pragma mark Override

- (void)xp_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    xxzMainCardController *empowerControllery = [self rootNavigationController];
    if (empowerControllery) {
        return [empowerControllery pushViewController:viewController animated:animated];
    }
    [self xp_pushViewController:viewController animated:animated];
}

- (UIViewController *)xp_popViewControllerAnimated:(BOOL)animated {
    xxzMainCardController *empowerControllerv = [self rootNavigationController];
    if (empowerControllerv) {
        xxzTitleHideController *tabControllerc = (xxzTitleHideController*)[empowerControllerv popViewControllerAnimated:animated];
        return tabControllerc.contentViewController;
    }
    return [self xp_popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)xp_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    xxzMainCardController *empowerControllert = [self rootNavigationController];
    if (empowerControllert) {
        NSArray<UIViewController*> *array = [empowerControllert popToViewController:viewController animated:animated];
        NSMutableArray *shadowF = [NSMutableArray array];
        for (UIViewController *vc in array) {
            [shadowF addObject:XPUnwrapViewController(vc)];
        }
        return shadowF;
    }
    return [self xp_popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)xp_popToRootViewControllerAnimated:(BOOL)animated {
    xxzMainCardController *empowerControllertG = [self rootNavigationController];
    if (empowerControllertG) {
        NSArray<UIViewController*> *array = [empowerControllertG popToRootViewControllerAnimated:animated];
        NSMutableArray *shadowc = [NSMutableArray array];
        for (UIViewController *vc in array) {
            [shadowc addObject:XPUnwrapViewController(vc)];
        }
        return shadowc;
    }
    return [self xp_popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)xp_viewControllers {
    xxzMainCardController *empowerControllers = [self rootNavigationController];
    if (empowerControllers) {
        return [empowerControllers viewControllers];
    }
    return [self xp_viewControllers];
}

@end


#pragma mark - 状态栏样式 & 屏幕旋转

@implementation xxzModityController



- (UIViewController *)childViewControllerForStatusBarStyle {
    if (self.topViewController) {
        return XPUnwrapViewController(self.topViewController);
    }
    return [super childViewControllerForStatusBarStyle];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    if (self.topViewController) {
        return XPUnwrapViewController(self.topViewController);
    }
    return [super childViewControllerForStatusBarHidden];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) preferredStatusBarStyle];
    }
    return [super preferredStatusBarStyle];
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) preferredStatusBarUpdateAnimation];
    }
    return [super preferredStatusBarUpdateAnimation];
}

- (BOOL)prefersStatusBarHidden {
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) prefersStatusBarHidden];
    }
    return [super prefersStatusBarHidden];
}

- (BOOL)shouldAutorotate {
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) shouldAutorotate];
    }
    return [super shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) preferredInterfaceOrientationForPresentation];
    }
    return [super preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) supportedInterfaceOrientations];
    }
    return [super supportedInterfaceOrientations];
}

#if __IPHONE_11_0 && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0
- (nullable UIViewController *)childViewControllerForScreenEdgesDeferringSystemGestures
{
    if (self.topViewController) {
        return XPUnwrapViewController(self.topViewController);
    }
    return [super childViewControllerForScreenEdgesDeferringSystemGestures];
}

- (UIRectEdge)preferredScreenEdgesDeferringSystemGestures
{
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) preferredScreenEdgesDeferringSystemGestures];
    }
    return [super preferredScreenEdgesDeferringSystemGestures];
}

- (BOOL)prefersHomeIndicatorAutoHidden
{
    if (self.topViewController) {
        return [XPUnwrapViewController(self.topViewController) prefersHomeIndicatorAutoHidden];
    }
    return [super prefersHomeIndicatorAutoHidden];
}

- (UIViewController *)childViewControllerForHomeIndicatorAutoHidden
{
    if (self.topViewController) {
        return XPUnwrapViewController(self.topViewController);
    }
    return [super childViewControllerForHomeIndicatorAutoHidden];
}
#endif

@end
