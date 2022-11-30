
#import "xxzErsionController.h"
#import "xxzListHandlerController.h"
#import "xxzConfirmToolsController.h"
#import "xxzCardAddressController.h"
#import "xxzRticleRticlesController.h"
#import "xxzToastController.h"
#import "xxzBoutRticlesController.h"
@interface xxzErsionController ()<UITabBarControllerDelegate>

@end

@implementation xxzErsionController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
   
}

- (instancetype)initWithEmpowerToken:(NSString *)empowerToken userDic:(NSDictionary *)userDic{

    self = [super init];
    if (self) {
        self.empowerToken = empowerToken;
        self.userDic = userDic;

        [self rootViewController];
    }
    return self;
}
#pragma --------- tabber 切换拦截 及 实名认证跳转 ------------

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    id titles = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * tip = [[UIPanGestureRecognizer alloc]initWithTarget:titles action:nil];
    [self.view addGestureRecognizer:tip];
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    
    xxzMainCardController *loading = (xxzMainCardController *)viewController;
    UIViewController *circle = loading.viewControllers.firstObject;
    return YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)rootViewController{
    
    NSArray * label= @[];
    NSArray *margin = @[];

    if ( self.empowerToken) {
        label = @[@"xxzConfirmToolsController",@"xxzCardAddressController",@"xxzBoutRticlesController"];
        margin = @[@"卡列表",@"执行中",@"客户卡包"];
    }else{
        label= @[@"xxzConfirmToolsController",@"xxzCardAddressController",@"xxzToastController"];
        margin = @[@"卡列表",@"执行中",@"操作说明"];
    }


    
    NSArray *rgb = @[@"sureVery",@"nviteConstraintCollectionview",@"imagesEtworking"];
    
    NSArray *progress = @[@"superviewTokenOffset",@"chuxukaAni",@"nameGoodsRticles"];
    
    
    
    NSMutableArray *shadow = [NSMutableArray array];
    for (int index = 0; index < label.count; index++) {
        UIViewController *observerController = [[NSClassFromString(label[index]) alloc] initWithNibName:nil bundle:nil];
        
        if (index == 0 && self.empowerToken) {
            xxzConfirmToolsController * optation = (xxzConfirmToolsController *)observerController;
            optation.empowerToken = self.empowerToken;
            optation.userDic = self.userDic;

        }
        
        if (index == 1 && self.empowerToken) {
            xxzCardAddressController * optation = (xxzCardAddressController *)observerController;
            optation.empowerToken = self.empowerToken;
        }
        
        if (index == 2 && self.empowerToken) {
            xxzBoutRticlesController * optation = (xxzBoutRticlesController *)observerController;
            optation.empowerToken = self.empowerToken;
            optation.userDic = self.userDic;
        }
        
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

@end
