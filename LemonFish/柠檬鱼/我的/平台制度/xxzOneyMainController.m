
#import "xxzOneyMainController.h"
#import "xxzHomeUpdateView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"

#import "xxzTradingController.h"
#import "xxzErsonController.h"

@interface xxzOneyMainController ()
@property (nonatomic, strong) xxzHomeUpdateView *shoukkuanblock;

@end

@implementation xxzOneyMainController


-(void)getStatistics{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];
 
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * oney= responseObject[@"data"];
            weakSelf.shoukkuanblock.contentText.text = oney[@"regime"];

        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
  
}


- (xxzHomeUpdateView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzHomeUpdateView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.tableHeaderView.height = 700;


    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
  [self getStatistics];
}



@end
