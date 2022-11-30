
#import "xxzSignInyongkaController.h"
#import "xxzAnnerLoginView.h"
#import "xxzTableAutoCell.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzConfigNviteController.h"
#import "xxzLayerController.h"
#import "xxzConstXplainController.h"
@interface xxzSignInyongkaController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzAnnerLoginView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzSignInyongkaController


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    NSDictionary * date = self.yitixianIndicator[indexPath.row];

    xxzConstXplainController * scriptController = [[xxzConstXplainController alloc]init];
    scriptController.navTitle = date[@"title"];
    scriptController.url = date[@"videoUrl"];
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    


    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzTableAutoCell *yitixianCell = [xxzTableAutoCell cellWithTableView:tableView];
    NSDictionary * datea = self.yitixianIndicator[indexPath.row];
    yitixianCell.startDic = datea;
    [yitixianCell.cellImg sd_setImageWithURL:datea[@"coverUrl"]];
    yitixianCell.cellTitle.text = datea[@"title"];
    yitixianCell.cellTime.text = datea[@"createTime"];

    return yitixianCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 240;
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
   
    [self getAllPlanList];
    
    [self eventBlock];
}




- (xxzAnnerLoginView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzAnnerLoginView alloc] init];
    }
    return _shoukkuanblock;
}

#pragma mark - QMUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.tableHeaderView.height = 64 + kStatusBarHeight;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzTableAutoCell" bundle:nil] forCellReuseIdentifier:@"xxzTableAutoCell"];

}


-(void)eventBlock{
    
    [self.shoukkuanblock.addBtn bk_whenTapped:^{
        xxzToolFootController * scriptControllern = [[xxzToolFootController alloc]init];
        [self.xp_rootNavigationController pushViewController:scriptControllern animated:YES];
    }];
    

}


- (void)getAllPlanList{
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/video/type/list" Params:@{@"type":@"1"} success:^(id  _Nonnull responseObject) {
        
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
@end
