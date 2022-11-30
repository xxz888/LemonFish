
#import "xxzAutoController.h"

@interface xxzAutoController ()

@end

@implementation xxzAutoController


- (NSArray *)rootViewController{
    
    
    
    NSArray * label= @[];

    
    
    
    
    NSUserDefaults *lijitixian = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblock = [lijitixian objectForKey:@"UserData"];
    
    NSArray *rgb = @[];
    
    NSArray *progress = @[];
    
    
    NSArray *margin = @[];
    
    
    
    
    if (!huabeiblock || ( [huabeiblock allKeys].count > 0 && [huabeiblock[@"username"] isEqualToString:@"13383773800"] )) {


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
    }
    
    return shadow;

    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.viewControllers = [self rootViewController];
    
    
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];

    if (@available(iOS 13.0, *)) {
            self.tabBarController.tabBar.unselectedItemTintColor = [UIColor colorWithHexString:@"#666666"];
            self.tabBarController.tabBar.tintColor = [UIColor blackColor];
    } else {
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
            [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#666666"]} forState:UIControlStateNormal];
    }
    
}

@end
