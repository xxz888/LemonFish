
#import "xxzPackageController.h"
#import "xxzEpaymentView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"
#import "xxzOprationController.h"
#import "xxzHideController.h"
#import "xxzEmptyRticleController.h"
#import "xxzOginEmptyController.h"
#import "xxzOneyMainController.h"
#import "xxzProgressController.h"
#import "xxzTouchController.h"
#import "xxzConstXplainController.h"
#import "xxzOprationView.h"
#import "xxzSuppotController.h"
#import "xxzSettingController.h"
#import "xxzListController.h"
#import "MBProgressHUD.h"

@interface xxzPackageController ()
@property (nonatomic, strong) xxzEpaymentView *shoukkuanblock;

@end

@implementation xxzPackageController

- (xxzEpaymentView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzEpaymentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;


    
    
    
    
    [self.shoukkuanblock.saveBtn bk_whenTapped:^{
        NSDictionary * date = @{@"name":self.shoukkuanblock.nameTf.text,
                               @"phone":self.shoukkuanblock.phoneTf.text,
                               @"adress":self.shoukkuanblock.adressTf.text,
                               @"provice":self.shoukkuanblock.provinceTf.text
        };
        
        if (self.block) {
            [self.xp_rootNavigationController qmui_popViewControllerAnimated:YES completion:^{
                self.block(date);
            }];
          
        }
    }];
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}



@end
