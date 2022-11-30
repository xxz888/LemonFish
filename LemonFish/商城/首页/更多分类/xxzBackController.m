
#import "xxzBackController.h"
#import "xxzLaunchCell.h"

#import "xxzPackageNameController.h"
@interface xxzBackController ()<UITableViewDelegate, UITableViewDataSource , UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UICollectionView *day;
@property (nonatomic , strong) NSArray *benyuejiaoyiliang;

@property (nonatomic , strong) UILabel *ime;
@property (nonatomic , assign) int page;

@property (nonatomic , strong) NSArray *dataArr;
@property (nonatomic , assign) int accSlip;

@end

@implementation xxzBackController


- (UICollectionView *)day{
    if (!_day) {
        
        CGFloat interval_ol = (DEVICE_WIDTH - 100 - 20) / 3;
        
        
        UICollectionViewFlowLayout *magnification = [UICollectionViewFlowLayout new];
        magnification.scrollDirection = UICollectionViewScrollDirectionVertical;
        magnification.minimumInteritemSpacing = 5;
        magnification.minimumLineSpacing = 5;
        magnification.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        magnification.itemSize = CGSizeMake(interval_ol,100);
        
        _day = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:magnification];
        _day.backgroundColor = [UIColor whiteColor];
        _day.showsVerticalScrollIndicator = NO;
        
        [self.day registerNib:[UINib nibWithNibName:@"xxzLaunchCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        _day.delegate = self;
        _day.dataSource = self;
       
    }
    return _day;
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate UITableViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *danrixiane = @"cell";
    xxzLaunchCell *yitixianCell= [collectionView dequeueReusableCellWithReuseIdentifier:danrixiane forIndexPath:indexPath];
    
    
    NSDictionary *oney = self.dataArr[self.accSlip-1][indexPath.row];
    
    yitixianCell.top_image.image = [UIImage imageNamed:oney[@"image"]];
    
    yitixianCell.title_lab.text = oney[@"name"];
    
    return yitixianCell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArr[self.accSlip - 1] count];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.benyuejiaoyiliang.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *oneyB = self.dataArr[self.accSlip-1][indexPath.row];
    
    xxzPackageNameController * pickerController = [xxzPackageNameController new];
    pickerController.title = oneyB[@"name"];
    pickerController.requestString = oneyB[@"name"];
    [self.xp_rootNavigationController pushViewController:pickerController animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *yitixianCellI = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [yitixianCellI setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UILabel *searchLab = [UILabel getUILabelText:self.benyuejiaoyiliang[indexPath.row] TextColor:[UIColor blackColor] TextFont:[UIFont getUIFontSize:14 IsBold:NO] TextNumberOfLines:0];
    searchLab.tag = indexPath.row + 100;
    searchLab.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    searchLab.textAlignment = NSTextAlignmentCenter;
    searchLab.userInteractionEnabled = YES;
    [yitixianCellI.contentView addSubview:searchLab];
    [searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    if (indexPath.row == 0) {
        searchLab.backgroundColor = [UIColor whiteColor];
        self.ime = searchLab;
    }
    [searchLab bk_whenTapped:^{
        if (self.ime.tag != searchLab.tag) {
            self.ime.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
            searchLab.backgroundColor = [UIColor whiteColor];
            self.ime = searchLab;
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat other = [self.day layoutAttributesForSupplementaryElementOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]].frame.origin.y;
                    
                    CGFloat d_manager = self.day.contentInset.top;
                    CGFloat ime = ((UICollectionViewFlowLayout *)self.day.collectionViewLayout).sectionInset.top;
                    
                    [self.day setContentOffset:CGPointMake(self.day.contentOffset.x, other - d_manager - ime) animated:NO];
                });
            self.accSlip = (int)indexPath.row + 1;
            [self.day reloadData];
        }
    }];
    return yitixianCellI;
}


#pragma mark - UICollectionViewDelegate

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"积分";
    self.page = 1;
    self.accSlip = 1;
    [self LoadUI];
}

#pragma 懒加载

