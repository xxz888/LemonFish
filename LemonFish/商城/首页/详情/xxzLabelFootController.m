
#import "xxzLabelFootController.h"
#import "xxzOastView.h"
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
#import "xxzEnlargeController.h"

@interface xxzLabelFootController ()
@property (nonatomic, strong) xxzOastView *shoukkuanblock;

@end

@implementation xxzLabelFootController

- (xxzOastView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzOastView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;

    [self.shoukkuanblock.cellImv sd_setImageWithURL:self.startDic[@"pict_url"]];
    
    self.shoukkuanblock.cellTitle.text = self.startDic[@"tao_title"];
    
    self.shoukkuanblock.cellPrice.text = [NSString stringWithFormat:@"¥%.2f",[self.startDic[@"size"] doubleValue]];
    
    self.shoukkuanblock.cellKucun.text = [NSString stringWithFormat:@"库存:%@",self.startDic[@"sellCount"]];
    
    self.shoukkuanblock.cellAdress.text = self.startDic[@"provcity"];
    
    self.shoukkuanblock.cellCanshu.text = [NSString stringWithFormat:@"品牌:%@ 分类:%@",self.startDic[@"pinpai_name"],self.startDic[@"level_one_category_name"]];
    
    self.shoukkuanblock.cell1.text = self.startDic[@"coupon_info"];
    
    self.shoukkuanblock.cellContent.text = self.startDic[@"jianjie"];
    
    
    [self.shoukkuanblock.collectImv bk_whenTapped:^{
        [xxzBase showBottomWithText:@"收藏成功"];
    }];
    
    [self.shoukkuanblock.collectBuy bk_whenTapped:^{
        if (![self toLogin]) return;
        xxzEnlargeController * scriptController = [[xxzEnlargeController alloc]init];
        scriptController.startDic = self.startDic;
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}



@end
