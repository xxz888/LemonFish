
#import "xxzHeaderEnlargeController.h"
#import "xxzEditTitleView.h"
#import "xxzEfreshCell.h"
#import "xxzFriendsProgressController.h"
#import "xxzReateHangeController.h"

@interface xxzHeaderEnlargeController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzEditTitleView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzHeaderEnlargeController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    [self getChuxukaDef];
 
}

- (xxzEditTitleView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzEditTitleView alloc] init];
    }
    return _shoukkuanblock;
}



-(void)jumpPayConfirmVC:(NSDictionary *)dic{
    xxzFriendsProgressController * scriptController = [[xxzFriendsProgressController alloc]init];
    scriptController.startDic = dic;
    scriptController.chuxukaDic = self.chuxukaDic;
    scriptController.xinyongkaDic = self.xinyongkaDic;
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    
}



-(void)jumpBindCardVC:(NSDictionary *)dic{
    xxzReateHangeController * scriptControllerP = [[xxzReateHangeController alloc]init];
    scriptControllerP.startDic = dic;
    scriptControllerP.xinyongkaDic = self.xinyongkaDic;
    [self.xp_rootNavigationController pushViewController:scriptControllerP animated:YES];
}

- (void)chooseChannel{
    if ([self.nextblockSeconds isEqualToString:@""]) {
        return;
    }
    if ([self.hand isEqualToString:@""]) {
        return;
    }
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/payment/huabei/choose/channel" Params:@{@"debitBankName":self.hand} success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            self.yitixianIndicator = responseObject[@"data"];
            [self.mc_tableview reloadData];
        }else{


        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

#pragma mark - QMUITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzEfreshCell *yitixianCell = [xxzEfreshCell cellWithTableView:tableView];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    yitixianCell.channelTitle.text = date[@"alias"];
    yitixianCell.danbixianeLbl.text = [NSString stringWithFormat:@"%@-%@元",date[@"limitMin"],date[@"limitMax"]];
    yitixianCell.jiaoyishijianLbl.text = [NSString stringWithFormat:@"%@-%@",date[@"startTime"],date[@"endTime"]];
    yitixianCell.danrixianeLbl.text = [NSString stringWithFormat:@"%@元",date[@"dayMax"]];
    yitixianCell.jiaoyifeiLvLbl.text = [NSString stringWithFormat:@"%.2f%%-%.2f元",[date[@"costRate"] doubleValue] * 100,[date[@"costFee"] doubleValue]];
    yitixianCell.selectBtn.selected = NO;
    return yitixianCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    __weak typeof(self) weakSelf = self;
    NSDictionary * datej = self.yitixianIndicator[indexPath.row];
    NSDictionary *huabeiblock = [self loadUserData];
    xxzEfreshCell *yitixianCell3 = [tableView cellForRowAtIndexPath:indexPath];
    if (!yitixianCell3.selectBtn.isSelected) {
        yitixianCell3.selectBtn.selected = YES;
    }


    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setValue:datej[@"id"] forKey:@"channelId"];
    [pass setValue:huabeiblock[@"username"] forKey:@"loginPhone"];
    
    [pass setValue:@"" forKey:@"bankName"];
    [pass setValue:@"" forKey:@"bankCard"];
    [pass setValue:@"" forKey:@"bankPhone"];
    [pass setValue:@"" forKey:@"securityCode"];
    [pass setValue:@"" forKey:@"expiredTime"];
    
    [pass setValue:huabeiblock[@"fullname"] forKey:@"userName"];
    [pass setValue:huabeiblock[@"idcard"] forKey:@"idCard"];
    [pass setValue:self.chuxukaDic[@"bankName"] forKey:@"debitBankName"];
    [pass setValue:self.chuxukaDic[@"cardNo"] forKey:@"debitBankCard"];
    [pass setValue:self.chuxukaDic[@"phone"] forKey:@"debitPhone"];


    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/fast/verify/bindcard" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [weakSelf jumpPayConfirmVC:datej];
        }else if([responseObject[@"code"] intValue] == 3){
            [weakSelf jumpBindCardVC:datej];


        }
    } failure:^(NSString * _Nonnull error) {

    }];

    
    
    
    



    
    
    return;

    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzEfreshCell" bundle:nil] forCellReuseIdentifier:@"xxzEfreshCell"];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 130;
    
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
@end
