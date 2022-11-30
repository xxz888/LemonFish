
#import "xxzFriendsProgressController.h"
#import "xxzUppotDetailView.h"
#import "xxzInyongkaView.h"
#import "xxzConstXplainController.h"

@interface xxzFriendsProgressController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) xxzUppotDetailView *shoukkuanblock;
@property (nonatomic, strong) NSString *baocun;

@property (nonatomic, strong) NSString *insiNews;
@property (nonatomic , strong) NSString *headerNick;
@property (nonatomic , strong) NSString *etworking;
@property (nonatomic , strong) NSDictionary * tishi;
@property(nonatomic, assign) BOOL e_min;


@end

@implementation xxzFriendsProgressController


-(void)fastApply{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];

    if([NSString isBlankString:self.shoukkuanblock.priceTf.text]){
        [xxzBase showBottomWithText:@"支付金额不能为空"];
        return;
    }
    

    

    
    
    [pass setValue:self.startDic[@"id"] forKey:@"channelId"];
    [pass setValue:self.shoukkuanblock.priceTf.text forKey:@"amount"];
    [pass setValue:self.xinyongkaDic[@"fullname"] forKey:@"userName"];
    [pass setValue:huabeiblock[@"idcard"] forKey:@"idCard"];
    [pass setValue:self.chuxukaDic[@"bankName"] forKey:@"debitBankName"];
    [pass setValue:self.chuxukaDic[@"cardNo"] forKey:@"debitBankCard"];
    [pass setValue:self.chuxukaDic[@"phone"] forKey:@"debitPhone"];

    
    
alipays://platformapi/startapp?appId=20000067&resultM=https://qr.alipay.com/bax09566l1lrrmbhxge33033

    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/huabei/cash" Params:pass success:^(id  _Nonnull responseObject) {
        weakSelf.tishi = responseObject[@"data"];
        weakSelf.e_min = YES;
        NSString * resultM = [NSString stringWithFormat:@"alipays://platformapi/startapp?appId=20000067&url=%@",weakSelf.tishi[@"qcodeUrl"]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:resultM] options:@{} completionHandler:^(BOOL success) { }];
        
        
        
        

    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
    
}

-(void)blockAction{
    
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.nextblock = ^{
        
        [weakSelf fastApply];
        
    };
    
    self.shoukkuanblock.sendCodeBlock = ^{
        [weakSelf fastApply];
    };
    
    
}

- (void)TheOrderStatus{
    @weakify(self);
    NSMutableDictionary *kehushu = [NSMutableDictionary dictionary];
    [kehushu setValue:self.startDic[@"id"] forKey:@"channelId"];
    [kehushu setValue:self.tishi[@"orderCode"] forKey:@"orderCode"];
    NSDictionary *huabeiblockU = [self loadUserData];
    [kehushu setValue:huabeiblockU[@"idcard"] forKey:@"idCard"];
    
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/huabei/cash/payment/query" Params:kehushu success:^(id  _Nonnull responseObject) {
        
        xxzInyongkaView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzInyongkaView class]) owner:nil options:nil] lastObject];
        
            if ([responseObject[@"code"] intValue] == 0) {
                jihuajine.tradingStatus.text = @"交易成功";
            }else if ([responseObject[@"code"] intValue] == 1){
                jihuajine.tradingStatus.text = @"交易失败";
            }else if ([responseObject[@"code"] intValue] == 3){
                jihuajine.tradingStatus.text = @"处理中";
            }
        
            jihuajine.tradingPrice.text = [NSString stringWithFormat:@"¥ %.2f",[weak_self.shoukkuanblock.priceTf.text doubleValue]];

            jihuajine.tradingAcc.text = [NSString stringWithFormat:@"%@ 尾号%@ %@",self.chuxukaDic[@"bankName"],[self.chuxukaDic[@"cardNo"] substringFromIndex:[self.chuxukaDic[@"cardNo"] length]-4],@"储蓄卡"];

            jihuajine.tradingTime.text = [NSString stringWithFormat:@"%@",[NSDate GetCurrentDateType:DateTypeYMDHms]];
        
        
        
        LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                      popStyle:LSTPopStyleSpringFromTop
                                                  dismissStyle:LSTDismissStyleSmoothToTop];
        LSTPopViewWK(xplainView);
            [jihuajine.backBtn bk_whenTapped:^{
                [wk_xplainView dismiss];
                [weak_self.xp_rootNavigationController popToRootViewControllerAnimated:YES];
            }];
        [jihuajine.sureBtn bk_whenTapped:^{
            [wk_xplainView dismiss];
            [weak_self.xp_rootNavigationController popToRootViewControllerAnimated:YES];
        }];
        
        [xplainView pop];
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

- (void)FbottomAction{
    
 
}

- (xxzUppotDetailView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzUppotDetailView alloc] init];
    }
    return _shoukkuanblock;
}
#pragma 确认刷卡接口
#pragma 查看订单状态

-(void)applicationWillEnterForegroundAction:(NSNotification *)tap{
    if (self.e_min) {
        if (self.tishi[@"orderCode"]) {
            [self TheOrderStatus];
        }
        self.e_min = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma 确定绑定

- (void)changeSendBtnText{

    __block NSInteger acc = 60;
    
    dispatch_queue_t tixianjine = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t sing = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, tixianjine);
    
    dispatch_source_set_timer(sing, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(sing, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (acc >= 0) {
                self.shoukkuanblock.sendBtn.userInteractionEnabled = NO;
                [self.shoukkuanblock.sendBtn setTitle:[NSString stringWithFormat:@"%lds", acc] forState:0];
                
                acc--;
                
                
            }else {
                self.shoukkuanblock.sendBtn.userInteractionEnabled = YES;
                dispatch_source_cancel(sing);
                [self.shoukkuanblock.sendBtn setTitle:@"重新发送" forState:0];

            }
            
        });
    });
    
    dispatch_resume(sing);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.shoukkuanblock.startDic = self.startDic;
    NSDictionary *huabeiblock3 = [self loadUserData];
    self.shoukkuanblock.phoneLbl.text = [NSString stringWithFormat:@"需验证您在银行预留手机号%@",self.xinyongkaDic[@"phone"]];

    if ([self.startDic[@"needCity"] integerValue] == 1) {
        self.shoukkuanblock.xiaofeidiqvView.hidden = NO;
        self.shoukkuanblock.middleHeight.constant = 250;
    }else{
        self.shoukkuanblock.middleHeight.constant = 200;
    }
    

       self.shoukkuanblock.codeView.hidden = YES;
       self.shoukkuanblock.codeViewHeight.constant = 0;
    
    self.shoukkuanblock.danbixianeLbl.text = [NSString stringWithFormat:@"%@-%@元",self.startDic[@"limitMin"],self.startDic[@"limitMax"]];
    self.shoukkuanblock.danrixianeLbl.text = [NSString stringWithFormat:@"%@元",self.startDic[@"dayMax"]];
    
    
    self.insiNews = @"";
    [self blockAction];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundAction:) name:@"applicationWillEnterForegroundAction" object:nil];

}




@end
