
#import "xxzLaunchController.h"
#import "xxzFriendsFriendsView.h"
#import "xxzVeryCell.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzConfigNviteController.h"
#import "xxzLayerController.h"

@interface xxzLaunchController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzFriendsFriendsView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzLaunchController


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 200;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * date = self.yitixianIndicator[indexPath.row];

    
    
    NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
    [pass setValue:[NSString stringWithFormat:@"%@",date[@"id"]] forKey:@"id"];
    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/get/plan/has/item" Params:pass success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            xxzLayerController * scriptController = [[xxzLayerController alloc]init];
            scriptController.startDic = responseObject[@"data"];
            scriptController.colorOne = self.colorOne;
            scriptController.colorTwo = self.colorTwo;
            scriptController.xinyongkaDic = self.startDic;
            scriptController.empowerToken = self.empowerToken;
            [self.navigationController pushViewController:scriptController animated:YES];
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
    
    
    


    
}

- (xxzFriendsFriendsView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzFriendsFriendsView alloc] init];
    }
    return _shoukkuanblock;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    [self getAllPlanList];
    
    [self eventBlock];
}




-(void)deleteXinyongka:(NSDictionary*)dic{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIAlertController *font = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定取消吗？" preferredStyle:UIAlertControllerStyleAlert];
    [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [font addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (!self.startDic[@"balancePlan"]) {
            return;
        }
        NSMutableDictionary * passh= [[ NSMutableDictionary alloc]init];
        [passh setValue:self.startDic[@"balancePlan"][@"id"] forKey:@"id"];
        if (self.empowerToken) {
            [passh setValue:self.empowerToken forKey:@"empowerToken"];
        }
        
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/plan/stop" Params:passh success:^(id  _Nonnull responseObject) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                [xxzBase showBottomWithText:@"计划取消成功"];
                [self.xp_rootNavigationController popViewControllerAnimated:YES];
            }else{
            
            }
        } failure:^(NSString * _Nonnull error) {
        }];
                
   
    }]];
    [[UIViewController currentViewController] presentViewController:font animated:YES completion:^{}];

}

#pragma mark - QMUITableViewDataSource

-(void)eventBlock{
    
    [self.shoukkuanblock.addBtn bk_whenTapped:^{
        xxzToolFootController * scriptControllerp = [[xxzToolFootController alloc]init];
        scriptControllerp.empowerToken = self.empowerToken;
        [self.xp_rootNavigationController pushViewController:scriptControllerp animated:YES];
    }];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.tableHeaderView.height = 64 + kStatusBarHeight;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzVeryCell" bundle:nil] forCellReuseIdentifier:@"xxzVeryCell"];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzVeryCell *yitixianCell = [xxzVeryCell cellWithTableView:tableView];
    NSDictionary * dateN = self.yitixianIndicator[indexPath.row];

    yitixianCell.xinyongkaNum.text = [UILabel splitSpace:self.startDic[@"cardNo"]];
    yitixianCell.xinyongkaName.text = dateN[@"bankName"];
    yitixianCell.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(self.startDic[@"bankAcronym"])];
    
    double progress = 150 * ([dateN[@"repaymentedAmount"] doubleValue] / [dateN[@"taskAmount"] doubleValue]);
    yitixianCell.processWidth.constant =  progress > 150 ? 150 : progress;
    NSString * one = [NSString stringWithFormat:@"%.f",([dateN[@"repaymentedAmount"] doubleValue] / [dateN[@"taskAmount"] doubleValue]) * 100];
    
    if ([dateN[@"status"] intValue] == 1) {
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"新建"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([dateN[@"status"] intValue] == 2){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"执行中"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([dateN[@"status"] intValue] == 3){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"已完成"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    else if([dateN[@"status"] intValue] == 4){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"还款失败"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([dateN[@"status"] intValue] == 5){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"取消中"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    else if([dateN[@"status"] intValue] == 6){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"已取消"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    else if([dateN[@"status"] intValue] == 7){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"取消失败"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([dateN[@"status"] intValue] == 8){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"执行完成"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    

    yitixianCell.jihuahuankuanLbl.text = [NSString stringWithFormat:@"%.2f",[dateN[@"taskAmount"] doubleValue]];
    yitixianCell.yihuanjineLbl.text = [NSString stringWithFormat:@"%.2f",[dateN[@"repaymentedAmount"] doubleValue]];

    UIView *confirmView = [[UIView alloc] init];
    confirmView.frame = CGRectMake(0,0,kScreenWidth-52,159);
   
  

   [yitixianCell.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,159) colorOne:self.colorOne colorTwo:self.colorTwo] atIndex:0];
    
    
    [self cellBlock:yitixianCell startDic:dateN colorOne:self.colorOne colorTwo:self.colorTwo ];
    return yitixianCell;
}

-(void)cellBlock:(xxzVeryCell * )cell startDic:(NSDictionary *)dic colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo{

    
    
    
    
    
    
    [cell.xinyongkaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self deleteXinyongka:dic];
    }];
}

- (void)getAllPlanList{
    NSMutableDictionary * passu= [[ NSMutableDictionary alloc]init];
    [passu setValue:self.startDic[@"cardNo"] forKey:@"cardNo"];
    if (self.empowerToken) {
        [passu setValue:self.empowerToken forKey:@"empowerToken"];
    }
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/credit/get/all/plan" Params:passu success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            self.yitixianIndicator = responseObject[@"data"];
            [self.mc_tableview reloadData];
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
@end
