
#import "xxzUpdateController.h"

@interface xxzUpdateController ()

@end

@implementation xxzUpdateController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"在线客服";
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * oney= responseObject[@"data"];
     
            
            
            WKWebView *buy = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
            buy.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:buy];
            
            [buy mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.right.offset(0);
                make.bottom.offset(-KBottomHeight);
            }];
            
            NSString *result = oney[@"serviceUrl"];
            NSURLRequest *total = [NSURLRequest requestWithURL:[NSURL URLWithString:result]];
            [buy loadRequest:total];

        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    
    
   
    
}



@end
