
#import "xxzSuppotController.h"
#import "xxzUnicodeView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"

#import "xxzTradingController.h"
#import "xxzErsonController.h"

@interface xxzSuppotController ()
@property (nonatomic, strong) xxzUnicodeView *shoukkuanblock;

@end

@implementation xxzSuppotController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (xxzUnicodeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzUnicodeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}



@end
