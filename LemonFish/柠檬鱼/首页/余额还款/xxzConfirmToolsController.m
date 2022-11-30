
#import "xxzConfirmToolsController.h"
#import "xxzCenterView.h"
#import "xxzUnicodeCell.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzConfigNviteController.h"
#import "xxzLaunchController.h"
#import "xxzToolFootController.h"




@interface xxzConfirmToolsController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzCenterView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzConfirmToolsController


- (void)getChuxukaDef{
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/debit/card/def" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
         
        }else{
          
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

-(void)deleteXinyongka:(NSDictionary*)dic{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIAlertController *font = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [font addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
        if (self.empowerToken) {
            [pass setValue:self.empowerToken forKey:@"empowerToken"];
        }
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:[NSString stringWithFormat:@"/api/user/credit/card/delete/%@",dic[@"id"]] Params:pass success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] integerValue] == 0) {
                [xxzBase showBottomWithText:@"删除成功"];
                [self getPlanList];
            }
      
        } failure:^(NSString * _Nonnull error) {
            
        }];
    }]];
    [[UIViewController currentViewController] presentViewController:font animated:YES completion:^{}];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

-(void)createPlan:(xxzUnicodeCell * )cell startDic:(NSDictionary *)dic colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo{
    if (dic[@"balancePlan"]) {
        [xxzBase showBottomWithText:@"已有计划正在执行"];

        return;
    }
    UIAlertController *fontM = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [fontM addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [fontM addAction:[UIAlertAction actionWithTitle:@"智能创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        xxzConfigNviteController * scriptController = [[xxzConfigNviteController alloc]init];
        scriptController.startDic = dic;
        scriptController.whereCome = 1;
        scriptController.colorOne = colorOne;
        scriptController.colorTwo = colorTwo;
        scriptController.empowerToken = self.empowerToken;

        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
        
    }]];
    [fontM addAction:[UIAlertAction actionWithTitle:@"手动创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        xxzConfigNviteController * scriptController = [[xxzConfigNviteController alloc]init];
        scriptController.startDic = dic;
        scriptController.whereCome = 2;
        scriptController.colorOne = colorOne;
        scriptController.colorTwo = colorTwo;
        scriptController.empowerToken = self.empowerToken;

        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }]];
    [[UIViewController currentViewController] presentViewController:fontM animated:YES completion:^{}];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzUnicodeCell *yitixianCell = [xxzUnicodeCell cellWithTableView:tableView];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
 
    yitixianCell.xinyongkaNum.text = [UILabel splitSpace:date[@"cardNo"]];
    yitixianCell.xinyongkaName.text = date[@"bankName"];
    yitixianCell.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(date[@"bankAcronym"])];
    
    yitixianCell.zhangdanriLbl.text = [NSString stringWithFormat:@"%@",date[@"billDay"]];
    yitixianCell.hankanriLbl.text = [NSString stringWithFormat:@"%@",date[@"repaymentDay"]];
    yitixianCell.shengyushijianLbl.text = [NSString stringWithFormat:@"%@",date[@"remainingDay"]];
    
    UIView *confirmView = [[UIView alloc] init];
    confirmView.frame = CGRectMake(0,0,kScreenWidth-52,159);
   
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

   [yitixianCell.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,159) colorOne:yuliujin colorTwo:huxuka] atIndex:0];
    
    
    [self cellBlock:yitixianCell startDic:date colorOne:yuliujin colorTwo:huxuka ];
    return yitixianCell;
}




- (void)layoutTableView{
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight);
}

#pragma mark - QMUITableViewDataSource

- (xxzCenterView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzCenterView alloc] init];
        if (self.empowerToken) {
            _shoukkuanblock.empowerToken = self.empowerToken;

        }
    }
    return _shoukkuanblock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.tableHeaderView.height = 200;

        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzUnicodeCell" bundle:nil] forCellReuseIdentifier:@"xxzUnicodeCell"];
    [self getPlanList];
    
    __weak __typeof(self)weakSelf = self;
    self.mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getPlanList];

    }];

}


-(void)cellBlock:(xxzUnicodeCell * )cell startDic:(NSDictionary *)dic colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo{
    
    [cell.zhidingjihuaView rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        
        
        if (self.empowerToken) {
            [self getCardList:cell startDic:dic colorOne:colorOne colorTwo:colorTwo];
        }else{
            [self createPlan:cell startDic:dic colorOne:colorOne colorTwo:colorTwo];
        }
        
        
        
        
        
     
    }];
    
    
    [cell.qianyuetongdaoView rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [xxzBase showBottomWithText:@"正在升级中"];
    }];
    
    
    [cell.chakanjihuaView rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzLaunchController * scriptController3 = [[xxzLaunchController alloc]init];
        scriptController3.startDic = dic;
        scriptController3.colorOne = colorOne;
        scriptController3.colorTwo = colorTwo;
        scriptController3.empowerToken = self.empowerToken;

        [self.xp_rootNavigationController pushViewController:scriptController3 animated:YES];

    }];
    
    
    [cell.xiugaiziliaoView rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        xxzToolFootController * scriptController3 = [[xxzToolFootController alloc]init];
        scriptController3.startDic = dic;
        scriptController3.empowerToken = self.empowerToken;

        [self.xp_rootNavigationController pushViewController:scriptController3 animated:YES];
    }];
    
    
    [cell.xinyongkaChange rf_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self deleteXinyongka:dic];
    }];
}

- (void)getPlanList{
    NSMutableDictionary * passn= [[ NSMutableDictionary alloc]init];
    if (self.empowerToken) {
        [passn setValue:self.empowerToken forKey:@"empowerToken"];
    }
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/credit/get/balance/plan/list" Params:passn success:^(id  _Nonnull responseObject) {
        [self.mc_tableview.mj_header endRefreshing];
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

- (void)getCardList:(xxzUnicodeCell * )cell startDic:(NSDictionary *)dic colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo{
    NSMutableDictionary * passny= [[ NSMutableDictionary alloc]init];
     [passny setValue:self.empowerToken forKey:@"empowerToken"];
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/debit/card/list" Params:passny success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            if ([responseObject[@"data"] count] == 0) {
                [xxzBase showBottomWithText:@"系统检测到您未添加储蓄卡，请先在卡包界面添加储蓄卡！"];
            }else{
                [weakSelf createPlan:cell startDic:dic colorOne:colorOne colorTwo:colorTwo];
            }
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}

-(void)eventBlock{
    
    [self.shoukkuanblock.addBtn bk_whenTapped:^{
        xxzToolFootController * scriptController_ = [[xxzToolFootController alloc]init];
        scriptController_.empowerToken = self.empowerToken;
        scriptController_.userDic = self.userDic;
        [self.xp_rootNavigationController pushViewController:scriptController_ animated:YES];
    }];
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    
    [self eventBlock];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 280;
    
}
@end
