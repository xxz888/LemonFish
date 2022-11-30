
#import "xxzAreaOprationController.h"
#import "xxzFootPhoneView.h"
#import "xxzTouchInstitutionCell.h"
#import "xxzAddressController.h"
#import "xxzHuxukaGoodsController.h"

@interface xxzAreaOprationController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzFootPhoneView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@property (nonatomic, assign) NSInteger page;


@end

@implementation xxzAreaOprationController


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzTouchInstitutionCell *yitixianCell = [xxzTouchInstitutionCell cellWithTableView:tableView];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    yitixianCell.priceLbl.text = [NSString stringWithFormat:@"%.2f",[date[@"realAmount"] doubleValue]];
    yitixianCell.timeLbl.text = date[@"createTime"];
    NSString * header = date[@"bankCard"];
    yitixianCell.cardNumLbl.text = [NSString stringWithFormat:@"%@(%@)",date[@"bankName"],getAfterFour(header)];
    if ([date[@"orderStatus"] intValue] == 0) {
        yitixianCell.statusLbl.text = @"交易中";
        yitixianCell.priceLbl.textColor = [UIColor colorWithHexString:@"#FEA203"];
        yitixianCell.titleImv.image =  [UIImage imageNamed:@"size_dBackgroundCanshu"];

    }else if([date[@"orderStatus"] intValue] == 1){
        yitixianCell.statusLbl.text = @"已成功";
        yitixianCell.titleImv.image =  [UIImage imageNamed:@"unicodeStatusHeader"];
        yitixianCell.priceLbl.textColor = [UIColor colorWithHexString:@"#00B0C1"] ;
    }else if([date[@"orderStatus"] intValue] == 2){
        yitixianCell.statusLbl.text = @"已失败";
        yitixianCell.priceLbl.textColor = [UIColor colorWithHexString:@"#FEA203"];
        yitixianCell.titleImv.image =  [UIImage imageNamed:@"size_dBackgroundCanshu"];

    }
    
    return yitixianCell;
}

- (xxzFootPhoneView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzFootPhoneView alloc] init];
    }
    return _shoukkuanblock;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}



- (void)getWithdraw{
    
    
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *datex = [NSMutableDictionary dictionary];
    [datex setValue:@"20" forKey:@"pageSize"];
    [datex setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [datex setValue:brandId forKey:@"brandId"];
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/payment/quick/order/list" Params:datex success:^(id  _Nonnull responseObject) {
        
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

#pragma mark - QMUITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 70;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.tableHeaderView.height = kStatusBarHeight + 64;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzTouchInstitutionCell" bundle:nil] forCellReuseIdentifier:@"xxzTouchInstitutionCell"];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    xxzHuxukaGoodsController * scriptController = [[xxzHuxukaGoodsController alloc]init];
    scriptController.startDic = self.yitixianIndicator[indexPath.row];
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
}
@end
