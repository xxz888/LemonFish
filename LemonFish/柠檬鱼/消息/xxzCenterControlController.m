
#import "xxzCenterControlController.h"
#import "xxzMageSilderView.h"
#import "xxzOursePickerCell.h"
#import "xxzNewsAlendarController.h"

@interface xxzCenterControlController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzMageSilderView *shoukkuanblock;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSDictionary * tableview;
@property (nonatomic, assign) NSInteger page;

@end

@implementation xxzCenterControlController


- (xxzMageSilderView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzMageSilderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _shoukkuanblock;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzOursePickerCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzOursePickerCell" forIndexPath:indexPath];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    
    if ([self.type isEqualToString:@"1"]) {
        yitixianCell.cellImv.image = [UIImage imageNamed:@"sliderJiaoyifei"];
    }
    if ([self.type isEqualToString:@"0"]) {
        yitixianCell.cellImv.image = [UIImage imageNamed:@"addressTop"];
    }
    if ([self.type isEqualToString:@"2"]) {
        yitixianCell.cellImv.image = [UIImage imageNamed:@"observerMage"];
    }
    
    yitixianCell.cellTitle.text = date[@"title"];
    yitixianCell.cellTime.text = date[@"createTime"];
    yitixianCell.cellContent.text = date[@"msg"];
    yitixianCell.cellSp.hidden = [date[@"read"] integerValue] == 1;
    
    if (indexPath.row == 0) {
        [yitixianCell.cellDiv getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 34 , 150) CornerRadius:15 UIRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight];
    }
    
    if (indexPath.row == [self.yitixianIndicator count] -1) {
        [yitixianCell.cellDiv getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 34, 150) CornerRadius:15 UIRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight];

    }

    
    
    
    return yitixianCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight);

    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzOursePickerCell" bundle:nil] forCellReuseIdentifier:@"xxzOursePickerCell"];
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
    NSMutableDictionary *date8 = [NSMutableDictionary dictionary];
    [date8 setValue:@"20" forKey:@"pageSize"];
    [date8 setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [date8 setValue:self.type forKey:@"type"];
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/msg/list" Params:date8  success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            
            
            
            
            
            if ([responseObject[@"data"][@"urType"][@"0"] integerValue] == 0) {
                self.shoukkuanblock.lbl2.hidden = YES;
            }else{
                self.shoukkuanblock.lbl2.hidden = NO;
                self.shoukkuanblock.lbl2.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"urType"][@"0"]];
            }
            
            if ([responseObject[@"data"][@"urType"][@"1"] integerValue] == 0) {
                self.shoukkuanblock.lbl1.hidden = YES;
            }else{
                self.shoukkuanblock.lbl1.hidden = NO;
                self.shoukkuanblock.lbl1.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"urType"][@"1"]];
            }
            
            if ([responseObject[@"data"][@"urType"][@"2"] integerValue] == 0) {
                self.shoukkuanblock.lbl3.hidden = YES;
            }else{
                self.shoukkuanblock.lbl3.hidden = NO;
                self.shoukkuanblock.lbl3.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"urType"][@"2"]];
            }
            
            
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.yitixianIndicator count];
}

-(void)layoutTableView{

}

-(void)tableViewDidEndMultipleSelectionInteraction:(UITableView *)tableView{
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * datek = self.yitixianIndicator[indexPath.row];
    xxzNewsAlendarController * scriptController = [[xxzNewsAlendarController alloc]init];
    scriptController.startDic = datek;
    scriptController.type = self.type;
    [self.navigationController pushViewController:scriptController animated:YES];
}

-(void)eventBlock{
    __weak typeof(self) weakSelf = self;

    [self.shoukkuanblock.view1 bk_whenTapped:^{
        weakSelf.type = @"1";
        weakSelf.page = 1;
        [weakSelf.yitixianIndicator removeAllObjects];
        [weakSelf requestData];
    }];
    [self.shoukkuanblock.view2 bk_whenTapped:^{
        weakSelf.type = @"2";
        weakSelf.page = 1;
        [weakSelf.yitixianIndicator removeAllObjects];

        [weakSelf requestData];

    }];
    [self.shoukkuanblock.view3 bk_whenTapped:^{
        weakSelf.type = @"0";
        weakSelf.page = 1;
        [weakSelf.yitixianIndicator removeAllObjects];

        [weakSelf requestData];

    }];
    
    
    [self.shoukkuanblock.clearAll bk_whenTapped:^{
        [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/msg/all/read" Params:@{} success:^(id  _Nonnull responseObject) {
            
            [weakSelf requestData];
        } failure:^(NSString * _Nonnull error) {

        }];
    }];
}


@end
