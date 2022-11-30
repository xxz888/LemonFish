
#import "xxzInfoController.h"
#import "xxzExtensionView.h"
#import "xxzListController.h"
#import "xxzLabelFootController.h"
#import "xxzPackageNameController.h"
#import "xxzBackController.h"

@interface xxzInfoController ()
@property (nonatomic, strong) xxzExtensionView *shoukkuanblock;
@property (nonatomic , strong) NSArray *huankuanjineNum;

@end

@implementation xxzInfoController


-(void)getData{
    int liebianrenshu = arc4random() % 14 + 1;
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:@"1" forKey:@"page"];
    [pass setObject:@"14" forKey:@"page_size"];
    [pass setObject:@(4) forKey:@"cid"];
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/shop/api/getGood/all" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            self.huankuanjineNum = responseObject[@"content"];
            
        }
    } failure:^(NSString * _Nonnull error) {

    }];
}


- (xxzExtensionView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzExtensionView alloc] init];
    }
    return _shoukkuanblock;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;

    [self getData];
    
    [self.shoukkuanblock.banner bk_whenTapped:^{
        if (![self toLogin]) {
            return;
        }
        self.tabBarController.selectedIndex = 1;
    }];
    [self.shoukkuanblock.messageView bk_whenTapped:^{
        if (![self toLogin]) {
            return;
        }
        [self.xp_rootNavigationController pushViewController:[xxzListController new] animated:YES];
    }];
    
    __weak __typeof(self)weakSelf = self;
    self.mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    
    
    [self.shoukkuanblock.icon1 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"居家日用";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.icon2 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"箱包";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.icon3 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"女装";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.icon4 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"男装";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.icon5 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"美妆";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.icon6 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"配饰";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.icon7 bk_whenTapped:^{
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"数码家电";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.icon8 bk_whenTapped:^{
        
        xxzPackageNameController * scriptController = [[xxzPackageNameController alloc]init];
        
        scriptController.requestString = @"户外运动";
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    [self.shoukkuanblock.searchView bk_whenTapped:^{
        
        xxzBackController * scriptController = [[xxzBackController alloc]init];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv0 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{
                        @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/00.jpg",
                        @"tao_title":@"双效抗氧，锁住年轻肌，人参抗皱精华套装",
                        @"size":@"958",
                        @"sellCount":@"23",
                        @"provcity":@"浙江 杭州",
                        @"pinpai_name":@"化妆品",
                        @"level_one_category_name":@"神仙水/护肤品",
                        @"coupon_info":@"满100减50",
                        @"jianjie":@"人参精华液作用和功效,人参含多种皂甙和多糖类成分,扩张皮肤毛细血管,促进皮肤血液循环,调节皮肤的水油平衡,防止皮肤脱水、硬化、起皱,增强皮肤弹性。",

        };

        
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv1 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{
                        @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/11.jpg",
                        @"tao_title":@"橄榄睡莲活妍舒缓洁面绵密泡沫120ml",
                        @"size":@"239",
                        @"sellCount":@"123",
                        @"provcity":@"浙江 杭州",
                        @"pinpai_name":@"细腻密集泡沫",
                        @"level_one_category_name":@"正常规格/洁面泡",
                        @"coupon_info":@"满200减30",
                        @"jianjie":@"包含橄榄精华油睡莲精萃，还有薰衣草、洋甘菊、天竺葵多重植萃。主打橄榄抗老，每天晚上摇一摇用两滴放到水乳里，第二天皮肤水润透脸蛋子嫩嫩的，而且保湿加锁水。",

        };
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv2 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{
                        @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/22.jpg",
                        @"tao_title":@"神仙水精华液精华水保湿紧致修护",
                        @"size":@"270",
                        @"sellCount":@"34",
                        @"provcity":@"浙江 杭州",
                        @"pinpai_name":@"tokenCityMinute",
                        @"level_one_category_name":@"收缩毛孔 修护 紧致 水油平衡",
                        @"coupon_info":@"满99减32",
                        @"jianjie":@"神仙水就是护肤精华露 ，护肤精华露从肌肤的根本着手，可以有效的呵护肌肤，从而促进人们肌肤新陈代谢，能够有效的让保养成分渗透到肌肤里层去，为人们的肌肤打好补水保湿的基础。",

        };
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv3 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{
                        @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/33.jpg",
                        @"tao_title":@"微震提拉淡细纹，资生堂悦薇抗皱霜纯A醇小针管眼霜淡化黑眼圈",
                        @"size":@"319",
                        @"sellCount":@"23",
                        @"provcity":@"浙江 杭州",
                        @"pinpai_name":@"悦薇智感塑颜抗皱霜",
                        @"level_one_category_name":@"任何肤质/基本款",
                        @"coupon_info":@"满88减10",
                        @"jianjie":@"眼部密集修护精华露，开创眼部护理先锋理念，定义眼部年轻全新标准。 眼部密集修护精华露，眼部细胞再生第一步。 同样具备密集修护精华露的卓越细胞再生功效，令娇嫩眼周肌肤尽绽年轻美丽。",

        };
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv4 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{
                        @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/44.jpg",
                        @"tao_title":@"水活力紧致面霜，焕活紧实水嫩皮肤",
                        @"size":@"479",
                        @"sellCount":@"23",
                        @"provcity":@"浙江 杭州",
                        @"pinpai_name":@"化妆品",
                        @"level_one_category_name":@"面霜/乳液",
                        @"coupon_info":@"满200减50",
                        @"jianjie":@"面霜、乳液是基础护肤最重要的一步了，面霜、乳液中的美白、抗衰老等有效成分能够更好的被肌肤吸收，所以，拥有一瓶好的面霜/乳液可是非常重要的。",

        };
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    
    
    
    
    
    [self.shoukkuanblock.itemnewImv0 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{};
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];

    [self.shoukkuanblock.itemnewImv1 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{};
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv2 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{};
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv3 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{};
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.itemnewImv4 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = @{};
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
}

-(void)layoutTableView{
    self.mc_tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight);
}

@end
