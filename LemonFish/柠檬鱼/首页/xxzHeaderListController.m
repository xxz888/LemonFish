
#import "xxzHeaderListController.h"
#import "xxzHangeView.h"
#import "xxzAbberOrgetController.h"
#import "xxzConfirmToolsController.h"
#import "xxzUpdateController.h"
#import "xxzConstXplainController.h"
#import "xxzErsionController.h"
#import "xxzTabbarView.h"
#import "xxzListHandlerController.h"
#import "xxzScreenTitleCell.h"
#import "xxzHuxukaHandlerController.h"
#import "xxzSignInyongkaController.h"
#import "xxzHeaderEnlargeController.h"

@interface xxzHeaderListController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzHangeView *shoukkuanblock;
@property (nonatomic, strong) NSString  * yitixian;
@property (nonatomic ,strong)NSArray * yitixianIndicator;
@end

@implementation xxzHeaderListController


- (xxzHangeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzHangeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 541)];
    }
    return _shoukkuanblock;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (void)requestGetMaterialList {
    __weak __typeof(self)weakSelf = self;
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    [date setValue:@"3" forKey:@"pageSize"];
    [date setValue:@"1" forKey:@"currentPage"];
    [date setValue:@"2" forKey:@"type"];

    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/get/knowledge/page/by/type" Params:date success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
     
            weakSelf.yitixianIndicator = responseObject[@"data"];

     
            [weakSelf.mc_tableview reloadData];

            
            
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    


}

#pragma 获取版本信息 个人信息

- (void)addVersionUpdata:(NSDictionary *)data{
    
    xxzTabbarView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzTabbarView class]) owner:nil options:nil] lastObject];
    NSDictionary *nav = [[NSBundle mainBundle] infoDictionary];
    NSString  *main_n = [nav objectForKey:@"CFBundleShortVersionString"];
    
    LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                  popStyle:LSTPopStyleSpringFromTop
                                              dismissStyle:LSTDismissStyleSmoothToTop];
    
    jihuajine.currentVersion.text = [NSString stringWithFormat:@"当前版本:%@",main_n];
    jihuajine.storeVersion.text = [NSString stringWithFormat:@"当前版本:%@",data[@"iosVersion"]];
    
    if ([data[@"iosContent"] length] > 0) {
        jihuajine.versionContent.text =  [data[@"iosContent"] stringByReplacingOccurrencesOfString:@"&" withString:@"\n"];
    }else{
        jihuajine.versionContent.text = @"1、修复已知BUG ;\n2、优化用户体验";
    }
    
    LSTPopViewWK(xplainView);
        [jihuajine.closeBtn bk_whenTapped:^{
            [wk_xplainView dismiss];
        }];
    
    [jihuajine.updateBtn bk_whenTapped:^{
          [wk_xplainView dismiss];
        
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data[@"iosUrl"]] options:@{} completionHandler:nil];
    }];
 
    [xplainView pop];

}

-(void)getMessage{
    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/index" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            if (!responseObject[@"data"][@"totalUrmc"] || [responseObject[@"data"][@"totalUrmc"] integerValue] <= 0) {
                self.shoukkuanblock.messageLbl.hidden = YES;
            }else if ([responseObject[@"totalUrmc"] integerValue] >= 100)
            {
                self.shoukkuanblock.messageLbl.text = @"99+";
                self.shoukkuanblock.messageLbl.hidden = NO;
            }
            else{
                self.shoukkuanblock.messageLbl.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"totalUrmc"]];
                self.shoukkuanblock.messageLbl.hidden = NO;

            }
        }
    } failure:^(NSString * _Nonnull error) {}];
}
#pragma 弹出版本升级

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzHuxukaHandlerController * scriptController = [[xxzHuxukaHandlerController alloc]init];
    scriptController.startDic = self.yitixianIndicator[indexPath.row];
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    
}


