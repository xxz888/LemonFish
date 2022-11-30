
#import "xxzEmptyRticleController.h"
#import "xxzTableSettingView.h"
#import "xxzBoutRticlesController.h"
#import "UIButton+WebCache.h"
#import "xxzBaseEceiveController.h"

#import "xxzTradingController.h"
#import "xxzErsonController.h"

@interface xxzEmptyRticleController ()
@property (nonatomic, strong) xxzTableSettingView *shoukkuanblock;

@end

@implementation xxzEmptyRticleController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getStatistics];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    


    

}

- (xxzTableSettingView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzTableSettingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

-(void)getStatistics{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblock = [self loadUserData];
 
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/self/config" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary  * date = responseObject[@"data"];
            weakSelf.shoukkuanblock.guiguangContent.text = date[@"title"];
            
            weakSelf.shoukkuanblock.lbl1.text = [NSString stringWithFormat:@"1、%@",date[@"fastRate"]];
            weakSelf.shoukkuanblock.lbl2.text = [NSString stringWithFormat:@"2、%@",date[@"settleRate"]];
            weakSelf.shoukkuanblock.lbl3.text = [NSString stringWithFormat:@"3、%@",date[@"huabeiRate"]];
            weakSelf.shoukkuanblock.lbl4.text = [NSString stringWithFormat:@"4、%@",date[@"fastRateDesc"]];
            weakSelf.shoukkuanblock.lbl5.text = [NSString stringWithFormat:@"5、%@",date[@"settleRateDesc"]];
            weakSelf.shoukkuanblock.lbl6.text = [NSString stringWithFormat:@"6、%@",date[@"huabeiRateDesc"]];


        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    

    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:[NSString stringWithFormat:@"/api/user/get/%@",huabeiblock[@"id"]] Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            
            NSString * i_count = @"";
            if ([responseObject[@"data"][@"selfLevel"] intValue] == 0) {
                i_count = @"请先实名";
                weakSelf.shoukkuanblock.headName.text = [NSString stringWithFormat:@"%@",i_count];

            }else{
                if (responseObject[@"data"][@"nick"]) {
                    i_count = responseObject[@"data"][@"nick"];
                }else{
                    i_count = responseObject[@"data"][@"fullname"];
                }
                weakSelf.shoukkuanblock.headName.text = [NSString stringWithFormat:@"Hi~,%@",i_count];

            }
            
            

            
            
            
            weakSelf.shoukkuanblock.headLv.text = [responseObject[@"data"][@"selfLevel"] integerValue] == 0 ? @"普通" : @"会员";
            [weakSelf.shoukkuanblock.headImv sd_setImageWithURL:[NSURL URLWithString:responseObject[@"data"][@"avatar"]] placeholderImage:[UIImage imageNamed:@"empowerYangkajigou"]];

        }
 
    } failure:^(NSString * _Nonnull error) {
        
    }];
}



@end
