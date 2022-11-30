
#import "xxzDelegateController.h"
#import "xxzMainEgmentView.h"
#import "xxzPhoneCell.h"
#import "xxzNlineEditView.h"
#import "xxzPackageInfoController.h"
#import "xxzErsionController.h"
#import "xxzConfirmToolsController.h"
#import "xxzCardAddressController.h"
@interface xxzDelegateController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzMainEgmentView *shoukkuanblock;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic, strong) xxzNlineEditView * titleview;
@property (nonatomic ,assign)CGFloat nav;
@end

@implementation xxzDelegateController

-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month{
    NSDateComponents *eceive = [[NSDateComponents alloc] init];
    [eceive setMonth:month];
    NSCalendar *selected = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDate *reate = [selected dateByAddingComponents:eceive toDate:date options:0];
    return reate;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
  
    
}

-(void)postBandCard{
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
    [pass setValue:self.xinyongkaDic[@"cardNo"] forKey:@"cardNo"];
    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/verify/band/card" Params:pass success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            [weakSelf saveNewPlan];
        }else{
            
            if ([responseObject[@"code"] intValue] == 3){
                
                xxzPackageInfoController * scriptController = [[xxzPackageInfoController alloc]init];
                
                scriptController.singBlock = ^{
                    [weakSelf postBandCard];
                };
                
                scriptController.xinyongkaDic = weakSelf.xinyongkaDic;
                scriptController.colorOne = weakSelf.colorOne;
                scriptController.colorTwo = weakSelf.colorTwo;
                scriptController.startDic = weakSelf.startDic;
                scriptController.empowerToken = weakSelf.empowerToken;
                [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
            }
            
        }
    } failure:^(NSString * _Nonnull error) {
    }];
}

- (void)panduan{
    
    NSString *huankuanjine = self.yitixianIndicator[0][@"executeTime"];
    NSArray *inyongkaB = [huankuanjine componentsSeparatedByString:@" "];
    NSDate *close = [NSDate dateFromString:inyongkaB[0] WithFormat:@"yyyy-MM-dd"];
    
    NSString *n_layer = self.yitixianIndicator[self.yitixianIndicator.count-1][@"executeTime"];
    NSArray *nvite = [n_layer componentsSeparatedByString:@" "];
    NSDate *zhifubao = [NSDate dateFromString:nvite[0] WithFormat:@"yyyy-MM-dd"];
    
    NSDate *border = [NSDate date]; 
    NSDateFormatter *update_t = [[NSDateFormatter alloc] init];
    [update_t setDateFormat:@"yyyy-MM"];
    NSString *canshu = [update_t stringFromDate:border];
    
    NSString *magnification = self.xinyongkaDic[@"repaymentDay"];
    NSString *total = [NSString stringWithFormat:@"%@-%@",canshu,magnification];
    
    NSDate *agged = [NSDate dateFromString:total  WithFormat:@"yyyy-MM-dd"];
    
    NSDate *session = [self getPriousorLaterDateFromDate:agged withMonth:1];
    
    BOOL ucopy_c = [self date:agged isBetweenDate:close andDate:zhifubao];
    BOOL full = [self date:session isBetweenDate:close andDate:zhifubao];
    
    if(!ucopy_c && !full){
        [self postBandCard];
    }else{
        UIAlertController *font = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"还款计划的最后执行时间超过了银行卡的还款日，确定要继续吗？" preferredStyle:UIAlertControllerStyleAlert];
        [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [font addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self postBandCard];

        }]];
        [self presentViewController:font animated:YES completion:nil];
    }
}


-(void)submitAction{
    __weak typeof(self) weakSelf = self;
    
    if ([self.startDic[@"status"] integerValue] ==  1) {
        
        [self panduan];

        
  
    }else{
        NSMutableDictionary * passJ= [[ NSMutableDictionary alloc]init];
        [passJ setValue:self.startDic[@"id"] forKey:@"id"];
        if (self.empowerToken) {
            [passJ setValue:self.empowerToken forKey:@"empowerToken"];
        }
        
        
        
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/plan/stop" Params:passJ success:^(id  _Nonnull responseObject) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                [xxzBase showBottomWithText:@"计划取消成功"];
                [self.xp_rootNavigationController popViewControllerAnimated:YES];
            }else{
            
            }
        } failure:^(NSString * _Nonnull error) {
        }];
    }
    
  
    

    
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

