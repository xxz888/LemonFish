
#import "xxzPackageNameController.h"
#import "xxzMageCell.h"
#import "xxzLabelFootController.h"
@interface xxzPackageNameController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UICollectionView *day;

@property (nonatomic , strong) NSMutableArray *huankuanjineNum;
@property (nonatomic , assign) int page;

@end

@implementation xxzPackageNameController

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.huankuanjineNum.count;
}


- (void)loadData{
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:@(self.page) forKey:@"page"];
    [pass setObject:@"14" forKey:@"page_size"];
    [pass setObject:self.requestString forKey:@"q"];
    @weakify(self);
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/shop/api/getGood/search" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *suppot = responseObject[@"content"];
            if (weak_self.page == 1) {
                weak_self.huankuanjineNum = [NSMutableArray arrayWithArray:suppot];
                [self.day.mj_footer endRefreshing];
            }else {
                
                if (![suppot count]) {
                    [self.day.mj_footer endRefreshingWithNoMoreData];
                }
                [weak_self.huankuanjineNum addObjectsFromArray:suppot];
            }
            [self.day reloadData];
        }
    } failure:^(NSString * _Nonnull error) {

    }];
}

#pragma 搜索

- (UICollectionView *)day{
    if (!_day) {
        
        CGFloat interval_ol = (DEVICE_WIDTH - 15) / 2;
        
        
        UICollectionViewFlowLayout *magnification = [UICollectionViewFlowLayout new];
        magnification.scrollDirection = UICollectionViewScrollDirectionVertical;
        magnification.minimumInteritemSpacing = 5;
        magnification.minimumLineSpacing = 5;
        magnification.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        magnification.itemSize = CGSizeMake(interval_ol,220);
        
        _day = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:magnification];
        _day.backgroundColor = [UIColor whiteColor];
        _day.showsVerticalScrollIndicator = NO;
        
        [self.day registerNib:[UINib nibWithNibName:@"xxzMageCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        _day.delegate = self;
        _day.dataSource = self;
        
        @weakify(self);
        _day.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            weak_self.page = 1;
            [weak_self loadData];
            [weak_self.day.mj_header endRefreshing];
           }];
        _day.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weak_self.page ++;
            [weak_self loadData];
            [weak_self.day.mj_footer endRefreshing];
        }];
    }
    return _day;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *danrixiane = @"cell";
    xxzMageCell *yitixianCell= [collectionView dequeueReusableCellWithReuseIdentifier:danrixiane forIndexPath:indexPath];
    
    
    NSDictionary *oney = self.huankuanjineNum[indexPath.row];
    
    [yitixianCell.top_image sd_setImageWithURL:oney[@"pict_url"] placeholderImage:[UIImage imageNamed:@"mall_Placeholder_image"]];
    
    yitixianCell.title_lab.text = oney[@"title"];
    
    
    NSString *buffer = [NSString stringWithFormat:@"¥%@",oney[@"size"]];
    
    NSString *stroke = [NSString stringWithFormat:@"%@",oney[@"volume"]];
    
    yitixianCell.content_lab.attributedText =  [UILabel setupAttributeString:[NSString stringWithFormat:@"%@ %@人付款",buffer,stroke] rangeText:buffer textColor:[UIColor colorWithHexString:@"#FF8100"] textFont:[UIFont getUIFontSize:18 IsBold:NO]];
    
   
    return yitixianCell;
}
#pragma mark - UICollectionViewDataSource

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.requestString;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *oneyA = self.huankuanjineNum[indexPath.row];
    
    
    xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
    scriptController.startDic = oneyA;
    [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    
    

}


#pragma mark - UICollectionViewDelegate

- (void)LoadUI{
    [self.view addSubview:self.day];
    [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(DEVICE_WIDTH);
        make.top.offset(0);
        make.left.offset(0);
        make.bottom.offset(-KBottomHeight);
    }];
}


#pragma 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mc_tableview removeFromSuperview];
    self.view.backgroundColor = [UIColor whiteColor];
    self.page = 1;
    [self LoadUI];
    [self loadData];
}

@end
