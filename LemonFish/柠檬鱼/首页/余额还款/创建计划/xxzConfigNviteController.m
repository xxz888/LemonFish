
#import "xxzConfigNviteController.h"
#import "xxzBoutView.h"
#import "xxzUnicodeCell.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzDelegateController.h"
#import "xxzButtonListView.h"

@interface xxzConfigNviteController ()
@property (nonatomic, strong) xxzBoutView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;

@property (nonatomic, strong) NSMutableArray * defaultDays ;
@property (nonatomic, strong) NSMutableArray * origin ;

@property (nonatomic ,strong)NSString * upgradeDanrixiane;
@property (nonatomic ,strong)NSString * cityCode;

@property (nonatomic ,strong)NSString * selected;

@end

@implementation xxzConfigNviteController


- (void)singleDatesSelected{
    @weakify(self);
    
    xxzFriendsTouchView *priceView = [[xxzFriendsTouchView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,DEVICE_HEIGHT) minDay:1 isSingle:YES zhangdanri:[NSString stringWithFormat:@"%@",self.startDic[@"billDay"]] huankuanri:[NSString stringWithFormat:@"%@",self.startDic[@"repaymentDay"]]];
    priceView.isSingle = YES;
    
    [self.view addSubview:priceView];
    
    priceView.complete = ^(NSArray *result) {
        if (result) {
            weak_self.shoukkuanblock.jieshushijianTf.text = [NSDate getStringWithTimestamp:result[0] formatter:@"yyyy-MM-dd"];
        }
    };
}

-(void)handleCishu{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    xxzConfirmView *comeView = [[xxzConfirmView alloc]initWithDateStyle:DateStyleShowOtherString CompleteBlock:^(NSDate *Data, NSString *Str, id OtherString) {
        self.shoukkuanblock.huankuancishuTf.text = Str;
    }];
    NSMutableArray * modity = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 4; i++) {
        [modity addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    comeView.MyearArray = modity;
    comeView.yearLabelColor = [UIColor clearColor];
    [comeView show];
}

#pragma ========================= 所有请求 =========================

-(BOOL)judgeParames{
    if ([self.shoukkuanblock.zhangdanjineTf.text doubleValue] == 0) {
        [xxzBase showBottomWithText:self.shoukkuanblock.zhangdanjineTf.placeholder];
        return NO;
    }
    if ([self.shoukkuanblock.keyongyueTf.text doubleValue] == 0) {
        [xxzBase showBottomWithText:self.shoukkuanblock.keyongyueTf.placeholder];
        return NO;
    }
    return YES;
}

-(void)setUIAndData{
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
 
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.shoukkuanblock.xinyongkaNum.text = [UILabel splitSpace:self.startDic[@"cardNo"]];
    self.shoukkuanblock.xinyongkaName.text = self.startDic[@"bankName"];
    self.shoukkuanblock.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(self.startDic[@"bankAcronym"])];
    
    self.shoukkuanblock.zhangdanriLbl.text = [NSString stringWithFormat:@"%@",self.startDic[@"billDay"]];
    self.shoukkuanblock.hankanriLbl.text = [NSString stringWithFormat:@"%@",self.startDic[@"repaymentDay"]];
    self.shoukkuanblock.shengyushijianLbl.text = [NSString stringWithFormat:@"%@",self.startDic[@"remainingDay"]];
    
    self.origin = [[NSMutableArray alloc]init];
    self.defaultDays = [[NSMutableArray alloc]init];
    if (self.whereCome == 1) {
        self.shoukkuanblock.navTitle.text =  @"智能创建";
        self.shoukkuanblock.handCishuView.hidden = YES;
        self.shoukkuanblock.handxuanzeshijianView.hidden = YES;
        self.shoukkuanblock.autoJieshushijianView.hidden = NO;

        self.shoukkuanblock.stackViewHeight.constant = 240;
    }else{
        self.shoukkuanblock.navTitle.text =   @"手动创建";
        self.shoukkuanblock.handCishuView.hidden = NO;
        self.shoukkuanblock.handxuanzeshijianView.hidden = NO;
        self.shoukkuanblock.autoJieshushijianView.hidden = YES;
        self.shoukkuanblock.stackViewHeight.constant = 300;
    }

    
    UIView *confirmView = [[UIView alloc] init];
    confirmView.frame = CGRectMake(0,0,kScreenWidth-52,159);
    NSArray *trading = [NSArray arrayWithObjects:(id)self.colorOne.CGColor, (id)self.colorTwo.CGColor, nil];
   
   CAGradientLayer *two = [CAGradientLayer layer];
   two.frame = CGRectMake(0,0,kScreenWidth-52,159);
   two.startPoint = CGPointMake(0.74, 1);
   two.endPoint = CGPointMake(0.01, 0);
   two.colors = trading;
   two.locations = @[@(0), @(1.0f)];
   confirmView.layer.cornerRadius = 10;
   [confirmView.layer insertSublayer:two atIndex:-1];

   [self.shoukkuanblock.cardBackView insertSubview:confirmView atIndex:0];
}

