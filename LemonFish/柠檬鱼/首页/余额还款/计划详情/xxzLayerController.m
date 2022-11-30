
#import "xxzLayerController.h"
#import "xxzImageRecordView.h"
#import "xxzHeaderCell.h"
#import "xxzOastFootView.h"
#import "xxzPackageInfoController.h"
#import "xxzConstExtensionView.h"

@interface xxzLayerController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzImageRecordView *shoukkuanblock;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic, strong) xxzOastFootView * titleview;
@property (nonatomic ,assign)CGFloat nav;
@end

@implementation xxzLayerController


- (void)layoutTableView
{
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    xxzConstExtensionView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzConstExtensionView class]) owner:nil options:nil] lastObject];

    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    if ([date[@"status"] intValue] == 4) {
        
        LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                      popStyle:LSTPopStyleSpringFromTop
                                                  dismissStyle:LSTDismissStyleSmoothToTop];
        LSTPopViewWK(xplainView)
        
        
        jihuajine.phone.text = date[@"phone"];
        jihuajine.time.text = date[@"executeTime"];
        jihuajine.reason.text = date[@"message"];
        [jihuajine.closeBtn bk_whenTapped:^{
            [wk_xplainView dismiss];
        }];
        
        
        [xplainView pop];
    }
  

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 80;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}


- (xxzImageRecordView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzImageRecordView alloc] init];
    }
    return _shoukkuanblock;
}



