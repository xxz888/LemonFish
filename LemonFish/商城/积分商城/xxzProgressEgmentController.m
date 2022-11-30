
#import "xxzProgressEgmentController.h"
#import "xxzLoginView.h"
#import "xxzLabelFootController.h"
@interface xxzProgressEgmentController ()
@property (nonatomic, strong) xxzLoginView *shoukkuanblock;
@property (nonatomic , strong) NSArray *huankuanjineNum;
@end

@implementation xxzProgressEgmentController

-(void)getData{
    int liebianrenshu = arc4random() % 14 + 1;
    __weak typeof(self) weakSelf = self;

    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setObject:@"1" forKey:@"page"];
    [pass setObject:@"14" forKey:@"page_size"];
    [pass setObject:@"配饰" forKey:@"q"];
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/shop/api/getGood/search" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"status"] intValue] == 200) {
            self.huankuanjineNum = responseObject[@"content"];
          
            
            weakSelf.shoukkuanblock.item0Title.text = self.huankuanjineNum[0][@"jianjie"];
            weakSelf.shoukkuanblock.item0Price.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[0][@"coupon_info_money"]];
            weakSelf.shoukkuanblock.item0Score.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[0][@"size"]];
            [weakSelf.shoukkuanblock.item0Imv sd_setImageWithURL:self.huankuanjineNum[0][@"pict_url"]];
            [weakSelf setLine:weakSelf.shoukkuanblock.item0Price];
            
            weakSelf.shoukkuanblock.item1Title.text = self.huankuanjineNum[1][@"jianjie"];
            weakSelf.shoukkuanblock.item1Price.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[1][@"coupon_info_money"]];
            weakSelf.shoukkuanblock.item1Score.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[1][@"size"]];
            [weakSelf.shoukkuanblock.item1Imv sd_setImageWithURL:self.huankuanjineNum[1][@"pict_url"]];
            [weakSelf setLine:weakSelf.shoukkuanblock.item1Price];

            weakSelf.shoukkuanblock.item2Title.text = self.huankuanjineNum[2][@"jianjie"];
            weakSelf.shoukkuanblock.item2Price.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[2][@"coupon_info_money"]];
            weakSelf.shoukkuanblock.item2Score.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[2][@"size"]];
            [weakSelf.shoukkuanblock.item2Imv sd_setImageWithURL:self.huankuanjineNum[2][@"pict_url"]];
            [weakSelf setLine:weakSelf.shoukkuanblock.item2Price];

   
            weakSelf.shoukkuanblock.item3Title.text = self.huankuanjineNum[3][@"jianjie"];
            weakSelf.shoukkuanblock.item3Price.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[3][@"coupon_info_money"]];
            weakSelf.shoukkuanblock.item3Score.text = [NSString stringWithFormat:@"%@",self.huankuanjineNum[3][@"size"]];
            [weakSelf.shoukkuanblock.item3Imv sd_setImageWithURL:self.huankuanjineNum[3][@"pict_url"]];
            [weakSelf setLine:weakSelf.shoukkuanblock.item3Price];

            
           
   
        }
    } failure:^(NSString * _Nonnull error) {

    }];
}

- (xxzLoginView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzLoginView alloc] init];
    }
    return _shoukkuanblock;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self toLogin]) return;


}

-(void)setLine:(UILabel *)lbl{
    NSDictionary *info = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *medium = [[NSMutableAttributedString alloc]initWithString:lbl.text attributes:info];
    lbl.attributedText = medium;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;

    [self getData];
    
    [self.shoukkuanblock.qiandaoImv bk_whenTapped:^{
       
        [xxzBase showBottomWithText:@"今日已为你自动签到，请明天再签到"];

    }];
    
    
    
    [self.shoukkuanblock.view1 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = self.huankuanjineNum[0];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    
    [self.shoukkuanblock.view2 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = self.huankuanjineNum[1];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    
    [self.shoukkuanblock.view3 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = self.huankuanjineNum[2];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    
    [self.shoukkuanblock.view4 bk_whenTapped:^{
        xxzLabelFootController * scriptController = [[xxzLabelFootController alloc]init];
        scriptController.startDic = self.huankuanjineNum[3];
        [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    

}

@end