-(void)autoCreatePlan{
    @weakify(self);
    if (![self judgeParames]) {
        return;
    }
    if ([self.shoukkuanblock.jieshushijianTf.text isEqualToString:@""]) {
        [xxzBase showBottomWithText:self.shoukkuanblock.jieshushijianTf.placeholder];
        return;
    }
    if ([self.shoukkuanblock.xuanzediqvTf.text isEqualToString:@""]) {
        [xxzBase showBottomWithText:self.shoukkuanblock.xuanzediqvTf.placeholder];
        return;
    }
    NSDictionary *huabeiblock = [self loadUserData];
    NSMutableDictionary * date = [[NSMutableDictionary alloc]init];
    
    [date setValue:self.shoukkuanblock.zhangdanjineTf.text forKey:@"amount"];
    [date setValue:self.shoukkuanblock.keyongyueTf.text forKey:@"reservedAmount"];
    [date setValue:self.shoukkuanblock.jieshushijianTf.text forKey:@"endDay"];
    [date setValue:self.upgradeDanrixiane forKey:@"provinceCode"];
    [date setValue:self.cityCode forKey:@"cityCode"];
    
    [date setValue:@(true) forKey:@"notPoint"];
    [date setValue:self.startDic[@"cardNo"] forKey:@"creditCardNumber"];
    [date setValue:huabeiblock[@"id"] forKey:@"userId"];
    [date setValue:brandId forKey:@"brandId"];
    [date setValue:@"2" forKey:@"dayRepaymentCount"];
    if (self.empowerToken) {
        [date setValue:self.empowerToken forKey:@"empowerToken"];
    }
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/credit/create/plan/new" Params:date success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            [weak_self pushNextVC:responseObject[@"data"]];
        }else{
          
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

- (xxzBoutView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzBoutView alloc] init];
    }
    return _shoukkuanblock;
}

-(void)pushNextVC:(NSDictionary *)dic{
    xxzDelegateController * scriptController = [[xxzDelegateController alloc]init];
    scriptController.startDic = dic;
    scriptController.colorOne = self.colorOne;
    scriptController.colorTwo = self.colorTwo;
    scriptController.xinyongkaDic = self.startDic;
    scriptController.empowerToken = self.empowerToken;
    [self.navigationController pushViewController:scriptController animated:YES];
}

- (void)getCardList{
    
    NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
     [pass setValue:self.empowerToken forKey:@"empowerToken"];
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/debit/card/list" Params:pass success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            if ([responseObject[@"data"] count] != 0) {
                [weakSelf popPlanView];
            }
        }else{
           
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

-(void)eventBlock{
    
    [self.shoukkuanblock.xuanzedeqvView bk_whenTapped:^{
        xxzLoginSettingView *nlineView = [[xxzLoginSettingView alloc]init];
        nlineView.Block = ^(NSDictionary *startDic, NSDictionary *endDic) {
            self.shoukkuanblock.xuanzediqvTf.text = [NSString stringWithFormat:@"%@-%@",startDic[@"name"],endDic[@"name"]];
            self.shoukkuanblock.xuanzediqvTf.hidden = NO;
            self.upgradeDanrixiane = startDic[@"id"];
            self.cityCode = endDic[@"id"];
        };
        [nlineView show];
    }];
        
    [self.shoukkuanblock.handCishuView bk_whenTapped:^{
        [self handleCishu];
    }];
    
    
    [self.shoukkuanblock.handxuanzeshijianView bk_whenTapped:^{
        
        [self multipleDatesSelected];
    }];
    
    
    [self.shoukkuanblock.autoJieshushijianView bk_whenTapped:^{
        
        [self singleDatesSelected];
    }];
        
    
    [self.shoukkuanblock.prePlanBtn bk_whenTapped:^{
        
        
        
        if (self.empowerToken) {
            [self getCardList];
        }else{
            [self popPlanView];
        }

 
        
    }];

}















































#pragma ========================= 设置其他属性和界面赋值 =========================

-(void)popPlanView{
    @weakify(self);

    xxzButtonListView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzButtonListView class]) owner:nil options:nil] lastObject];
    
    LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                  popStyle:LSTPopStyleSpringFromTop
                                              dismissStyle:LSTDismissStyleSmoothToTop];


    LSTPopViewWK(xplainView);
        [jihuajine.closeBtn bk_whenTapped:^{
            [wk_xplainView dismiss];
        }];

    [jihuajine.updateBtn bk_whenTapped:^{
        [wk_xplainView dismiss];
        weak_self.whereCome == 1 ? [weak_self autoCreatePlan] : [weak_self handleCreatePlan];

    }];

    [xplainView pop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUIAndData];
    [self eventBlock];
}

