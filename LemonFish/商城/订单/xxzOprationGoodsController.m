
#import "xxzOprationGoodsController.h"
#import "xxzAddressView.h"
#import "xxzDrawFormatterCell.h"
#import "xxzBoutRticlesController.h"

@interface xxzOprationGoodsController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzAddressView *shoukkuanblock;
@property (nonatomic , strong) NSArray *huankuanjineNum;
@property (nonatomic , strong)NSString * type;
@property (nonatomic , strong) NSMutableArray * dataArr;

@end

@implementation xxzOprationGoodsController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    xxzDrawFormatterCell *yitixianCell = [xxzDrawFormatterCell cellWithTableView:tableView];
    NSDictionary * date = self.huankuanjineNum[indexPath.row];
    
        [yitixianCell.cellImv sd_setImageWithURL:date[@"pict_url"]];
        yitixianCell.cellTitle.text = date[@"title"];
        yitixianCell.cellSize.text = date[@"coupon_info"];
        yitixianCell.cellPrice.text = date[@"size"];
        yitixianCell.statusLbl.text = date[@"status"];
        yitixianCell.titleLbl.text = date[@"shop_title"];

    return yitixianCell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dateo = self.huankuanjineNum[indexPath.row];

    if ([dateo[@"status"] isEqualToString:@"待支付"]) {
        NSMutableDictionary *dateo = [NSMutableDictionary dictionary];
        [dateo setObject:[NSString stringWithFormat:@"%.2f",[dateo[@"size"] doubleValue]] forKey:@"amount"];
        [dateo setObject:@"0" forKey:@"type"];

        [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/payment/invest/shop/temp" Params:dateo success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                
                
                NSString *showed = @"LFAlipay";
                
                NSString *move = responseObject[@"data"];
                
                [[AlipaySDK defaultService] payOrder:move fromScheme:showed callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
                    if([resultDic[@"resultStatus"] integerValue] == 4000){
                        [xxzBase showBottomWithText:@"调取支付宝支付失败，请检查是否安装支付宝"];
                    }
                }];
            }
        } failure:^(NSString * _Nonnull error) {

        }];

        
    }
}


-(void)setLish{

}

-(void)getData{
    int liebianrenshu = arc4random() % 14 + 1;
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:@"1" forKey:@"page"];
    [pass setObject:@"6" forKey:@"page_size"];
    [pass setObject:@"手机数码" forKey:@"q"];
    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/shop/api/getGood/search" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {

   
        }
    } failure:^(NSString * _Nonnull error) {

    }];
}

- (xxzAddressView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzAddressView alloc] init];
    }
    return _shoukkuanblock;
}

#pragma mark - QMUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
 
    return [self.huankuanjineNum count];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.delegate = self;
    self.mc_tableview.dataSource = self;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzDrawFormatterCell" bundle:nil] forCellReuseIdentifier:@"xxzDrawFormatterCell"];
    self.dataArr = [[NSMutableArray alloc]init];
    self.type = @"全部";
    self.huankuanjineNum = @[
        @{@"title":@"水活力紧致面霜，焕活紧实水嫩皮肤",
          @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/44.jpg",
          @"coupon_info":@"满200减50",
          @"size":@"479",
          @"status":@"待支付",
          @"shop_title":@"杭州自营店",
          @"tao_id": @"680855804671",
        },
  

    ];
    [self.mc_tableview reloadData];

    [self getData];
    
    [self setLish];
    
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    __weak typeof(self) weakSelf = self;

    [self.shoukkuanblock.tab1 bk_whenTapped:^{
        weakSelf.type = @"全部";
        self.huankuanjineNum = @[
            @{@"title":@"水活力紧致面霜，焕活紧实水嫩皮肤",
              @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/44.jpg",
              @"coupon_info":@"满200减50",
              @"size":@"479",
              @"status":@"待支付",
              @"shop_title":@"杭州自营店",
              @"tao_id": @"680855804671",
            },
           ];
        
        [weakSelf.mc_tableview reloadData];
    }];
    [self.shoukkuanblock.tab2 bk_whenTapped:^{
        weakSelf.type = @"待支付";
        self.huankuanjineNum = @[
            @{@"title":@"水活力紧致面霜，焕活紧实水嫩皮肤",
              @"pict_url":@"https://kashijian.oss-cn-hangzhou.aliyuncs.com/44.jpg",
              @"coupon_info":@"满200减50",
              @"size":@"479",
              @"status":@"待支付",
              @"shop_title":@"杭州自营店",
              @"tao_id": @"680855804671",
            },
      
        ];
        [weakSelf.mc_tableview reloadData];
    }];
    [self.shoukkuanblock.tab3 bk_whenTapped:^{
        self.huankuanjineNum =  @[
           ],
        weakSelf.type = @"待发货";
        [weakSelf.mc_tableview reloadData];
    }];
    [self.shoukkuanblock.tab4 bk_whenTapped:^{
        weakSelf.type = @"已发货";
   
        self.huankuanjineNum =    @[
            @{

            }
        ];
        [weakSelf.mc_tableview reloadData];
    }];
    [self.shoukkuanblock.tab5 bk_whenTapped:^{
        weakSelf.type = @"已完成";
        self.huankuanjineNum =  @[
            @{

            }];
        [weakSelf.mc_tableview reloadData];
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self toLogin]) return;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 191;
}
@end
