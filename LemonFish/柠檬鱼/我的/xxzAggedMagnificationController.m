
#import "xxzAggedMagnificationController.h"
#import "xxzUpdateNavigationView.h"
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
#import "xxzAbberController.h"
#import "xxzHomeConfigController.h"
#import "xxzPlanController.h"


@interface xxzAggedMagnificationController ()
@property (nonatomic, strong) xxzUpdateNavigationView *shoukkuanblock;

@end

@implementation xxzAggedMagnificationController


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
            
            NSString * i_count = @"";
            if ([responseObject[@"data"][@"selfLevel"] intValue] == 0) {
                i_count = @"请先实名";
                weakSelf.shoukkuanblock.mineName.text = [NSString stringWithFormat:@"%@",i_count];

            }else{
                if (responseObject[@"data"][@"nick"]) {
                    i_count = responseObject[@"data"][@"nick"];
                }else{
                    i_count = responseObject[@"data"][@"fullname"];
                }
                weakSelf.shoukkuanblock.mineName.text = [NSString stringWithFormat:@"Hi~,%@",i_count];

            }
            
            

            weakSelf.shoukkuanblock.mineDengji.text = @"会员";
            
            
            
            
            
            if (responseObject[@"data"][@"avatar"]) {
                [weakSelf.shoukkuanblock.mineIcon sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"avatar"]] forState:0 placeholderImage:nil];
            }
        }
 
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (xxzUpdateNavigationView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzUpdateNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
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
        [self.xp_rootNavigationController pushViewController:[xxzOneyMainController new] animated:YES];

        
    }];
    
    [self.shoukkuanblock.guanfangkefuView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzProgressController new] animated:YES];

    }];
    
    [self.shoukkuanblock.zixunView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzAbberController new] animated:YES];
    }];
    
    [self.shoukkuanblock.bangzhuzhongxinView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzHomeConfigController new] animated:YES];

    }];
    
    
    
    
    [self.shoukkuanblock.kapianguanliView bk_whenTapped:^{
        xxzBoutRticlesController * scriptController = [[xxzBoutRticlesController alloc]init];
        scriptController.isChangeCome = NO;
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    
    [self.shoukkuanblock.remenhuodongView bk_whenTapped:^{
        ShengJi
    }];
    
    [self.shoukkuanblock.yangkajigouView bk_whenTapped:^{
        
        [self.xp_rootNavigationController pushViewController:[xxzPlanController new] animated:YES];

    }];
    
    [self.shoukkuanblock.shezhiView bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzTouchController new] animated:YES];

        
    }];
}



@end
