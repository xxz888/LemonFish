
#import "xxzAbberController.h"
#import "xxzHideAnnerView.h"
#import "xxzConfirmEmptyCell.h"
#import "xxzHuxukaHandlerController.h"

@interface xxzAbberController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzHideAnnerView *shoukkuanblock;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSDictionary * tableview;
@property (nonatomic, assign) NSInteger page;

@end

@implementation xxzAbberController


-(void)tableViewDidEndMultipleSelectionInteraction:(UITableView *)tableView{
    
    
}

- (xxzHideAnnerView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzHideAnnerView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _shoukkuanblock;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzConfirmEmptyCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzConfirmEmptyCell" forIndexPath:indexPath];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    

    [yitixianCell.cellImv sd_setImageWithURL:[NSURL URLWithString:date[@"coverUrl"]] placeholderImage:nil];

    yitixianCell.cellTitle.text = date[@"title"];
    yitixianCell.cellContent.text = date[@"content"];
    

    
    
    
    return yitixianCell;
}


-(void)eventBlock{
    __weak typeof(self) weakSelf = self;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzHuxukaHandlerController * scriptController = [[xxzHuxukaHandlerController alloc]init];
    scriptController.startDic = self.yitixianIndicator[indexPath.row];
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
}

-(void)layoutTableView{

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 260;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzConfirmEmptyCell" bundle:nil] forCellReuseIdentifier:@"xxzConfirmEmptyCell"];
    self.mc_tableview.tableHeaderView.height = 230;
    self.yitixianIndicator = [[NSMutableArray alloc]init];
    self.page = 1;
    self.type = @"1";
    __weak __typeof(self)weakSelf = self;
    self.mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        [weakSelf requestData];
    }];
    self.mc_tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page += 1;
        [weakSelf requestData];
    }];
    
    [self requestData];
    
    [self eventBlock];
}

- (void)requestData{
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *dateG = [NSMutableDictionary dictionary];
    [dateG setValue:@"20" forKey:@"pageSize"];
    [dateG setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [dateG setValue:@"2" forKey:@"type"];
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/get/knowledge/page/by/type" Params:dateG  success:^(id  _Nonnull responseObject) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.yitixianIndicator count];
}


@end
