
#import "xxzErsonController.h"
#import "xxzSignEceiveView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"

#import "xxzTradingController.h"
#import "xxzNlineScreenView.h"
#import "xxzHeaderController.h"
@interface xxzErsonController ()
@property (nonatomic, strong) xxzSignEceiveView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * subOrget;
@property (nonatomic, strong) NSDictionary * shouxufeiCvn;
@property (nonatomic, strong) NSDictionary * outsideAnimate;
@property (nonatomic, strong) NSString * danbixiane;
@property (nonatomic, strong) NSString * type;

@end

@implementation xxzErsonController


-(void)setSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    line.hidden = NO;
    
}

-(void)getInfo{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];

    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/debit/card/def" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            self.subOrget = responseObject[@"data"];
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/alipay/list" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            if ([responseObject[@"data"] count] != 0) {
                self.shouxufeiCvn = responseObject[@"data"][0];
            }
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];

    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/income/statistics" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
              self.outsideAnimate = responseObject[@"data"];
            self.shoukkuanblock.zhanghuyueLbl.text = [NSString stringWithFormat:@"¥%.2f",[self.outsideAnimate[@"currentBalance"] doubleValue]];
            self.shoukkuanblock.leijishouruLbl.text = [NSString stringWithFormat:@"%.2f",[self.outsideAnimate[@"totalBalance"] doubleValue]];
            self.shoukkuanblock.yijiesuanLbl.text = [NSString stringWithFormat:@"%.2f",[self.outsideAnimate[@"totalBalance"] doubleValue] - [self.outsideAnimate[@"currentBalance"] doubleValue]];

        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
}


-(void)setUnSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    line.hidden = YES;
    
}


-(void)changeInfo:(NSDictionary *)dic{
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/upd/user/date" Params:dic success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
          
            [weakSelf getData];
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
}



- (xxzSignEceiveView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzSignEceiveView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    [self setSelectStatus:self.shoukkuanblock.zhifubaoBtn line:self.shoukkuanblock.zhifubaoLine];
    [self setUnSelectStatus:self.shoukkuanblock.yinhangkaBtn line:self.shoukkuanblock.yinhangkaLine];
    self.type = @"2";
    
    
    [self.shoukkuanblock.zhifubaoBtn bk_whenTapped:^{
        [self setSelectStatus:self.shoukkuanblock.zhifubaoBtn line:self.shoukkuanblock.zhifubaoLine];
        [self setUnSelectStatus:self.shoukkuanblock.yinhangkaBtn line:self.shoukkuanblock.yinhangkaLine];
        self.type = @"2";
    }];
    
    
    [self.shoukkuanblock.yinhangkaBtn bk_whenTapped:^{
        [self setSelectStatus:self.shoukkuanblock.yinhangkaBtn line:self.shoukkuanblock.yinhangkaLine];
        [self setUnSelectStatus:self.shoukkuanblock.zhifubaoBtn line:self.shoukkuanblock.zhifubaoLine];
        self.type = @"1";
    }];

    
    [self.shoukkuanblock.price100 bk_whenTapped:^{
        self.shoukkuanblock.tixianjineTf.text = @"100";
    }];
    [self.shoukkuanblock.price200 bk_whenTapped:^{
        self.shoukkuanblock.tixianjineTf.text = @"200";
    }];
    [self.shoukkuanblock.price500 bk_whenTapped:^{
        self.shoukkuanblock.tixianjineTf.text = @"500";
    }];
    [self.shoukkuanblock.price1000 bk_whenTapped:^{
        self.shoukkuanblock.tixianjineTf.text = @"1000";
    }];
    
    
    __weak typeof(self) weakSelf = self;
    [self.shoukkuanblock.lijitixianBtn bk_whenTapped:^{
        
        if ([self.shoukkuanblock.tixianjineTf.text doubleValue] == 0) {
            [xxzBase showBottomWithText:@"请输入提现金额"];
            return;
        }
        if ([self.type intValue] == 1) {
            if (!self.subOrget) {
                [xxzBase showBottomWithText:@"请添加储蓄卡"];
                xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
                scriptController.block = ^{
                    [weakSelf getInfo];
                };
                [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
                return;
            }
        }
        
        if ([self.type intValue] == 2) {
            if (!self.shouxufeiCvn) {
                [xxzBase showBottomWithText:@"请添加支付宝账号"];
                [self popAliPayAcc];
                return;
            }
        }
        
        
        
        NSString * btn = [self.type intValue] == 1 ? self.subOrget[@"cardNo"] : self.shouxufeiCvn[@"payId"];
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/payment/withdraw" Params:@{@"payId":btn,@"type":self.type,@"amount":self.shoukkuanblock.tixianjineTf.text} success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                [xxzBase showBottomWithText:responseObject[@"message"]];
                [self.xp_rootNavigationController popViewControllerAnimated:YES];
            
            }else{
            }
        } failure:^(NSString * _Nonnull error) {
            
        }];
    }];
}

-(void)popAliPayAcc{
    xxzNlineScreenView * jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzNlineScreenView class]) owner:nil options:nil] lastObject];
    __weak typeof(self) weakSelf = self;

    
    LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                  popStyle:LSTPopStyleSpringFromTop
                                              dismissStyle:LSTDismissStyleSmoothToTop];

    LSTPopViewWK(xplainView);
    [jihuajine.closeBtn bk_whenTapped:^{
        [wk_xplainView dismiss];
    }];
    
    
    
    [jihuajine.btnCopy bk_whenTapped:^{
        NSString * seconds = jihuajine.inputTf.text;

        if ([seconds isEqualToString:@""]) {
            [xxzBase showBottomWithText:@"请输入支付宝账号"];
            return;
        }
        [weakSelf changeInfo:@{@"payId":seconds}];
    }];




    [xplainView pop];
}

-(void)getData{
    
    __weak typeof(self) weakSelf = self;

    NSDictionary *huabeiblockG = [self loadUserData];

    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/user/data" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * date =  responseObject[@"data"];
  
            weakSelf.shouxufeiCvn = date;

        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}



@end
