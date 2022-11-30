
#import "xxzAbberOrgetController.h"
#import "xxzInsiInstitutionView.h"
#import "xxzXplainAlendarCell.h"
#import "xxzAddressController.h"
#import "xxzReateHangeController.h"

@interface xxzAbberOrgetController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzInsiInstitutionView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzAbberOrgetController


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 130;
    
}

- (xxzInsiInstitutionView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzInsiInstitutionView alloc] init];
    }
    return _shoukkuanblock;
}



- (void)chooseChannel{
    if ([self.nextblockSeconds isEqualToString:@""]) {
        return;
    }
    if ([self.hand isEqualToString:@""]) {
        return;
    }
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/payment/quick/choose/channel" Params:@{@"debitBankName":self.hand,@"bankName":self.nextblockSeconds} success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            self.yitixianIndicator = responseObject[@"data"];
            [self.mc_tableview reloadData];
        }else{

        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}


- (void)getChuxukaDef{
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/debit/card/def" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            self.chuxukaDic = responseObject[@"data"];
            self.shoukkuanblock.chuxukaImv.image = [UIImage imageNamed:@"danrixianeHexAllow"];
            self.shoukkuanblock.chuxukaNum.text = [UILabel splitSpace:responseObject[@"data"][@"cardNo"]];
            self.shoukkuanblock.chuxukaName.text = responseObject[@"data"][@"bankName"];
            self.shoukkuanblock.chuxukaIcon.image = [UIImage imageNamed:getBankLogo(responseObject[@"data"][@"bankAcronym"])];
            self.shoukkuanblock.chuxukaView.hidden = NO;
            self.hand =responseObject[@"data"][@"bankName"];
            [self chooseChannel];
        }else{
            self.shoukkuanblock.chuxukaView.hidden = YES;
            self.shoukkuanblock.chuxukaImv.image = [UIImage imageNamed:@"pdataImv"];
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

-(void)jumpPayConfirmVC:(NSDictionary *)dic{
    xxzAddressController * scriptController = [[xxzAddressController alloc]init];
    scriptController.startDic = dic;
    scriptController.chuxukaDic = self.chuxukaDic;
    scriptController.xinyongkaDic = self.xinyongkaDic;
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    
}

#pragma mark - QMUITableViewDataSource

- (void)getXinyongkaDef{
    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/credit/card/def" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            self.xinyongkaDic = responseObject[@"data"];
            self.shoukkuanblock.xinyongkaImv.image = [UIImage imageNamed:@"badgeZhengmian"];
            self.shoukkuanblock.xinyongkaNum.text = [UILabel splitSpace:responseObject[@"data"][@"cardNo"]];
            self.shoukkuanblock.xinyongkaName.text = responseObject[@"data"][@"bankName"];
            self.shoukkuanblock.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(responseObject[@"data"][@"bankAcronym"])];
            self.shoukkuanblock.xinyongkaView.hidden = NO;
            self.nextblockSeconds =responseObject[@"data"][@"bankName"];

            [self getChuxukaDef];
        }else{
            self.shoukkuanblock.xinyongkaView.hidden = YES;
            self.shoukkuanblock.xinyongkaImv.image = [UIImage imageNamed:@"touchTrackZaixiankefublock"];
            
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

-(void)jumpBindCardVC:(NSDictionary *)dic{
    xxzReateHangeController * scriptControllert = [[xxzReateHangeController alloc]init];
    scriptControllert.startDic = dic;
    scriptControllert.xinyongkaDic = self.xinyongkaDic;
    [self.xp_rootNavigationController pushViewController:scriptControllert animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzXplainAlendarCell *yitixianCell = [xxzXplainAlendarCell cellWithTableView:tableView];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    yitixianCell.channelTitle.text = date[@"alias"];
    yitixianCell.danbixianeLbl.text = [NSString stringWithFormat:@"%@-%@元",date[@"limitMin"],date[@"limitMax"]];
    yitixianCell.jiaoyishijianLbl.text = [NSString stringWithFormat:@"%@-%@",date[@"startTime"],date[@"endTime"]];
    yitixianCell.danrixianeLbl.text = [NSString stringWithFormat:@"%@元",date[@"dayMax"]];
    yitixianCell.jiaoyifeiLvLbl.text = [NSString stringWithFormat:@"%.2f%%-%.2f元",[date[@"costRate"] doubleValue] * 100,[date[@"costFee"] doubleValue]];
    yitixianCell.selectBtn.selected = NO;
    return yitixianCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.tableHeaderView.height = 416 + kStatusBarHeight;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzXplainAlendarCell" bundle:nil] forCellReuseIdentifier:@"xxzXplainAlendarCell"];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    [self getXinyongkaDef];
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    NSDictionary * datec = self.yitixianIndicator[indexPath.row];
    NSDictionary *huabeiblock = [self loadUserData];
    xxzXplainAlendarCell *yitixianCell5 = [tableView cellForRowAtIndexPath:indexPath];
    if (!yitixianCell5.selectBtn.isSelected) {
        yitixianCell5.selectBtn.selected = YES;
    }
    
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setValue:datec[@"id"] forKey:@"channelId"];
    [pass setValue:huabeiblock[@"username"] forKey:@"loginPhone"];
    [pass setValue:self.xinyongkaDic[@"bankName"] forKey:@"bankName"];
    [pass setValue:self.xinyongkaDic[@"cardNo"] forKey:@"bankCard"];
    [pass setValue:self.xinyongkaDic[@"phone"] forKey:@"bankPhone"];
    [pass setValue:self.xinyongkaDic[@"securityCode"] forKey:@"securityCode"];
    [pass setValue:self.xinyongkaDic[@"expiredTime"] forKey:@"expiredTime"];
    [pass setValue:self.xinyongkaDic[@"fullname"] forKey:@"userName"];
    [pass setValue:self.xinyongkaDic[@"idCard"] forKey:@"idCard"];
    [pass setValue:self.chuxukaDic[@"bankName"] forKey:@"debitBankName"];
    [pass setValue:self.chuxukaDic[@"cardNo"] forKey:@"debitBankCard"];
    [pass setValue:self.chuxukaDic[@"phone"] forKey:@"debitPhone"];

    
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/fast/verify/bindcard" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [weakSelf jumpPayConfirmVC:datec];
        }else if([responseObject[@"code"] intValue] == 3){
            [weakSelf jumpBindCardVC:datec];

        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    
    
    
    
    


    
    
    return;

    
}
@end
