
#import "xxzPlanController.h"
#import "xxzInstitutionExtensionView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"
#import "xxzSizeButtonCell.h"
#import "xxzVeryController.h"
#import "xxzSizeCategoryView.h"

#import "xxzTradingController.h"

#import "xxzSettingController.h"
#import "xxzErsionController.h"
#import "xxzStyleServerView.h"
#import "xxzCodeVeryController.h"
@interface xxzPlanController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzInstitutionExtensionView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * subOrget;
@property (nonatomic, strong) NSDictionary * shouxufeiCvn;
@property (nonatomic, strong) NSDictionary * outsideAnimate;
@property (nonatomic, strong) NSString * danbixiane;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSMutableArray * nlineEfresh;
@property (nonatomic, strong) NSMutableArray * tixianjine;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) xxzStyleServerView * titleview;

@end

@implementation xxzPlanController


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/empower/token" Params:@{@"userId":self.yitixianIndicator[indexPath.row][@"id"]} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSString * zaixiankefublock = responseObject[@"data"];
            
            
            
            if (self.yitixianIndicator[indexPath.row][@"fullname"]) {
                xxzErsionController * scriptController = [[xxzErsionController alloc]initWithEmpowerToken:zaixiankefublock userDic:self.yitixianIndicator[indexPath.row]];
                
                [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
            }else{
                xxzSettingController *scriptController = [xxzSettingController new];
                scriptController.iEmpowerToken = YES;
                scriptController.startDic = weakSelf.yitixianIndicator[indexPath.row];
                [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
            }
 
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    

}


- (void)layoutTableView{
    self.mc_tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-100);
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    return  95;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.delegate = self;
    self.nlineEfresh = [[NSMutableArray alloc]init];
    self.tixianjine = [[NSMutableArray alloc]init];

    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzSizeButtonCell" bundle:nil] forCellReuseIdentifier:@"xxzSizeButtonCell"];
    self.yitixianIndicator = [[NSMutableArray alloc]init];

    self.type = @"2";
    self.page = 1;
    __weak __typeof(self)weakSelf = self;
    self.mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    self.mc_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf requestData];
    }];

    [self.shoukkuanblock.searchBtn bk_whenTapped:^{
        [self requestData];
    }];
    
    
    
    
    self.titleview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzStyleServerView class]) owner:nil options:nil] lastObject];
   [self layoutTableView];
   self.mc_tableview.tableHeaderView.height = 170;

    [self.titleview.submitBtn setTitle:@"  添加客户" forState:UIControlStateNormal];
    [self.titleview.submitBtn setImage:[UIImage imageNamed:@"loginDown"] forState:0];
    self.titleview.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
    [self.view addSubview:self.titleview];
    
    
    [self.titleview.submitBtn bk_whenTapped:^{
        xxzCodeVeryController * scriptController5 = [[xxzCodeVeryController alloc]init];
        [weakSelf.navigationController pushViewController:scriptController5 animated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (xxzInstitutionExtensionView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzInstitutionExtensionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzSizeButtonCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzSizeButtonCell" forIndexPath:indexPath];

    NSDictionary * date2 = self.yitixianIndicator[indexPath.row];
  
    yitixianCell.cellName.text =  date2[@"fullname"]?   date2[@"fullname"] : @"未实名";
    yitixianCell.cellPhone.text = date2[@"username"];
    yitixianCell.cellCount.text = [NSString stringWithFormat:@"%@",date2[@"runAll"]];
    
     

    return yitixianCell;
}

-(void)setSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    line.hidden = NO;
    
}

-(void)requestData{
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *date0 = [NSMutableDictionary dictionary];
    [date0 setValue:@"20" forKey:@"size"];
    [date0 setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"page"];
    [date0 setValue:self.shoukkuanblock.searchTf.text forKey:@"phone"];
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/credit/empower/list" Params:date0 success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * date0 = responseObject[@"data"];
         

  
            
            [weakSelf.mc_tableview.mj_footer endRefreshing];
            [weakSelf.mc_tableview.mj_header endRefreshing];

            
            NSArray * suppot = responseObject[@"data"];
            if (weakSelf.page == 1) {
                [weakSelf.yitixianIndicator removeAllObjects];
                [weakSelf.yitixianIndicator addObjectsFromArray:suppot];
            }
            else {
                
                if ([suppot count] == 0) {
                    [xxzBase showBottomWithText:@"已加载所有数据"];
                }else{
                    [weakSelf.yitixianIndicator addObjectsFromArray:suppot];

                }
            }
            [weakSelf.mc_tableview reloadData];
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

-(void)getDetail:(NSInteger)userId{
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/my/team/first/det" Params:@{@"userId":@(userId)} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * days = responseObject[@"data"];
            
            
            NSMutableArray * month = [[NSMutableArray alloc]initWithArray:weakSelf.tixianjine];
            BOOL datec = true;
            for (NSDictionary * dic in month) {
                if ([dic[@"id"] integerValue] == userId) {
                    datec = false;
                }else{
                    datec = true;
                    break;
                }
            }
            
            if (datec) {
                [weakSelf.tixianjine addObject:days];

            }
            [weakSelf.mc_tableview reloadData];

        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.yitixianIndicator count];
}


-(void)setUnSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    line.hidden = YES;
    
}


@end
