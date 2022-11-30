
#import "xxzRticleRticlesController.h"
#import "xxzInsiToastView.h"

@interface xxzRticleRticlesController ()
@property (nonatomic, strong) xxzInsiToastView *shoukkuanblock;

@end

@implementation xxzRticleRticlesController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    


    

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (xxzInsiToastView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzInsiToastView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}



@end
