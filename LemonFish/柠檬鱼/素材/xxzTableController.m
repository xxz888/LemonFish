
#import "xxzTableController.h"
#import "xxzHangeRateCell.h"
#import "xxzProgressView.h"

@interface xxzTableController ()<QMUITableViewDelegate, QMUITableViewDataSource>
@property(nonatomic, strong) NSMutableArray *yitixianIndicator;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger versionZhituirenshu;
@property (nonatomic ,strong)NSMutableArray * offAnimate ;
@property (nonatomic ,strong)NSMutableArray * xuanzediqv ;
@property (nonatomic, strong) xxzProgressView *shoukkuanblock;

@end

@implementation xxzTableController



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [xxzHangeRateCell cellWithTableview:tableView articleModel:self.yitixianIndicator[indexPath.row]];
}


- (xxzProgressView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _shoukkuanblock;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray * last = self.yitixianIndicator[indexPath.row][@"children"];
    
    if ([last count] <= 3) {
        return 300 + 111;
    }else if ([last count] >= 7){
        return 300 + 222;
    }else{
        return 300 + 333;
    }
    
    
}


- (void)layoutTableView{
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.mc_tableview.dataSource = self;
    self.mc_tableview.delegate = self;
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight);

    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.tableHeaderView.height = 64 + kStatusBarHeight;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
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


   
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
#pragma mark - Tableview

- (void)requestData {
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    [date setValue:@"20" forKey:@"pageSize"];
    [date setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [date setValue:brandId forKey:@"brandId"];

    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/material/get/list" Params:date success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
     
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yitixianIndicator.count;
}

@end