- (void)multipleDatesSelected{
    @weakify(self);

    if (![self judgeParames]) {
        return;
    }
    if ([self.shoukkuanblock.xuanzediqvTf.text isEqualToString:@""]) {
        [xxzBase showBottomWithText:self.shoukkuanblock.xuanzediqvTf.placeholder];
        return;
    }

    NSMutableDictionary * datev = [[NSMutableDictionary alloc]init];
    [datev setValue:self.startDic[@"cardNo"] forKey:@"creditCardNumber"];
    [datev setValue:self.shoukkuanblock.zhangdanjineTf.text forKey:@"amount"];
    [datev setValue:self.shoukkuanblock.keyongyueTf.text forKey:@"reservedAmount"];
    [datev setValue:@"2" forKey:@"dayRepaymentCount"];
    [datev setValue:self.upgradeDanrixiane forKey:@"provinceCode"];
    [datev setValue:self.cityCode forKey:@"cityCode"];
    [datev setValue:brandId forKey:@"brandId"];
    
    if (self.empowerToken) {
        [datev setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/credit/budget/day" Params:datev success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            
            xxzFriendsTouchView *priceViewH = [[xxzFriendsTouchView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,DEVICE_HEIGHT) minDay:[responseObject[@"data"] integerValue] isSingle:NO zhangdanri:[NSString stringWithFormat:@"%@",self.startDic[@"billDay"]] huankuanri:[NSString stringWithFormat:@"%@",self.startDic[@"repaymentDay"]]];

            priceViewH.isSingle = NO;
            if ([self.defaultDays count] != 0) {
                priceViewH.defaultDays = self.defaultDays;
            }
            [self.view addSubview:priceViewH];
                priceViewH.complete = ^(NSArray *result) {
                if (result) {
                    [weak_self.origin removeAllObjects];
                    [weak_self.defaultDays removeAllObjects];
                    for (int i = 0 ; i < result.count ; i++) {
                        [weak_self.defaultDays addObject:result[i]];
                        NSString * time = [NSDate getStringWithTimestamp:result[i] formatter:@"yyyy-MM-dd"];
                        [weak_self.origin addObject:time];
                    }
                    NSLog(@"%@",weak_self.origin);
                    weak_self.shoukkuanblock.xuanzeshjianTf.text = [NSString stringWithFormat:@"已选择%ld天",[result count]];
                }
            };
        }else{
          
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    

    
    
}


-(void)handleCreatePlan{
    @weakify(self);
    if (![self judgeParames]) {
        return;
    }
    if ([self.shoukkuanblock.xuanzediqvTf.text isEqualToString:@""]) {
        [xxzBase showBottomWithText:self.shoukkuanblock.xuanzediqvTf.placeholder];
        return;
    }
    if ([self.origin count] == 0) {
        [xxzBase showBottomWithText:self.shoukkuanblock.xuanzeshjianTf.placeholder];
        return;
    }

    NSDictionary *huabeiblockf = [self loadUserData];
    NSMutableDictionary * date6 = [[NSMutableDictionary alloc]init];
    
    [date6 setValue:self.shoukkuanblock.zhangdanjineTf.text forKey:@"amount"];
    [date6 setValue:self.shoukkuanblock.keyongyueTf.text forKey:@"reservedAmount"];
    [date6 setValue:self.origin forKey:@"executeDate"];
    [date6 setValue:self.upgradeDanrixiane forKey:@"provinceCode"];
    [date6 setValue:self.cityCode forKey:@"cityCode"];
    
    
    [date6 setValue:@(true) forKey:@"notPoint"];
    [date6 setValue:self.startDic[@"cardNo"] forKey:@"creditCardNumber"];
    [date6 setValue:huabeiblockf[@"id"] forKey:@"userId"];
    [date6 setValue:brandId forKey:@"brandId"];
    [date6 setValue:@"2" forKey:@"dayRepaymentCount"];
    
    if (self.empowerToken) {
        [date6 setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/credit/create/plan/new" Params:date6 success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [weak_self pushNextVC:responseObject[@"data"]];
        }else{
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

@end