-(void)saveNewPlan{
    
    NSMutableDictionary * passY= [[ NSMutableDictionary alloc]init];
    [passY setValue:self.xinyongkaDic[@"cardNo"] forKey:@"cardNo"];
    if (self.empowerToken) {
        [passY setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/save/new/plan" Params:passY success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            
            xxzCardAddressController * scriptControllerK = [[xxzCardAddressController alloc]init];
            if (self.empowerToken) {
                scriptControllerK.empowerToken = self.empowerToken;
            }
            [self.xp_rootNavigationController pushViewController:scriptControllerK animated:YES];
            
            
   
            
            
            
            
        }else{
       
        }
    } failure:^(NSString * _Nonnull error) {
    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.layer.masksToBounds = YES;
    self.mc_tableview.layer.cornerRadius = 15;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzPhoneCell" bundle:nil] forCellReuseIdentifier:@"xxzPhoneCell"];
    
    self.shoukkuanblock.xinyongkaName.text = self.startDic[@"fullname"];
    self.shoukkuanblock.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(self.xinyongkaDic[@"bankAcronym"])];
    self.shoukkuanblock.xinyongkaNum.text = [NSString stringWithFormat:@"%@(尾号%@)",self.startDic[@"bankName"],[self.startDic[@"creditCardNumber"] substringFromIndex:[self.startDic[@"creditCardNumber"] length]-4]];
    self.shoukkuanblock.jihuahuankuanbishuLbl.text = [NSString stringWithFormat:@"%@",self.startDic[@"taskCount"]];
    self.shoukkuanblock.yuliujinLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"balance"] doubleValue]];
    self.shoukkuanblock.shouxufeiLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"totalServiceCharge"] doubleValue]];
    self.shoukkuanblock.huankuanjineLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"taskAmount"] doubleValue]];
    self.yitixianIndicator = self.startDic[@"planItems"];

    if ([self.yitixianIndicator count] > 0) {
        self.shoukkuanblock.huankuanriqiLbl.text = [NSString stringWithFormat:@"%@~%@",[self.yitixianIndicator[0][@"executeTime"] substringToIndex:10],[self.yitixianIndicator[[self.yitixianIndicator count]-1][@"executeTime"] substringToIndex:10]];
    }

    
    
    [self.shoukkuanblock.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,80) colorOne:self.colorOne colorTwo:self.colorTwo] atIndex:0];

    
    
   
    
    [self.mc_tableview reloadData];
    [self blockAction];
    
    
    if ([self.startDic[@"status"] integerValue] == 3 || [self.startDic[@"status"] integerValue] == 5 || [self.startDic[@"status"] integerValue] == 6 ) {
    }else{
            ;
        
        
        
        
        self.shoukkuanblock.shouxufeijianmianView.hidden = YES;
        self.titleview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzNlineEditView class]) owner:nil options:nil] lastObject];
        [self layoutTableView];
        self.mc_tableview.tableHeaderView.height = 420;

        [self.titleview.submitBtn setTitle:@"  启动计划" forState:UIControlStateNormal];
        self.titleview.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
        [self.view addSubview:self.titleview];
        
    }
    
    
    [self.titleview.submitBtn bk_whenTapped:^{
        [self submitAction];
    }];
    
 

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    
}

- (xxzMainEgmentView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzMainEgmentView alloc] init];
    }
    return _shoukkuanblock;
}
#pragma 判断某一日期是否在一日期区间

-(void)layoutTableView{
    self.mc_tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-100);

}


#pragma mark - QMUITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzPhoneCell *yitixianCell = [xxzPhoneCell cellWithTableView:tableView];

    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    
    
    if ([date[@"type"] integerValue] == 1) {
        yitixianCell.cellIcon.image = [UIImage imageNamed:@"efreshTradingAli"];
        yitixianCell.cellPrice.textColor = [UIColor colorWithHexString:@"#FEA203"];
    }
    
    if ([date[@"type"] integerValue] == 2) {
        yitixianCell.cellIcon.image = [UIImage imageNamed:@"nearestHandxuanzeshijian"];
        yitixianCell.cellPrice.textColor = [UIColor colorWithHexString:@"#2694FF"];
    }
    
    yitixianCell.cellPrice.text = [NSString stringWithFormat:@"%.2f",[date[@"amount"] doubleValue]];
    yitixianCell.cellTitle.text = date[@"description"];
    yitixianCell.cellTime.text = date[@"executeTime"];

    
    if (indexPath.row == 0) {
        [yitixianCell.cellDiv getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 32 , 150) CornerRadius:15 UIRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight];
    }
    
    if (indexPath.row == [self.yitixianIndicator count] -1) {
        [yitixianCell.cellDiv getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 32, 150) CornerRadius:15 UIRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight];

    }
    return yitixianCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 80;
    
}


-(void)blockAction{
}


- (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate{
    if ([date compare:beginDate] == NSOrderedAscending) {
        return NO;
    }
    if ([date compare:endDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}



@end
