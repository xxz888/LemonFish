
#import "xxzPrefixConfigController.h"

@interface xxzPrefixConfigController ()

@end

@implementation xxzPrefixConfigController


- (void)setRead{
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/msg/set/read" Params:@{@"id":[NSString stringWithFormat:@"%@",self.startDic[@"id"]],@"type":self.type} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
    
            
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    
}


#pragma 获取版本信息

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mc_tableview removeFromSuperview];
    
    self.cellTitle.text = self.startDic[@"title"];
    self.cellContent.text = [NSString stringWithFormat:@"\n%@\n",self.startDic[@"msg"]];
    self.cellTime.text = self.startDic[@"createTime"];

    [self.nav_back bk_whenTapped:^{
        [self.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
}






- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
