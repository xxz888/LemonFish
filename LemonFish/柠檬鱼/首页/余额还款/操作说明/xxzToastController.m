
#import "xxzToastController.h"
#import "xxzConfirmToolView.h"

@interface xxzToastController ()
@property (nonatomic, strong) xxzConfirmToolView *shoukkuanblock;

@end

@implementation xxzToastController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    


    

}


- (xxzConfirmToolView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzConfirmToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}



@end
