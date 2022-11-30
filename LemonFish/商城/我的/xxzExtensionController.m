
#import "xxzExtensionController.h"
#import "xxzCardView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"
#import "xxzOprationController.h"
#import "xxzHideController.h"
#import "xxzEmptyRticleController.h"
#import "xxzOginEmptyController.h"
#import "xxzOneyMainController.h"
#import "xxzProgressController.h"
#import "xxzTouchController.h"
#import "xxzConstXplainController.h"
#import "xxzOprationView.h"
#import "xxzSuppotController.h"
#import "xxzSettingController.h"
#import "xxzListController.h"
#import "MBProgressHUD.h"

@interface xxzExtensionController ()
@property (nonatomic, strong) xxzCardView *shoukkuanblock;

@end

@implementation xxzExtensionController

- (xxzCardView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzCardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self toLogin]) return;
    [self getData];


}


-(void)getData{
    
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];

    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/user/index" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.shoukkuanblock.shouruLbl.text = [NSString stringWithFormat:@"%.2f元",[responseObject[@"data"][@"totalBalance"] doubleValue]];
            weakSelf.shoukkuanblock.tuanduiLbl.text = [NSString stringWithFormat:@"%@人",responseObject[@"data"][@"teamCount"]];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:[NSString stringWithFormat:@"/api/user/get/%@",huabeiblock[@"id"]] Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.shoukkuanblock.mineName.text = [NSString stringWithFormat:@"Hi~,%@",responseObject[@"data"][@"nick"]];
            weakSelf.shoukkuanblock.mineDengji.text = [responseObject[@"data"][@"vipLevel"] intValue] == 0 ? @"普通":@"会员";
            
            if (responseObject[@"data"][@"avatar"]) {
                [weakSelf.shoukkuanblock.mineIcon sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"avatar"]] forState:0 placeholderImage:nil];
            }
        }
 
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    
    [self.shoukkuanblock.mineIcon bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzBaseEceiveController new] animated:YES];
    }];
    
    [self.shoukkuanblock.mineName bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzBaseEceiveController new] animated:YES];
    }];
    
    
    [self.shoukkuanblock.view10 bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzOprationController new] animated:YES];
        
    }];
    
    [self.shoukkuanblock.view11 bk_whenTapped:^{
        xxzHideController * scriptController = [[xxzHideController alloc]init];
        scriptController.startString = self.shoukkuanblock.tuanduiLbl.text;
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];

    }];
    
    
    [self.shoukkuanblock.orderView bk_whenTapped:^{
        self.tabBarController.selectedIndex = 2;
    }];
    
    
    
    [self.shoukkuanblock.view1 bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzOprationController new] animated:YES];
    }];
    
    [self.shoukkuanblock.view2 bk_whenTapped:^{
        xxzHideController * scriptController = [[xxzHideController alloc]init];
        scriptController.startString = self.shoukkuanblock.tuanduiLbl.text;
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.view3 bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzEmptyRticleController new] animated:YES];
    }];
    
    [self.shoukkuanblock.view4 bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzOginEmptyController new] animated:YES];

    }];
    
    
    
    
    
    
    [self.shoukkuanblock.pingtaizhiduView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzSuppotController new] animated:YES];

        
    }];
    
    [self.shoukkuanblock.guanfangkefuView bk_whenTapped:^{
        [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                NSDictionary * oney= responseObject[@"data"];
                xxzConstXplainController * scriptController = [[xxzConstXplainController alloc]init];
                scriptController.navTitle = @"在线客服";
                scriptController.url = oney[@"serviceUrl"];
                [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
            }
        } failure:^(NSString * _Nonnull error) {

        }];


    }];
    
    [self.shoukkuanblock.zixunView bk_whenTapped:^{
        
        
        __weak typeof(self) weakSelf = self;


        [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/service/url" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                NSDictionary  * date = responseObject[@"data"];
            
     
                
                xxzOprationView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzOprationView class]) owner:nil options:nil] lastObject];
                
                [jihuajine.codeImv sd_setImageWithURL:[NSURL URLWithString:date[@"weixinCode"]]];
                
                
                LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                              popStyle:LSTPopStyleSpringFromTop
                                                          dismissStyle:LSTDismissStyleSmoothToTop];
                LSTPopViewWK(xplainView);
                    [jihuajine.closeBtn bk_whenTapped:^{
                        [wk_xplainView dismiss];
                    
                    }];
             
                [xplainView pop];

            }
        } failure:^(NSString * _Nonnull error) {
            
        }];
        
        
        
        

        
    }];
    
    [self.shoukkuanblock.bangzhuzhongxinView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzBaseEceiveController new] animated:YES];

    }];
    
    
    
    
    [self.shoukkuanblock.kapianguanliView bk_whenTapped:^{
        UIAlertController *font = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的帐号还未实名，是否立即去实名？" preferredStyle:UIAlertControllerStyleAlert];
        [font addAction:[UIAlertAction actionWithTitle:@"暂不实名" style:UIAlertActionStyleCancel handler:nil]];
        [font addAction:[UIAlertAction actionWithTitle:@"去实名" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            xxzSettingController *scriptController = [xxzSettingController new];
            [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
        }]];
        [self presentViewController:font animated:YES completion:nil];
    }];
    
    
    [self.shoukkuanblock.remenhuodongView bk_whenTapped:^{
        
        [self.xp_rootNavigationController pushViewController:[xxzListController new] animated:YES];

        
        
        
    }];
    
    [self.shoukkuanblock.yangkajigouView bk_whenTapped:^{
        UIAlertController *font = [UIAlertController alertControllerWithTitle:@"注销提示" message:@"注销账号后，将消除此账号所有数据和订单，具体请看官方政策协议，确认注销吗？" preferredStyle:UIAlertControllerStyleAlert];
        [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [font addAction:[UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showHUDAddedTo:[UIDevice currentWindow] animated:YES];

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:[UIDevice currentWindow] animated:YES];

                [xxzBase showBottomWithText:@"该账号存在已发货的订单，请收到货后再尝试注销"];
            });
        }]];
        [self presentViewController:font animated:YES completion:nil];
    }];
    
    [self.shoukkuanblock.shezhiView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzTouchController new] animated:YES];

        
    }];
}



@end
