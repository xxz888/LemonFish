
#import "xxzHuxukaHandlerController.h"
#import "xxzShopEnlargeView.h"


@interface xxzHuxukaHandlerController ()
@property (nonatomic, strong) xxzShopEnlargeView *shoukkuanblock;
@end

@implementation xxzHuxukaHandlerController


- (xxzShopEnlargeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzShopEnlargeView alloc] init];
    }
    return _shoukkuanblock;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    [self addCount];
}


- (void)addCount{
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/knowledge/add/read/count" Params:@{@"id":[NSString stringWithFormat:@"%@",self.startDic[@"id"]]} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
         
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.shoukkuanblock.navTitle.text = self.navTitle;
    self.mc_tableview.tableHeaderView.height = kScreenHeight;
    
    self.shoukkuanblock.tv.text = self.startDic[@"content"];
    self.shoukkuanblock.cellTitle.text = self.startDic[@"title"];
    
    self.shoukkuanblock.cellLbl1.text =  @"柠檬鱼";
    self.shoukkuanblock.cellLbl2.text = self.startDic[@"createTime"];
    self.shoukkuanblock.cellCount.text = [NSString stringWithFormat:@"%@",self.startDic[@"readCount"]];
    [self.shoukkuanblock.cellImg sd_setImageWithURL:[NSURL URLWithString:self.startDic[@"coverUrl"]]];
}

@end
