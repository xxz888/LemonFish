
#import "xxzControlToolController.h"
#import "xxzProgressView.h"
#import "xxzOprationCell.h"
#import "xxzNewsAlendarController.h"

@interface xxzControlToolController ()<QMUITableViewDelegate,QMUITableViewDataSource>
@property (nonatomic, strong) xxzProgressView *shoukkuanblock;
@property (nonatomic, strong) NSString * type;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator;
@property (nonatomic, strong) NSDictionary * tableview;

@end

@implementation xxzControlToolController


- (void)viewDidLoad {
    [super viewDidLoad];
  
}


- (xxzProgressView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _shoukkuanblock;
}


@end
