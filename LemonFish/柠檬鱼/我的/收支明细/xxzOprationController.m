
#import "xxzOprationController.h"
#import "xxzCodeView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"

#import "xxzTradingController.h"
#import "xxzErsonController.h"

@interface xxzOprationController ()
@property (nonatomic, strong) xxzCodeView *shoukkuanblock;

@end

@implementation xxzOprationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    


    
    [self.shoukkuanblock.view10 bk_whenTapped:^{
            
    }];
    
    [self.shoukkuanblock.view11 bk_whenTapped:^{
        [self.xp_rootNavigationController pushViewController:[xxzErsonController new] animated:YES];
    }];
    
    
    
    
    [self.shoukkuanblock.shoukuanyewuView bk_whenTapped:^{
        [self pushNextVC:@"收款业务奖励"];
    }];
    
    [self.shoukkuanblock.huankuanyewuView bk_whenTapped:^{
        [self pushNextVC:@"还款业务奖励"];
    }];
    
    [self.shoukkuanblock.shenqingbankaView bk_whenTapped:^{
        [self pushNextVC:@"申请办卡奖励"];
    }];
    
    [self.shoukkuanblock.ziyongfanxianView bk_whenTapped:^{
        [self pushNextVC:@"自用返现奖励"];

    }];
    
    
    
    
    
    
    [self.shoukkuanblock.huodongjiangliView bk_whenTapped:^{
        [self pushNextVC:@"活动奖励"];

    }];
    
    [self.shoukkuanblock.qitajiangliView bk_whenTapped:^{
        [self pushNextVC:@"其他奖励"];

    }];
 
    
    

}

- (xxzCodeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzCodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(void)getStatistics{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/income/statistics" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.shoukkuanblock.shouruLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"totalBalance"] doubleValue]];
            weakSelf.shoukkuanblock.yitixianLbl.text = [NSString stringWithFormat:@"%.2f元",[responseObject[@"data"][@"totalBalance"] doubleValue] - [responseObject[@"data"][@"currentBalance"] doubleValue]];
            weakSelf.shoukkuanblock.ketixianLbl.text = [NSString stringWithFormat:@"%.2f元",[responseObject[@"data"][@"currentBalance"] doubleValue]];

            
            
            weakSelf.shoukkuanblock.shoukuanyewuLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"fastIncome"] doubleValue]];
            weakSelf.shoukkuanblock.huankuanyewuLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"balanceIncome"] doubleValue]];
            weakSelf.shoukkuanblock.shenqingbankaLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"cardIncome"] doubleValue]];
            weakSelf.shoukkuanblock.ziyongfanxianLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"selfIncome"] doubleValue]];
       
            weakSelf.shoukkuanblock.huodongjiangliLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"activityIncome"] doubleValue]];
            weakSelf.shoukkuanblock.qitajiangliLbl.text = [NSString stringWithFormat:@"¥%.2f",[responseObject[@"data"][@"otherIncome"] doubleValue]];

        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    

    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getStatistics];
}

-(void)pushNextVC:(NSString *)title{
    xxzTradingController * scriptController = [[xxzTradingController alloc]init];
    scriptController.navTitle = title;
    scriptController.shouru = self.shoukkuanblock.shoukuanyewuLbl.text;
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
}



@end
