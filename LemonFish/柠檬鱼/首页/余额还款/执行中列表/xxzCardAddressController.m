
#import "xxzCardAddressController.h"
#import "xxzConfigGoodsView.h"
#import "xxzVeryCell.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzConfigNviteController.h"
#import "xxzLayerController.h"

@interface xxzCardAddressController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzConfigGoodsView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzCardAddressController


-(void)cellBlock:(xxzVeryCell * )cell startDic:(NSDictionary *)dic colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo{

    
    
    
    
    
    
    [cell.xinyongkaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self deleteXinyongka:dic];
    }];
}


- (xxzConfigGoodsView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzConfigGoodsView alloc] init];
    }
    return _shoukkuanblock;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 200;
    
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




- (void)getAllPlanList{
    NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
  
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/credit/balance/plan/run/list" Params:pass success:^(id  _Nonnull responseObject) {
        
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

#pragma mark - QMUITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzVeryCell *yitixianCell = [xxzVeryCell cellWithTableView:tableView];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];

    
    
    UIColor * yuliujin ;
    UIColor * huxuka ;
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9 || indexPath.row == 12 ) {
    
        yuliujin = [UIColor colorWithRed:81.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
        huxuka = [UIColor colorWithRed:80/255.0 green:149/255.0 blue:254/255.0 alpha:1.0];
    }else if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 10 || indexPath.row == 13 ) {
        yuliujin = [UIColor colorWithRed:255.0/255.0 green:93.0/255.0 blue:97.0/255.0 alpha:1.0];
        huxuka = [UIColor colorWithRed:255/255.0 green:140/255.0 blue:137/255.0 alpha:1.0];
    }else{
        yuliujin = [UIColor colorWithRed:0/255.0 green:176/255.0 blue:193/255.0 alpha:1.0];
        huxuka = [UIColor colorWithRed:58/255.0 green:213/255.0 blue:226/255.0 alpha:1.0];
    }

    
    
    
    yitixianCell.xinyongkaNum.text = [UILabel splitSpace:date[@"cardNo"]];
    yitixianCell.xinyongkaName.text = date[@"bankName"];
    yitixianCell.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(date[@"bankAcronym"])];
    
    double progress = 150 * ([date[@"balancePlan"][@"repaymentedAmount"] doubleValue] / [date[@"balancePlan"][@"taskAmount"] doubleValue]);
    yitixianCell.processWidth.constant =  progress > 150 ? 150 : progress;
    NSString * one = [NSString stringWithFormat:@"%.f",([date[@"balancePlan"][@"repaymentedAmount"] doubleValue] / [date[@"balancePlan"][@"taskAmount"] doubleValue]) * 100];
    
    if ([date[@"balancePlan"][@"status"] intValue] == 1) {
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"新建"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 2){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"执行中"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 3){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"已完成"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 4){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"还款失败"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 5){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"取消中"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 6){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"已取消"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 7){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"取消失败"];
        yitixianCell.xinyongkaChange.hidden = NO;
    }
    else if([date[@"balancePlan"][@"status"] intValue] == 8){
        yitixianCell.processLbl.text = [NSString stringWithFormat:@"%@%%%@%@",one,@"    ",@"执行完成"];
        yitixianCell.xinyongkaChange.hidden = YES;
    }
    

    yitixianCell.jihuahuankuanLbl.text = [NSString stringWithFormat:@"%.2f",[date[@"balancePlan"][@"taskAmount"] doubleValue]];
    yitixianCell.yihuanjineLbl.text = [NSString stringWithFormat:@"%.2f",[date[@"balancePlan"][@"repaymentedAmount"] doubleValue]];

    UIView *confirmView = [[UIView alloc] init];
    confirmView.frame = CGRectMake(0,0,kScreenWidth-52,159);
   
  

   [yitixianCell.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,159) colorOne:yuliujin colorTwo:huxuka] atIndex:0];
    
    
    [self cellBlock:yitixianCell startDic:date colorOne:yuliujin colorTwo:huxuka ];
    return yitixianCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dateS = self.yitixianIndicator[indexPath.row];
    UIColor * yuliujin2 ;
    UIColor * huxukaF ;
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9 || indexPath.row == 12 ) {
    
        yuliujin2 = [UIColor colorWithRed:81.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
        huxukaF = [UIColor colorWithRed:80/255.0 green:149/255.0 blue:254/255.0 alpha:1.0];
    }else if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 10 || indexPath.row == 13 ) {
        yuliujin2 = [UIColor colorWithRed:255.0/255.0 green:93.0/255.0 blue:97.0/255.0 alpha:1.0];
        huxukaF = [UIColor colorWithRed:255/255.0 green:140/255.0 blue:137/255.0 alpha:1.0];
    }else{
        yuliujin2 = [UIColor colorWithRed:0/255.0 green:176/255.0 blue:193/255.0 alpha:1.0];
        huxukaF = [UIColor colorWithRed:58/255.0 green:213/255.0 blue:226/255.0 alpha:1.0];
    }
    NSMutableDictionary * passX= [[ NSMutableDictionary alloc]initWithDictionary:@{@"id":[NSString stringWithFormat:@"%@",dateS[@"balancePlan"][@"id"]]}];
    if (self.empowerToken) {
        [passX setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/get/plan/has/item" Params:passX success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            xxzLayerController * scriptController = [[xxzLayerController alloc]init];
            scriptController.startDic = responseObject[@"data"];
            scriptController.colorOne = yuliujin2;
            scriptController.colorTwo = huxukaF;
            scriptController.xinyongkaDic = dateS;
            [self.navigationController pushViewController:scriptController animated:YES];
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
    
    
    


    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

-(void)deleteXinyongka:(NSDictionary*)dic{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIAlertController *font = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定取消吗？" preferredStyle:UIAlertControllerStyleAlert];
    [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [font addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (!dic[@"balancePlan"]) {
            return;
        }
        
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/credit/plan/stop" Params:@{@"id":dic[@"balancePlan"][@"id"]} success:^(id  _Nonnull responseObject) {
            
            if ([responseObject[@"code"] intValue] == 0) {
                [xxzBase showBottomWithText:@"计划取消成功"];
                [self getAllPlanList];
            }else{
            
            }
        } failure:^(NSString * _Nonnull error) {
        }];
                
   
    }]];
    [[UIViewController currentViewController] presentViewController:font animated:YES completion:^{}];

}

-(void)eventBlock{
    
    [self.shoukkuanblock.addBtn bk_whenTapped:^{
        xxzToolFootController * scriptControllere = [[xxzToolFootController alloc]init];
        [self.xp_rootNavigationController pushViewController:scriptControllere animated:YES];
    }];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    [self getAllPlanList];
    
    [self eventBlock];
}
@end
