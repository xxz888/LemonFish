
#import "xxzHangeController.h"
#import "xxzLoginReateView.h"
#import "xxzTradingCell.h"
#import "xxzAddressController.h"
#import "xxzHuxukaGoodsController.h"

@interface xxzHangeController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzLoginReateView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@property (nonatomic, assign) NSInteger page;


@end

@implementation xxzHangeController


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 70;
    
}

- (void)getWithdraw{
    
    
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    [date setValue:@"20" forKey:@"pageSize"];
    [date setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [date setValue:brandId forKey:@"brandId"];
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/payment/quick/huabei/order/list" Params:date success:^(id  _Nonnull responseObject) {
        
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
        
        
        
    } failure:^(NSString * _Nonnull error) {
        
    }];
}



- (xxzLoginReateView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzLoginReateView alloc] init];
    }
    return _shoukkuanblock;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

#pragma mark - QMUITableViewDataSource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    xxzHuxukaGoodsController * scriptController = [[xxzHuxukaGoodsController alloc]init];
    scriptController.startDic = self.yitixianIndicator[indexPath.row];
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.tableHeaderView.height = kStatusBarHeight + 64;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzTradingCell" bundle:nil] forCellReuseIdentifier:@"xxzTradingCell"];
    self.yitixianIndicator = [[NSMutableArray alloc]init];

    self.page = 1;
    __weak __typeof(self)weakSelf = self;
    self.mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf getWithdraw];
    }];
    self.mc_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf getWithdraw];
    }];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getWithdraw];
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzTradingCell *yitixianCell = [xxzTradingCell cellWithTableView:tableView];
    NSDictionary * date_ = self.yitixianIndicator[indexPath.row];
    yitixianCell.priceLbl.text = [NSString stringWithFormat:@"%.2f",[date_[@"realAmount"] doubleValue]];
    yitixianCell.timeLbl.text = date_[@"createTime"];
    NSString * header = date_[@"bankCard"];
    yitixianCell.cardNumLbl.text = [NSString stringWithFormat:@"%@(%@)",date_[@"bankName"],getAfterFour(header)];
    if ([date_[@"orderStatus"] intValue] == 0) {
        yitixianCell.statusLbl.text = @"交易中";
        yitixianCell.priceLbl.textColor = [UIColor colorWithHexString:@"#FEA203"];
        yitixianCell.titleImv.image =  [UIImage imageNamed:@"size_dBackgroundCanshu"];

    }else if([date_[@"orderStatus"] intValue] == 1){
        yitixianCell.statusLbl.text = @"已成功";
        yitixianCell.titleImv.image =  [UIImage imageNamed:@"unicodeStatusHeader"];
        yitixianCell.priceLbl.textColor = [UIColor colorWithHexString:@"#00B0C1"] ;
    }else if([date_[@"orderStatus"] intValue] == 2){
        yitixianCell.statusLbl.text = @"已失败";
        yitixianCell.priceLbl.textColor = [UIColor colorWithHexString:@"#FEA203"];
        yitixianCell.titleImv.image =  [UIImage imageNamed:@"size_dBackgroundCanshu"];

    }
    
    return yitixianCell;
}
@end