- (void)getVersionData{
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * oney= responseObject[@"data"];
            NSDictionary *navp = [[NSBundle mainBundle] infoDictionary];
            self.yitixian = oney[@"serviceUrl"];
            
            NSString  *main_nT = [navp objectForKey:@"CFBundleShortVersionString"];
            NSString * slider = [main_nT stringByReplacingOccurrencesOfString:@"." withString:@""];
            NSString * one5 = [[oney[@"iosVersion"] stringValue] stringByReplacingOccurrencesOfString:@"." withString:@""];
            if (![[oney[@"iosVersion"] stringValue] isEqualToString:main_nT] && [slider integerValue] < [one5 integerValue]) {
                [self addVersionUpdata:oney];
            }
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    NSDictionary *huabeiblock = [self loadUserData];
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:[NSString stringWithFormat:@"/api/user/get/%@",huabeiblock[@"id"]] Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [self updateUserData:responseObject[@"data"]];
        }
        
        [self RealNameAuthentication];
    } failure:^(NSString * _Nonnull error) {
        
    }];
}


- (void)layoutTableView{
    self.mc_tableview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTabBarHeight);
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)blockAction{
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.huabeiblock = ^{
        xxzHeaderEnlargeController * scriptControllere = [[xxzHeaderEnlargeController alloc]init];
        [weakSelf.xp_rootNavigationController pushViewController:scriptControllere animated:YES];
    };

    
    
    self.shoukkuanblock.xinyongkablock = ^{
        xxzConstXplainController * scriptControllere = [[xxzConstXplainController alloc]init];
        scriptControllere.navTitle = @"信用卡申请";
        NSString *result = @"https://lion-api.51ley.com/lion-template/?type=bank&userId=1582270942464180225";

        scriptControllere.url = result;
        [weakSelf.xp_rootNavigationController pushViewController:scriptControllere animated:YES];
    };
    
    
    self.shoukkuanblock.zaixiankefublock = ^{
        xxzConstXplainController * scriptControllere = [[xxzConstXplainController alloc]init];
        scriptControllere.navTitle = @"在线客服";
        scriptControllere.url = weakSelf.yitixian;
        [weakSelf.xp_rootNavigationController pushViewController:scriptControllere animated:YES];

    };
    
    
    self.shoukkuanblock.xinshoujiaochengblock = ^{
        [xxzBase showBottomWithText:@"正在升级中"];
    };

    
    self.shoukkuanblock.shoukkuanblock = ^{
        if ([weakSelf RealNameAuthentication]) {
            [weakSelf.xp_rootNavigationController pushViewController:[xxzAbberOrgetController new] animated:YES];
        }
    };
    
    
    self.shoukkuanblock.huankuanblock = ^{
        if ([weakSelf RealNameAuthentication]) {
            xxzErsionController * scriptControllere = [[xxzErsionController alloc]initWithEmpowerToken:nil userDic:nil];
            [weakSelf.xp_rootNavigationController pushViewController:scriptControllere animated:YES];
        }
    };
    
    
    
    
    
    
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzScreenTitleCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzScreenTitleCell" forIndexPath:indexPath];
    NSDictionary * datet = self.yitixianIndicator[indexPath.row];
    
    [yitixianCell.cellImv sd_setImageWithURL:[NSURL URLWithString:datet[@"coverUrl"]] placeholderImage:nil];
    yitixianCell.cellTitle.text = datet[@"title"];
    yitixianCell.cellCount.text = [NSString stringWithFormat:@"%@",datet[@"readCount"]];
    yitixianCell.cellTime.text = datet[@"createTime"];
    yitixianCell.cellSubTitle.text = datet[@"content"];
    
    
    if (indexPath.row == 0) {
        [yitixianCell.cellDiv getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 32 , 150) CornerRadius:15 UIRectCorner:UIRectCornerTopLeft | UIRectCornerTopRight];
    }
    
    if (indexPath.row == [self.yitixianIndicator count] -1) {
        [yitixianCell.cellDiv getPartOfTheCornerRadius:CGRectMake(0, 0, kScreenWidth - 32, 150) CornerRadius:15 UIRectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight];

    }
    
    
    
    return yitixianCell;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *lijitixian = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblock8 = [lijitixian objectForKey:@"UserData"];

    
    [self getVersionData];
    [self getMessage];
    [self requestGetMaterialList];

}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.tableHeaderView.height = 630;
    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzScreenTitleCell" bundle:nil] forCellReuseIdentifier:@"xxzScreenTitleCell"];
    self.mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    
        
        
        [self.mc_tableview.mj_header endRefreshing];
   
    }];

    
    [self blockAction];
    
}



@end
