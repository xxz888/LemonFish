
#import "xxzHuxukaGoodsController.h"
#import "xxzArnerView.h"


@interface xxzHuxukaGoodsController ()
@property (nonatomic, strong) xxzArnerView *shoukkuanblock;

@end

@implementation xxzHuxukaGoodsController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    [self getQuickOrder];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;

}



- (void)getQuickOrder{


    [self NetWorkingPostWithURL:self hiddenHUD:YES url:[NSString stringWithFormat:@"/api/payment/quick/order/%@",self.startDic[@"id"]] Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * date = responseObject[@"data"];
         
            self.shoukkuanblock.shoukuanrenLbl.text = date[@"username"];
            self.shoukkuanblock.shoujihaoLbl.text = date[@"debitBankPhone"];
            self.shoukkuanblock.dingdanhaoLbl.text = date[@"orderCode"];
            self.shoukkuanblock.jiaoyishijianLbl.text = date[@"createTime"];
            self.shoukkuanblock.xinyongkaLbl.text = date[@"bankCard"];
            self.shoukkuanblock.chuxukaLbl.text = date[@"debitBankCard"];
            self.shoukkuanblock.jiaoyijineLbl.text = [NSString stringWithFormat:@"¥%.2f",[date[@"amount"] doubleValue]];
            self.shoukkuanblock.daozhangjineLbl.text = [NSString stringWithFormat:@"¥%.2f",[date[@"realAmount"] doubleValue]];
       
            if ([date[@"orderStatus"] intValue] == 0) {
                self.shoukkuanblock.dingdanzhuangkuangLbl.text = @"交易中";
                self.shoukkuanblock.dingdanzhuangkuangLbl.textColor = [UIColor colorWithHexString:@"#FEA203"];
                self.shoukkuanblock.logoImv.image =  [UIImage imageNamed:@"size_dBackgroundCanshu"];

            }else if([date[@"orderStatus"] intValue] == 1){
                self.shoukkuanblock.dingdanzhuangkuangLbl.text = @"已成功";
                self.shoukkuanblock.logoImv.image =  [UIImage imageNamed:@"unicodeStatusHeader"];
                self.shoukkuanblock.dingdanzhuangkuangLbl.textColor = [UIColor colorWithHexString:@"#00B0C1"] ;
            }else if([date[@"orderStatus"] intValue] == 2){
                self.shoukkuanblock.dingdanzhuangkuangLbl.text = @"已失败";
                self.shoukkuanblock.dingdanzhuangkuangLbl.textColor = [UIColor colorWithHexString:@"#FEA203"];
                self.shoukkuanblock.logoImv.image =  [UIImage imageNamed:@"size_dBackgroundCanshu"];

            }
            self.shoukkuanblock.titlePricelbl.text = [NSString stringWithFormat:@"+%.2f",[date[@"realAmount"] doubleValue]];
            self.shoukkuanblock.cardNumLbl.text = date[@"bankCard"];
        }else{
            
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}



- (xxzArnerView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzArnerView alloc] init];
    }
    return _shoukkuanblock;
}

@end