- (void)LoadUI{

    self.benyuejiaoyiliang = [NSArray arrayWithObjects:@"女装",@"母婴",@"美妆",@"居家日用",@"鞋品",@"美食",@"文娱车品",@"数码家电",@"男装",@"内衣",@"箱包",@"配饰",@"户外运动",@"家装家纺", nil];
    
    NSArray *orgetj = [NSArray arrayWithObjects:
                     @{@"name":@"shuakarateMine",@"image":@"shuakarateMine"},
                     @{@"name":@"xuanzediqvBenyuejiaoyiliang",@"image":@"xuanzediqvBenyuejiaoyiliang"},
                     @{@"name":@"fanmianToolQiandao",@"image":@"fanmianToolQiandao"},
                     @{@"name":@"weekRequest",@"image":@"weekRequest"},
                     @{@"name":@"limitCollectPwd",@"image":@"limitCollectPwd"},
                     @{@"name":@"remenhuodongStringList",@"image":@"remenhuodongStringList"},
                     @{@"name":@"annerShopMagnification",@"image":@"annerShopMagnification"},
                     @{@"name":@"mainChanged",@"image":@"mainChanged"},
                     @{@"name":@"abbarOast",@"image":@"abbarOast"},
                     @{@"name":@"teamStackInsi",@"image":@"teamStackInsi"},
                     @{@"name":@"imgQcode",@"image":@"imgQcode"},
                     @{@"name":@"addressXinshoujiaochengblock",@"image":@"addressXinshoujiaochengblock"},
                     @{@"name":@"veryScoreInfo",@"image":@"veryScoreInfo"},nil];
    NSArray *result = [NSArray arrayWithObjects:
                     @{@"name":@"collectionviewJiaoyishijianCanshu",@"image":@"collectionviewJiaoyishijianCanshu"},
                     @{@"name":@"huankuancishuPlan",@"image":@"huankuancishuPlan"},
                     @{@"name":@"endXiaofei",@"image":@"endXiaofei"},
                     @{@"name":@"progressSing",@"image":@"progressSing"},
                     @{@"name":@"controllerShrink",@"image":@"controllerShrink"},nil];
    NSArray *banner = [NSArray arrayWithObjects:
                     @{@"name":@"controlIndexTab",@"image":@"controlIndexTab"},
                     @{@"name":@"efreshReg",@"image":@"efreshReg"},
                     @{@"name":@"tipBool_9xVideo",@"image":@"tipBool_9xVideo"},
                     @{@"name":@"alendarLeft",@"image":@"alendarLeft"},
                     @{@"name":@"hangeShouxufei",@"image":@"hangeShouxufei"},
                     @{@"name":@"tokenCityMinute",@"image":@"tokenCityMinute"},
                     @{@"name":@"shuakarateNeedRegtip",@"image":@"shuakarateNeedRegtip"},
                     @{@"name":@"nameKucun",@"image":@"nameKucun"},nil];
    NSArray *yijiesuanG = [NSArray arrayWithObjects:
                     @{@"name":@"dingdanzhuangkuangOrigin",@"image":@"dingdanzhuangkuangOrigin"},
                     @{@"name":@"blackToolCut",@"image":@"blackToolCut"},
                     @{@"name":@"efreshJieshushijian",@"image":@"efreshJieshushijian"},
                     @{@"name":@"shoujihaoEpaymentButtons",@"image":@"shoujihaoEpaymentButtons"},
                     @{@"name":@"cameraKapianguanliConstraint",@"image":@"cameraKapianguanliConstraint"},
                     @{@"name":@"pricelblGroup",@"image":@"pricelblGroup"},
                     @{@"name":@"closeSize_6gChakanjihua",@"image":@"closeSize_6gChakanjihua"},
                     @{@"name":@"heightDismissPricelbl",@"image":@"heightDismissPricelbl"},
                     @{@"name":@"chuxukaOastShoukuanren",@"image":@"chuxukaOastShoukuanren"},nil];
    NSArray *shouru = [NSArray arrayWithObjects:
                     @{@"name":@"urlSegment",@"image":@"urlSegment"},
                     @{@"name":@"observerEndEfresh",@"image":@"observerEndEfresh"},
                     @{@"name":@"shoukuanrenScoreYangkajigou",@"image":@"shoukuanrenScoreYangkajigou"},
                     @{@"name":@"egmentErsionBlue",@"image":@"egmentErsionBlue"},
                     @{@"name":@"listMenuYihuanjine",@"image":@"listMenuYihuanjine"},nil];
    NSArray *key = [NSArray arrayWithObjects:
                     @{@"name":@"progressHuankuanbishuSelect",@"image":@"progressHuankuanbishuSelect"},
                     @{@"name":@"shoukkuanblockEmpty",@"image":@"shoukkuanblockEmpty"},
                     @{@"name":@"yuliujinZhidingjihua",@"image":@"yuliujinZhidingjihua"},
                     @{@"name":@"rateYijiesuan",@"image":@"rateYijiesuan"},
                     @{@"name":@"arrowSubmitDetail",@"image":@"arrowSubmitDetail"},
                     @{@"name":@"taskXuanzeshjianLoading",@"image":@"taskXuanzeshjianLoading"},
                     @{@"name":@"dayHasHankanri",@"image":@"dayHasHankanri"},nil];
    NSArray *style = [NSArray arrayWithObjects:
                     @{@"name":@"kapianguanliAlipay",@"image":@"kapianguanliAlipay"},
                     @{@"name":@"efreshStopZhangdanjine",@"image":@"efreshStopZhangdanjine"},
                     @{@"name":@"category_qvYangkajigouAdd",@"image":@"category_qvYangkajigouAdd"},
                     @{@"name":@"liebianrenshuZhangdanriLiebianrenshu",@"image":@"liebianrenshuZhangdanriLiebianrenshu"},
                     @{@"name":@"reasonCleanEfresh",@"image":@"reasonCleanEfresh"},
                     @{@"name":@"listNext",@"image":@"listNext"},nil];
    NSArray *done = [NSArray arrayWithObjects:
                     @{@"name":@"locationJihuajine",@"image":@"locationJihuajine"},
                     @{@"name":@"navigationOrigin",@"image":@"navigationOrigin"},
                     @{@"name":@"danrixianeForgetAnimate",@"image":@"danrixianeForgetAnimate"},
                     @{@"name":@"drawXuanzeshjianMask",@"image":@"drawXuanzeshjianMask"},
                     @{@"name":@"signWidthUppot",@"image":@"signWidthUppot"},nil];
    NSArray *package = [NSArray arrayWithObjects:
                     @{@"name":@"fanmianToolQiandao",@"image":@"fanmianToolQiandao"},
                     @{@"name":@"limitCollectPwd",@"image":@"limitCollectPwd"},
                     @{@"name":@"stringHankanriTwo",@"image":@"stringHankanriTwo"},
                     @{@"name":@"cameraStore",@"image":@"cameraStore"},
                     @{@"name":@"weixinHexPingtaizhidu",@"image":@"weixinHexPingtaizhidu"},
                     @{@"name":@"divCleanTishi",@"image":@"divCleanTishi"},nil];
    NSArray *channel = [NSArray arrayWithObjects:
                     @{@"name":@"xuanzediqvBenyuejiaoyiliang",@"image":@"xuanzediqvBenyuejiaoyiliang"},
                     @{@"name":@"canshuQcode",@"image":@"canshuQcode"},
                     @{@"name":@"alertIconCid",@"image":@"alertIconCid"},
                     @{@"name":@"imgQcode",@"image":@"imgQcode"},
                     @{@"name":@"unbindWeek",@"image":@"unbindWeek"},
                     @{@"name":@"listKetixian",@"image":@"listKetixian"},nil];
    NSArray *scroll = [NSArray arrayWithObjects:
                      @{@"name":@"pingtaizhiduRticleInterval_u",@"image":@"pingtaizhiduRticleInterval_u"},
                      @{@"name":@"backXplainHuankuancishu",@"image":@"backXplainHuankuancishu"},
                      @{@"name":@"interval_dShouru",@"image":@"interval_dShouru"},
                      @{@"name":@"sliderTime_1Imv",@"image":@"sliderTime_1Imv"},nil];
    NSArray *trading = [NSArray arrayWithObjects:
                      @{@"name":@"borderHuxukaPhoto",@"image":@"borderHuxukaPhoto"},
                      @{@"name":@"configMine",@"image":@"configMine"},
                      @{@"name":@"animatePackageShezhi",@"image":@"animatePackageShezhi"},
                      @{@"name":@"nlineIrcle",@"image":@"nlineIrcle"},
                      @{@"name":@"shoukuanrenUnbind",@"image":@"shoukuanrenUnbind"},
                      @{@"name":@"tintJiaoyijineSlip",@"image":@"tintJiaoyijineSlip"},nil];
    NSArray *maget = [NSArray arrayWithObjects:
                      @{@"name":@"nickButtom",@"image":@"nickButtom"},
                      @{@"name":@"zaixiankefublockRticlesNick",@"image":@"zaixiankefublockRticlesNick"},
                      @{@"name":@"cameraStore",@"image":@"cameraStore"},
                      @{@"name":@"arrowsArrowsMiddle",@"image":@"arrowsArrowsMiddle"},
                      @{@"name":@"nthUnbind",@"image":@"nthUnbind"},
                      @{@"name":@"applogoControl",@"image":@"applogoControl"},
                      @{@"name":@"egmentErsionBlue",@"image":@"egmentErsionBlue"},nil];
    NSArray *xuanzeshjian = [NSArray arrayWithObjects:
                      @{@"name":@"jihuajineSection",@"image":@"jihuajineSection"},
                      @{@"name":@"category_lgHuabeiOffset",@"image":@"category_lgHuabeiOffset"},
                      @{@"name":@"teamTeam",@"image":@"teamTeam"},
                      @{@"name":@"reviewColor",@"image":@"reviewColor"},
                      @{@"name":@"detailShiming",@"image":@"detailShiming"},
                      @{@"name":@"yijiesuanChangeLaunch",@"image":@"yijiesuanChangeLaunch"},nil];
    
    self.dataArr = [NSArray arrayWithObjects:orgetj,result,banner,yijiesuanG,shouru,key,style,done,package,channel,scroll,trading,maget,xuanzeshjian,nil];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(100);
        make.left.offset(0);
        make.top.equalTo(self.view.mas_top);
        make.bottom.offset(-KBottomHeight);
    }];
    [self.tableView reloadData];
    
    [self.view addSubview:self.day];
    [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(DEVICE_WIDTH);
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.equalTo(self.tableView.mas_right);
        make.right.offset(0);
        make.bottom.offset(-KBottomHeight);
    }];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}


@end
