
#import "xxzHideController.h"
#import "xxzMainView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"
#import "xxzEtworkingCell.h"
#import "xxzVeryController.h"
#import "xxzSizeCategoryView.h"

#import "xxzTradingController.h"

@interface xxzHideController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzMainView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * subOrget;
@property (nonatomic, strong) NSDictionary * shouxufeiCvn;
@property (nonatomic, strong) NSDictionary * outsideAnimate;
@property (nonatomic, strong) NSString * danbixiane;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSMutableArray * nlineEfresh;
@property (nonatomic, strong) NSMutableArray * tixianjine;
@property (nonatomic, assign) NSInteger page;

@end

@implementation xxzHideController


-(void)setUnSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    line.hidden = YES;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    return  [self.nlineEfresh containsObject:@([date[@"id"] integerValue])] ? 300 : 210;
}

-(void)requestData{
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *datea = [NSMutableDictionary dictionary];
    [datea setValue:@"20" forKey:@"pageSize"];
    [datea setValue:[NSString stringWithFormat:@"%li",self.page] forKey:@"currentPage"];
    [datea setValue:self.shoukkuanblock.searchTf.text forKey:@"phone"];
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/my/team/first" Params:datea success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * datea = responseObject[@"data"];
            weakSelf.shoukkuanblock.countLbl.text =  [self.startString stringByReplacingOccurrencesOfString:@"人" withString:@""];
            weakSelf.shoukkuanblock.zhituirenshuLbl.text = [NSString stringWithFormat:@"%@",datea[@"firstCount"]];
            weakSelf.shoukkuanblock.liebianrenshuLBl.text = [NSString stringWithFormat:@"%@",datea[@"secondCount"]];
            weakSelf.shoukkuanblock.benyuejiaoyiliangLbl.text = [NSString stringWithFormat:@"%.2f万",[datea[@"curMonthAllAmount"] doubleValue]/10000];

  
            
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (xxzMainView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzMainView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(void)setSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    line.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.yitixianIndicator count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    xxzEtworkingCell * yitixianCell = [tableView dequeueReusableCellWithIdentifier:@"xxzEtworkingCell" forIndexPath:indexPath];

    NSDictionary * dateW = self.yitixianIndicator[indexPath.row];
    yitixianCell.openBtn.tag = [dateW[@"id"] integerValue];
    yitixianCell.closeBtn.tag = [dateW[@"id"] integerValue];
    yitixianCell.setRateBtn.tag = indexPath.row;
    yitixianCell.wxBtn.tag = [dateW[@"wechatNumber"] integerValue];
    yitixianCell.cellName.text = dateW[@"fullname"];
    yitixianCell.cellPhone.text = dateW[@"username"];
    yitixianCell.incomeTIme.text = dateW[@"createTime"];
        [yitixianCell.cellImv sd_setImageWithURL:[NSURL URLWithString:dateW[@"avatar"]] placeholderImage:[UIImage imageNamed:@"zhengmianfanmianPriceFooter"]];
    
    if ([self.nlineEfresh containsObject:@([dateW[@"id"] integerValue])]) {
        yitixianCell.openBtn.hidden = YES;
        yitixianCell.closeBtn.hidden = NO;
    }else{
        yitixianCell.openBtn.hidden = NO;
        yitixianCell.closeBtn.hidden = YES;
    }
    
   
    for (NSDictionary * itemDic in self.tixianjine) {
        if ([itemDic[@"id"] integerValue] == [dateW[@"id"] integerValue]) {
            yitixianCell.leijishouruLbl.text = [NSString stringWithFormat:@"%.2f",[itemDic[@"totalIncome"] doubleValue]];
            
            yitixianCell.tuanduizhongshuLbl.text = [NSString stringWithFormat:@"%@",itemDic[@"teamCount"] ];
                        
            
            yitixianCell.benyuejiaoyiliangLbl.text = [NSString stringWithFormat:@"%.2f万",[itemDic[@"curMonthAllAmount"] doubleValue]/10000];

            yitixianCell.kehushuLbl.text = [NSString stringWithFormat:@"%@",itemDic[@"firstCount"] ];

        }
    }
    
    
    __weak typeof(self) weakSelf = self;

    
    [yitixianCell.openBtn bk_whenTapped:^{
        
        if (![weakSelf.nlineEfresh containsObject:@(yitixianCell.openBtn.tag) ]) {
            [weakSelf.nlineEfresh addObject:@(yitixianCell.openBtn.tag)];
        }
        [weakSelf getDetail:yitixianCell.openBtn.tag];
    }];
    
    
    [yitixianCell.closeBtn bk_whenTapped:^{
        if ([weakSelf.nlineEfresh containsObject:@(yitixianCell.openBtn.tag) ]) {
            [weakSelf.nlineEfresh removeObject:@(yitixianCell.openBtn.tag)];
        }
        [weakSelf getDetail:yitixianCell.openBtn.tag];
    }];
    
    [yitixianCell.phoneBtn bk_whenTapped:^{
        NSString *call = dateW[@"username"];
        NSMutableString * qianyuetongdao=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",call];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qianyuetongdao]];
    }];
    
    [yitixianCell.wxBtn bk_whenTapped:^{

        if (yitixianCell.wxBtn.tag == 0) {
            [xxzBase showBottomWithText:@"该用户暂无微信"];
            return;
        }
        NSURL * result = [NSURL URLWithString:@"wechat://"];
        BOOL medium = [[UIApplication sharedApplication] canOpenURL:result];
        
        if (medium){
            
            xxzSizeCategoryView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzSizeCategoryView class]) owner:nil options:nil] lastObject];

            
            LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                          popStyle:LSTPopStyleSpringFromTop
                                                      dismissStyle:LSTDismissStyleSmoothToTop];
            
            jihuajine.wxLbl.text =   [NSString stringWithFormat:@"%ld",(long)yitixianCell.wxBtn.tag];
            LSTPopViewWK(xplainView);
                [jihuajine.closeBtn bk_whenTapped:^{
                    [wk_xplainView dismiss];
                }];
         
            
            [jihuajine.btnCopy bk_whenTapped:^{
                UIPasteboard.generalPasteboard.string = [NSString stringWithFormat:@"%ld",(long)yitixianCell.wxBtn.tag];
                [xxzBase showBottomWithText:@"文案已复制到剪切板"];
                [wk_xplainView dismiss];
            }];
            [xplainView pop];
            
            
            
        }else {
            [xxzBase showBottomWithText:@"您的设备未安装微信APP"];
        }
        
    }];
    
    [yitixianCell.setRateBtn bk_whenTapped:^{
        
     
        
        
        xxzVeryController * scriptController = [[xxzVeryController alloc]init];
        scriptController.startDic = weakSelf.yitixianIndicator[yitixianCell.setRateBtn.tag];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    return yitixianCell;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.delegate = self;
    self.nlineEfresh = [[NSMutableArray alloc]init];
    self.tixianjine = [[NSMutableArray alloc]init];

    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzEtworkingCell" bundle:nil] forCellReuseIdentifier:@"xxzEtworkingCell"];
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
}


@end
