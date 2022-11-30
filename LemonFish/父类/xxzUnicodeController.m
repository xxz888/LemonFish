
#import "xxzUnicodeController.h"
#import "xxzListHandlerController.h"
#import "xxzExtensionController.h"
#import "xxzProgressEgmentController.h"
#import "xxzOprationGoodsController.h"

@interface xxzUnicodeController ()<UITabBarControllerDelegate>

@end

@implementation xxzUnicodeController


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    
    xxzMainCardController *loading = (xxzMainCardController *)viewController;
    UIViewController *circle = loading.viewControllers.firstObject;
    
    if ([circle isKindOfClass:[xxzExtensionController class]]  || [circle isKindOfClass:[xxzProgressEgmentController class]]  || [circle isKindOfClass:[xxzOprationGoodsController class]]) {
        NSUserDefaults *lijitixian = [NSUserDefaults standardUserDefaults];
        NSDictionary *huabeiblock = [lijitixian objectForKey:@"UserData"];
        if ([huabeiblock allKeys].count == 0) {
            UIAlertController *font = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
            [font addAction:[UIAlertAction actionWithTitle:@"稍后" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [font addAction:[UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                xxzListHandlerController *pickerController = [xxzListHandlerController new];
                
                
                AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                xxzUnicodeController *library = [[xxzUnicodeController alloc]init];
                delegate.window.rootViewController = pickerController;

          
                
            }]];
            [[UIViewController currentViewController] presentViewController:font animated:YES completion:^{}];
            return NO;
        }
        return YES ;

    }
    return YES;
}
#pragma --------- tabber 切换拦截 及 实名认证跳转 ------------

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)rootViewController{
    
    
    
    NSArray * label= @[];

    
    
    
    
    NSUserDefaults *lijitixians = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblockU = [lijitixians objectForKey:@"UserData"];
    
    NSArray *rgb = @[];
    
    NSArray *progress = @[];
    
    
    NSArray *margin = @[];
    
    
    
    if (!huabeiblockU || ( [huabeiblockU allKeys].count > 0 && [huabeiblockU[@"username"] isEqualToString:@"13383773800"] )) {


        margin = @[@"首页", @"积分", @"订单", @"我的"];;
        rgb = @[@"addressNavigationStop",@"addressQianyuetongdaoIrcle",@"cardpackageDicTop",@"headSegment"];
        progress = @[@"valueReg",@"delegate_1StackResult",@"raiusToastSilder",@"arrowsHexSelected"];
        label = @[@"xxzInfoController",
                                   @"xxzProgressEgmentController",
                                   @"xxzOprationGoodsController",
                                   @"xxzExtensionController"];
    }else{
        
        label =@[@"xxzHeaderListController",
                         @"xxzCenterControlController",
                         @"xxzTableController",
                         @"xxzAggedMagnificationController"];
        margin = @[@"首页", @"消息", @"素材", @"我的"];;
        rgb = @[@"addressNavigationStop",@"subLine",@"cellSegment",@"headSegment"];
        progress = @[@"valueReg",@"bannerStopKapianguanli",@"oprationCollectNews",@"arrowsHexSelected"];
        
    }
    
    
 

  
 
    
    NSMutableArray *shadow = [NSMutableArray array];
    for (int index = 0; index < label.count; index++) {
        UIViewController *observerController = [[NSClassFromString(label[index]) alloc] initWithNibName:nil bundle:nil];
        UITabBarItem *channelItem = [[UITabBarItem alloc] init];
        channelItem.title = margin[index];
        channelItem.image = [[UIImage imageNamed:rgb[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        channelItem.selectedImage = [[UIImage imageNamed:progress[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
         [channelItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#666666"]} forState:UIControlStateNormal];
        
        [channelItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
        
        
        channelItem.imageInsets = UIEdgeInsetsMake(1, 0, -1, 0);
        
        [channelItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
        
        
        xxzMainCardController *oldController = [[xxzMainCardController alloc] initWithRootViewController:observerController];
        
        oldController.navigationController.navigationBar.translucent = YES;
        oldController.tabBarItem = channelItem;
        [shadow addObject:oldController];
        [self addChildViewController:oldController];
    }
    
    
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];

    if (@available(iOS 13.0, *)) {
        self.tabBar.unselectedItemTintColor = [UIColor colorWithHexString:@"#666666"];
        self.tabBar.tintColor = [UIColor blackColor];
    } else {
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"]} forState:UIControlStateNormal];
    }
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    id titles = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * tip = [[UIPanGestureRecognizer alloc]initWithTarget:titles action:nil];
    [self.view addGestureRecognizer:tip];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
  [self rootViewController];

}

@end