#pragma mark - QMUITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzHeaderCell *yitixianCell = [xxzHeaderCell cellWithTableView:tableView];

    NSDictionary * dates = self.yitixianIndicator[indexPath.row];
    
    
    if ([dates[@"type"] integerValue] == 1) {
        yitixianCell.cellIcon.image = [UIImage imageNamed:@"efreshTradingAli"];
        yitixianCell.cellPrice.textColor = [UIColor colorWithHexString:@"#FEA203"];
    }
    
    if ([dates[@"type"] integerValue] == 2) {
        yitixianCell.cellIcon.image = [UIImage imageNamed:@"nearestHandxuanzeshijian"];
        yitixianCell.cellPrice.textColor = [UIColor colorWithHexString:@"#2694FF"];
    }
    
    yitixianCell.cellPrice.text = [NSString stringWithFormat:@"%.2f",[dates[@"amount"] doubleValue]];
    yitixianCell.cellTitle.text = dates[@"description"];
    yitixianCell.cellTime.text = dates[@"executeTime"];

    
    
    if ([dates[@"status"] intValue] == 1) {
        yitixianCell.cellStatus.text = @"待执行";
    }
    else if ([dates[@"status"] intValue] == 2){
        yitixianCell.cellStatus.text = @"执行中";
    }
    else if ([dates[@"status"] intValue] == 3){
        yitixianCell.cellStatus.text = @"已成功";
    }
    else if ([dates[@"status"] intValue] == 4){
        yitixianCell.cellStatus.text = @"已失败";
    }else if ([dates[@"status"] intValue] == 5){
        yitixianCell.cellStatus.text = @"已取消";
    }
    return yitixianCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    

    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.layer.masksToBounds = YES;
    self.mc_tableview.layer.cornerRadius = 15;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzHeaderCell" bundle:nil] forCellReuseIdentifier:@"xxzHeaderCell"];
    
    self.shoukkuanblock.xinyongkaName.text = self.startDic[@"fullname"];
    self.shoukkuanblock.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(self.xinyongkaDic[@"bankAcronym"])];
    self.shoukkuanblock.xinyongkaNum.text = [NSString stringWithFormat:@"%@(尾号%@)",self.startDic[@"bankName"],[self.startDic[@"creditCardNumber"] substringFromIndex:[self.startDic[@"creditCardNumber"] length]-4]];
    self.shoukkuanblock.jihuahuankuanbishuLbl.text = [NSString stringWithFormat:@"%@",self.startDic[@"taskCount"]];
    self.shoukkuanblock.yuliujinLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"balance"] doubleValue]];
    self.shoukkuanblock.shouxufeiLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"totalServiceCharge"] doubleValue]];
    self.shoukkuanblock.huankuanjineLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"taskAmount"] doubleValue]];
    self.shoukkuanblock.shouxufeijianmianLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"cashBacking"] doubleValue]];
    self.yitixianIndicator = self.startDic[@"planItems"];
    self.shoukkuanblock.shouxufeijianmianLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"cashBacking"] doubleValue]];

    if ([self.yitixianIndicator count] > 0) {
        self.shoukkuanblock.huankuanriqiLbl.text = [NSString stringWithFormat:@"%@~%@",[self.yitixianIndicator[0][@"executeTime"] substringToIndex:10],[self.yitixianIndicator[[self.yitixianIndicator count]-1][@"executeTime"] substringToIndex:10]];
    }

    
    
    [self.shoukkuanblock.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,180) colorOne:self.colorOne colorTwo:self.colorTwo] atIndex:0];

    
    

    

    
    
    [self.mc_tableview reloadData];
    [self blockAction];
    
    
    if ([self.startDic[@"status"] integerValue] == 3 || [self.startDic[@"status"] integerValue] == 5 || [self.startDic[@"status"] integerValue] == 6 ) {
    
    }else{
            self.shoukkuanblock.shouxufeijianmianView.hidden = NO;
            self.titleview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzOastFootView class]) owner:nil options:nil] lastObject];
            [self.titleview.submitBtn setTitle:@"  终止计划" forState:UIControlStateNormal];
            self.mc_tableview.height = kScreenHeight-100;
            self.mc_tableview.tableHeaderView.height = 450;
            self.titleview.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
            [self.view addSubview:self.titleview];
          }
    
    
    
            [self.titleview.submitBtn bk_whenTapped:^{
                [self submitAction];
     }];
    self.shoukkuanblock.huankuanjineLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"repaymentedAmount"] doubleValue]];
    self.shoukkuanblock.jihuajineLbl.text = [NSString stringWithFormat:@"%.2f",[self.startDic[@"taskAmount"] doubleValue]];
    
    double progress = 150 * ([self.startDic[@"repaymentedAmount"] doubleValue] / [self.startDic[@"taskAmount"] doubleValue]);
    self.shoukkuanblock.processWidth.constant =  progress > 150 ? 150 : progress;
    NSString * oneV = [NSString stringWithFormat:@"%.f",([self.startDic[@"repaymentedAmount"] doubleValue] / [self.startDic[@"taskAmount"] doubleValue]) * 100];
    
    if ([self.startDic[@"status"] intValue] == 1) {
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"新建"];
    }
    else if([self.startDic[@"status"] intValue] == 2){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"执行中"];
    }
    else if([self.startDic[@"status"] intValue] == 3){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"已完成"];
    }
    else if([self.startDic[@"status"] intValue] == 4){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"还款失败"];
    }
    else if([self.startDic[@"status"] intValue] == 5){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"取消中"];
    }
    else if([self.startDic[@"status"] intValue] == 6){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"已取消"];
    }
    else if([self.startDic[@"status"] intValue] == 7){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"取消失败"];
    }
    else if([self.startDic[@"status"] intValue] == 8){
        self.shoukkuanblock.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",oneV,@"    ",@"执行完成"];
    }
    
    
    [self.shoukkuanblock.hejiView getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 30, 50) CornerRadius:15 UIRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight];
    
    
    self.shoukkuanblock.xiaofeiLbl.text = [NSString stringWithFormat:@"%.2f元",[self.startDic[@"consumeAmount"] doubleValue]];
    self.shoukkuanblock.huankuanLbl.text = [NSString stringWithFormat:@"%.2f元",[self.startDic[@"repaymentedAmount"] doubleValue]];
}


-(void)submitAction{
    
    NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
    [pass setValue:self.startDic[@"id"] forKey:@"id"];
        if (self.empowerToken) {
            [pass setValue:self.empowerToken forKey:@"empowerToken"];
        }
        
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/plan/stop" Params:pass success:^(id  _Nonnull responseObject) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                [xxzBase showBottomWithText:@"计划取消成功"];
                [self.xp_rootNavigationController popViewControllerAnimated:YES];
            }else{
            
            }
        } failure:^(NSString * _Nonnull error) {
        }];


    
}


-(void)blockAction{
}



@end
