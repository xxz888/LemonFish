
#import "xxzHomeConfigController.h"
#import "xxzPickerConfigView.h"
#import "xxzOurseCell.h"
#import "xxzHuxukaHandlerController.h"

@interface xxzHomeConfigController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzPickerConfigView *shoukkuanblock;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSDictionary * tableview;
@property (nonatomic, assign) NSInteger page;

@end

@implementation xxzHomeConfigController


-(void)layoutTableView{

}

-(void)tableViewDidEndMultipleSelectionInteraction:(UITableView *)tableView{
    
    
}

- (xxzPickerConfigView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzPickerConfigView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _shoukkuanblock;
}


-(void)eventBlock{
    __weak typeof(self) weakSelf = self;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzOurseCell" bundle:nil] forCellReuseIdentifier:@"xxzOurseCell"];
    self.mc_tableview.tableHeaderView.height = 230;
    self.yitixianIndicator = [[NSMutableArray alloc]init];
    self.page = 1;
    self.type = @"1";
    __weak __typeof(self)weakSelf = self;
    
    [self requestData];
    
    [self eventBlock];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzOurseCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzOurseCell" forIndexPath:indexPath];
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    


    yitixianCell.cellTitle.text = date[@"title"];
    yitixianCell.textView.text = date[@"content"];

    
    
    
    return yitixianCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 185;
}

- (void)requestData{
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *date2 = [NSMutableDictionary dictionary];

    [date2 setValue:@"1" forKey:@"type"];
    [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:@"/api/user/get/knowledge/by/type" Params:date2  success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            

            [weakSelf.mc_tableview.mj_footer endRefreshing];
            [weakSelf.mc_tableview.mj_header endRefreshing];

            
            NSArray * suppot = responseObject[@"data"];
            
            [weakSelf.yitixianIndicator addObjectsFromArray:suppot];

            [weakSelf.mc_tableview reloadData];

            
 
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.yitixianIndicator count];
}


@end
