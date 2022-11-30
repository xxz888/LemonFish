
#import "xxzEnlargeController.h"
#import "xxzEnlargeView.h"
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
#import "xxzPackageController.h"

@interface xxzEnlargeController ()
@property (nonatomic, strong) xxzEnlargeView *shoukkuanblock;

@end

@implementation xxzEnlargeController

- (xxzEnlargeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzEnlargeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;

    [self.shoukkuanblock.cellImv sd_setImageWithURL:self.startDic[@"pict_url"]];
    
    self.shoukkuanblock.cellTitle.text = self.startDic[@"tao_title"];
    self.shoukkuanblock.adressView1.hidden = YES;
    self.shoukkuanblock.cellPrice.text = [NSString stringWithFormat:@"¥%.2f",[self.startDic[@"size"] doubleValue]];
    self.shoukkuanblock.cellPrice1.text = [NSString stringWithFormat:@"¥%.2f",[self.startDic[@"size"] doubleValue]];
    self.shoukkuanblock.cellPrice2.text = [NSString stringWithFormat:@"¥%.2f",[self.startDic[@"size"] doubleValue]];

    self.shoukkuanblock.cellKucun.text = [NSString stringWithFormat:@"  库存:%@",self.startDic[@"sellCount"]];
    
    
    self.shoukkuanblock.cellCanshu.text = self.startDic[@"coupon_info"];
    
    
    [self.shoukkuanblock.cellNoAdress bk_whenTapped:^{
        xxzPackageController * scriptController = [[xxzPackageController alloc]init];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
        
        
        scriptController.block = ^(NSDictionary * dic) {
            self.shoukkuanblock.adressView1.hidden = NO;
            self.shoukkuanblock.phoneLbl.text = dic[@"phone"];
            self.shoukkuanblock.nameLbl.text = dic[@"name"];
            self.shoukkuanblock.adressLbl.text = [NSString stringWithFormat:@"%@ %@",dic[@"provice"],dic[@"adress"]];
        };
    }];
    
  
    
    [self.shoukkuanblock.payLabel bk_whenTapped:^{
        if (self.shoukkuanblock.adressView1.hidden) {
            [xxzBase showBottomWithText:@"请填写收货地址"];
            return;
        }
        [self Show];
        
      
            NSMutableDictionary *date = [NSMutableDictionary dictionary];
            [date setObject:[NSString stringWithFormat:@"%.2f",[date[@"size"] doubleValue]] forKey:@"amount"];
            [date setObject:@"0" forKey:@"type"];

            [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/payment/invest/shop/temp" Params:date success:^(id  _Nonnull responseObject) {
                if ([responseObject[@"code"] intValue] == 0) {
                    
                    
                    NSString *showed = @"LFAlipay";
                    
                    NSString *move = responseObject[@"data"];
                    
                    [[AlipaySDK defaultService] payOrder:move fromScheme:showed callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                        if([resultDic[@"resultStatus"] integerValue] == 4000){
                            [xxzBase showBottomWithText:@"调取支付宝支付失败，请检查是否安装支付宝"];
                        }
                    }];
                }
            } failure:^(NSString * _Nonnull error) {

            }];


        
    }];

    
    
}

- (void)dismiss{
    [MBProgressHUD hideHUDForView:[UIDevice currentWindow] animated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}


- (void)Show{
    [MBProgressHUD showHUDAddedTo:[UIDevice currentWindow] animated:YES];
}



@end
