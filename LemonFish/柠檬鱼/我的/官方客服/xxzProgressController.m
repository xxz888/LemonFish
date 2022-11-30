
#import "xxzProgressController.h"
#import "xxzIrcleView.h"
#import "xxzConstXplainController.h"
#import "xxzOprationView.h"
#import "xxzSizeCategoryView.h"

@interface xxzProgressController ()
@property (nonatomic, strong) xxzIrcleView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * tishi;
@property (nonatomic, strong) NSString * yitixian;


@end

@implementation xxzProgressController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    

    __weak typeof(self) weakSelf = self;

    [self.shoukkuanblock.phoneBtn bk_whenTapped:^{
        NSString *call = self.tishi[@"phone"];
        NSMutableString * qianyuetongdao=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",call];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:qianyuetongdao]];
    }];
    
    [self.shoukkuanblock.wxBtn bk_whenTapped:^{
        
        
        
        
        
        NSURL * resultd = [NSURL URLWithString:@"wechat://"];
        BOOL medium = [[UIApplication sharedApplication] canOpenURL:resultd];
        
        if (medium){
            
            xxzSizeCategoryView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzSizeCategoryView class]) owner:nil options:nil] lastObject];

            
            LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                          popStyle:LSTPopStyleSpringFromTop
                                                      dismissStyle:LSTDismissStyleSmoothToTop];
            
            jihuajine.wxLbl.text =   [NSString stringWithFormat:@"%@",self.tishi[@"wechatNumber"]];
            LSTPopViewWK(xplainView);
                [jihuajine.closeBtn bk_whenTapped:^{
                    [wk_xplainView dismiss];
                }];
         
            
            [jihuajine.btnCopy bk_whenTapped:^{
                UIPasteboard.generalPasteboard.string = [NSString stringWithFormat:@"%@",weakSelf.tishi[@"wechatNumber"]];
                [xxzBase showBottomWithText:@"文案已复制到剪切板"];
                [wk_xplainView dismiss];
            }];
            [xplainView pop];
            
            
            
        }else {
            [xxzBase showBottomWithText:@"您的设备未安装微信APP"];
        }
        

        
    }];

    
    [self.shoukkuanblock.cellCall bk_whenTapped:^{
        xxzConstXplainController * scriptController = [[xxzConstXplainController alloc]init];
        scriptController.navTitle = @"在线客服";
        scriptController.url = weakSelf.yitixian;
        [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
    }];
    
    [self.shoukkuanblock.offWxBtn bk_whenTapped:^{
       
        
        
        xxzOprationView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzOprationView class]) owner:nil options:nil] lastObject];
        
        [jihuajine.codeImv sd_setImageWithURL:weakSelf.tishi[@"weixinCode"]];
        
        
        LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                      popStyle:LSTPopStyleSpringFromTop
                                                  dismissStyle:LSTDismissStyleSmoothToTop];
        LSTPopViewWK(xplainView);
            [jihuajine.closeBtn bk_whenTapped:^{
                [wk_xplainView dismiss];
            
            }];
     
        [xplainView pop];
        
        
        
    }];
}


-(void)getService{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];

    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/service/url" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary  * date = responseObject[@"data"];
            weakSelf.tishi = date;
            weakSelf.shoukkuanblock.cellName.text = date[@"nick"];
            [weakSelf.shoukkuanblock.cellImv sd_setImageWithURL:[NSURL URLWithString:date[@"avatar"]] placeholderImage:[UIImage imageNamed:@"empowerYangkajigou"]];
            weakSelf.shoukkuanblock.cellPhone.text = date[@"phone"];
            weakSelf.shoukkuanblock.cellContent.text = date[@"title"];
 


        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    

    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * oney= responseObject[@"data"];
          
            self.yitixian = oney[@"serviceUrl"];
        
        }
    } failure:^(NSString * _Nonnull error) {

    }];
}

- (xxzIrcleView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzIrcleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getService];
}



@end
