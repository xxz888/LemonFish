
#import "xxzCodeVeryController.h"
#import "xxzConstView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"
#import "xxzVeryController.h"
#import "xxzSizeCategoryView.h"

#import "xxzTradingController.h"
#import "xxzStyleServerView.h"

#import "xxzSettingController.h"
#import "xxzConfirmToolsController.h"
@interface xxzCodeVeryController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzConstView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * subOrget;
@property (nonatomic, strong) NSDictionary * shouxufeiCvn;
@property (nonatomic, strong) NSDictionary * outsideAnimate;
@property (nonatomic, strong) NSString * danbixiane;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSMutableArray * nlineEfresh;
@property (nonatomic, strong) NSMutableArray * tixianjine;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) xxzStyleServerView * titleview;

@end

@implementation xxzCodeVeryController


-(void)requestRegisterPre{
    if (self.shoukkuanblock.searchTf.text.length != 11 ) {
        [xxzBase showBottomWithText:@"请输入正确的手机号码" duration:2];
        return;
    }
    [self.view endEditing:YES];
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *date = [NSMutableDictionary dictionary];
    [date setValue:self.shoukkuanblock.searchTf.text forKey:@"phone"];
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/pre/register" Params:date success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            xxzSettingController *scriptController = [xxzSettingController new];
            scriptController.empowerToken = responseObject[@"data"];
            [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}






-(void)setUnSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:0];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    line.hidden = YES;
    
}

-(void)setSelectStatus:(UIButton *)btn line:(UIView *)line{
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:0];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    line.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;


    __weak __typeof(self)weakSelf = self;



    self.mc_tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-100);

    self.titleview = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzStyleServerView class]) owner:nil options:nil] lastObject];

    [self.titleview.submitBtn setTitle:@"  下一步" forState:UIControlStateNormal];
    [self.titleview.submitBtn setImage:[UIImage imageNamed:@"titlesZixun"] forState:0];
    self.titleview.frame = CGRectMake(0, kScreenHeight - 100, kScreenWidth, 100);
    [self.view addSubview:self.titleview];
    
    
    [self.titleview.submitBtn bk_whenTapped:^{
        [weakSelf requestRegisterPre];
    }];
}


- (xxzConstView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzConstView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}



@end
