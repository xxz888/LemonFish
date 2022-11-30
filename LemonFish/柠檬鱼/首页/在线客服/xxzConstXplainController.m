
#import "xxzConstXplainController.h"
#import "xxzScreenView.h"


@interface xxzConstXplainController ()
@property (nonatomic, strong) xxzScreenView *shoukkuanblock;
@end

@implementation xxzConstXplainController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.shoukkuanblock.navTitle.text = self.navTitle;
    self.mc_tableview.tableHeaderView.height = kScreenHeight;
    
    WKWebView *buy = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
    buy.backgroundColor = [UIColor whiteColor];
    [self.shoukkuanblock.otherView addSubview:buy];

    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.bottom.offset(-KBottomHeight);
    }];
    
    NSString *result = self.url;
    NSURLRequest *total = [NSURLRequest requestWithURL:[NSURL URLWithString:result]];
    [buy loadRequest:total];

    
   
    
}





- (xxzScreenView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzScreenView alloc] init];
    }
    return _shoukkuanblock;
}

@end
