
#import "xxzTradingController.h"
#import "xxzEgmentView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"
#import "xxzNviteUpdateView.h"
#import "xxzSettingArnerCell.h"
#import "xxzMagnificationCell.h"
#import "xxzErsonController.h"

@interface xxzTradingController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzEgmentView *shoukkuanblock;
@property (nonatomic, strong) xxzNviteUpdateView * jihuahuankuanbishu;
@property (nonatomic, strong) NSArray * cityWhere_6;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, assign) NSInteger page;

@end

@implementation xxzTradingController


-(void)requestData{
   
    
    
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    [date setValue:@"20" forKey:@"pageSize"];
    [date setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [date setValue:self.cityWhere_6 forKey:@"types"];

    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/income/detail" Params:date success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
         
            weakSelf.shoukkuanblock.sectionPrice.text =  [NSString stringWithFormat:@"+%.2f",[responseObject[@"data"][@"todayTotal"] doubleValue]];
            weakSelf.shoukkuanblock.sectionTime.text = [NSDate GetCurrentDateType:0];

            
            [weakSelf.mc_tableview.mj_footer endRefreshing];
            [weakSelf.mc_tableview.mj_header endRefreshing];

            
            NSArray * suppot = responseObject[@"data"][@"list"];
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.yitixianIndicator count] == 0 ?  1 : [self.yitixianIndicator count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self)weakSelf = self;

    if ([self.yitixianIndicator count] == 0) {
        xxzMagnificationCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzMagnificationCell" forIndexPath:indexPath];
        
        [yitixianCell.tixianBtn bk_whenTapped:^{
            [weakSelf.xp_rootNavigationController pushViewController:[xxzErsonController new] animated:YES];

        }];
        return yitixianCell;
    }else{
        xxzSettingArnerCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzSettingArnerCell" forIndexPath:indexPath];
        NSDictionary * datee = self.yitixianIndicator[indexPath.row];
        yitixianCell.cellTitle.text = datee[@"remark"];
        yitixianCell.cellTime.text = datee[@"createTime"];
        yitixianCell.cellName.text = datee[@"sourceName"];
        yitixianCell.cellPrice.text = [NSString stringWithFormat:@"金额:%.2f",[datee[@"orderAmount"] doubleValue]];
        yitixianCell.cellRightPrice.text =[NSString stringWithFormat:@"+%.2f",[datee[@"amount"] doubleValue]];
        
        if ([datee[@"type"] integerValue] == 2 || [datee[@"type"] integerValue] == 31 || [datee[@"type"] integerValue] == 32) {
            yitixianCell.cellImv.image = [UIImage imageNamed:@"unbindLocation"];
            yitixianCell.cellRightPrice.textColor = [UIColor colorWithHexString:@"#FEA203"];
        }else{
            yitixianCell.cellImv.image = [UIImage imageNamed:@"buttomShuakarate"];
            yitixianCell.cellRightPrice.textColor = [UIColor colorWithHexString:@"#FF5D61"];
        }
        
        return yitixianCell;
    }
    

}

- (xxzEgmentView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzEgmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [self.yitixianIndicator count] == 0 ?  kScreenHeight - 350 : 100;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.shoukkuanblock.navTitle.text = self.navTitle;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.delegate = self;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzSettingArnerCell" bundle:nil] forCellReuseIdentifier:@"xxzSettingArnerCell"];
    self.shoukkuanblock.shouruLbl.text = self.shouru;
    
    
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzMagnificationCell" bundle:nil] forCellReuseIdentifier:@"xxzMagnificationCell"];

    
    self.yitixianIndicator = [[NSMutableArray alloc]init];
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

    
    
    if ([self.navTitle isEqualToString:@"收款业务奖励"]) {
        self.cityWhere_6 = @[@"2",@"3",@"31",@"32"];
    }
    if ([self.navTitle isEqualToString:@"还款业务奖励"]) {
        self.cityWhere_6 = @[@"12",@"13"];
    }
    if ([self.navTitle isEqualToString:@"申请办卡奖励"]) {
        self.cityWhere_6 = @[];
    }
    if ([self.navTitle isEqualToString:@"自用返现奖励"]) {
        self.cityWhere_6 = @[@"1",@"11"];
    }
    if ([self.navTitle isEqualToString:@"活动奖励"]) {
        self.cityWhere_6 = @[];
    }
    if ([self.navTitle isEqualToString:@"其他奖励"]) {
        self.cityWhere_6 = @[@"0"];
    }
 
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
@end
