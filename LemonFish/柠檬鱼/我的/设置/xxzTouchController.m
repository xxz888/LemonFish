
#import "xxzTouchController.h"
#import "xxzCenterMageView.h"
#import "xxzConstXplainController.h"
#import "xxzOprationView.h"
#import "xxzConstController.h"
#import "xxzScriptController.h"

#import "SDImageCache.h"
#import "xxzTabbarView.h"


@interface xxzTouchController ()
@property (nonatomic, strong) xxzCenterMageView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * tishi;
@property (nonatomic, strong) NSString * yitixian;


@end

@implementation xxzTouchController


-(void)addVersionUpdata:(NSDictionary *)data{

    
    xxzTabbarView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzTabbarView class]) owner:nil options:nil] lastObject];
    NSDictionary *nav = [[NSBundle mainBundle] infoDictionary];
    NSString  *main_n = [nav objectForKey:@"CFBundleShortVersionString"];
    
    LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                  popStyle:LSTPopStyleSpringFromTop
                                              dismissStyle:LSTDismissStyleSmoothToTop];
    
    jihuajine.currentVersion.text = [NSString stringWithFormat:@"当前版本:%@",main_n];
    jihuajine.storeVersion.text = [NSString stringWithFormat:@"当前版本:%@",data[@"iosVersion"]];
    
    if ([data[@"iosContent"] length] > 0) {
        jihuajine.versionContent.text =  [data[@"iosContent"] stringByReplacingOccurrencesOfString:@"&" withString:@"\n"];
    }else{
        jihuajine.versionContent.text = @"1、修复已知BUG ;\n2、优化用户体验";
    }
    
    LSTPopViewWK(xplainView);
        [jihuajine.closeBtn bk_whenTapped:^{
            [wk_xplainView dismiss];
        }];
    
    [jihuajine.updateBtn bk_whenTapped:^{
          [wk_xplainView dismiss];
        
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:data[@"iosUrl"]] options:@{} completionHandler:nil];
    }];
 
    [xplainView pop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    

    __weak typeof(self) weakSelf = self;

    CGFloat unicode =  [self filePath];
   
    self.shoukkuanblock.cacheLbl.text = [NSString stringWithFormat:@"%.2fM",unicode];
    
    
    self.shoukkuanblock.versionLbl.text = [NSString stringWithFormat:@"%@",[self getAppVersionName]];
    [self.shoukkuanblock.cacheView bk_whenTapped:^{
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
        }];
        [[SDImageCache sharedImageCache] clearMemory];
        self.shoukkuanblock.cacheLbl.text = @"0M";
    }];
    
    
    [self.shoukkuanblock.changePhoneView bk_whenTapped:^{
        [weakSelf.xp_rootNavigationController pushViewController:[xxzScriptController new
                                                                 ] animated:YES];
        
    }];
    
    
    [self.shoukkuanblock.setPsdView bk_whenTapped:^{
        [weakSelf.xp_rootNavigationController pushViewController:[xxzConstController new
                                                                 ] animated:YES];
        
    }];
    
    [self.shoukkuanblock.versionView bk_whenTapped:^{
        
        
        
        [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                NSDictionary * oney= responseObject[@"data"];
                NSDictionary *navK = [[NSBundle mainBundle] infoDictionary];
                self.yitixian = oney[@"serviceUrl"];
                
                NSString  *main_n4 = [navK objectForKey:@"CFBundleShortVersionString"];
                NSString * slider = [main_n4 stringByReplacingOccurrencesOfString:@"." withString:@""];
                NSString * one5 = [[oney[@"iosVersion"] stringValue] stringByReplacingOccurrencesOfString:@"." withString:@""];
                if (![[oney[@"iosVersion"] stringValue] isEqualToString:main_n4] && [slider integerValue] < [one5 integerValue]) {
                    [weakSelf addVersionUpdata:oney];
                }else{
                    [xxzBase showBottomWithText:@"已经是最新版本"];
                }
            }
        } failure:^(NSString * _Nonnull error) {

        }];
        
        
        
        
        

        
        
        
    }];
    [self.shoukkuanblock.offWxBtn bk_whenTapped:^{
       
        
        
        xxzOprationView *jihuajine4 = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzOprationView class]) owner:nil options:nil] lastObject];
        
        [jihuajine4.codeImv sd_setImageWithURL:weakSelf.tishi[@"weixinCode"]];
        
        
        LSTPopView *xplainViewQ = [LSTPopView initWithCustomView:jihuajine4
                                                      popStyle:LSTPopStyleSpringFromTop
                                                  dismissStyle:LSTDismissStyleSmoothToTop];
        LSTPopViewWK(xplainViewQ);
            [jihuajine4.closeBtn bk_whenTapped:^{
                [wk_xplainViewQ dismiss];
            
            }];
     
        [xplainViewQ pop];
        
        
        
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
            NSDictionary * oneyI= responseObject[@"data"];
          
            self.yitixian = oneyI[@"serviceUrl"];
        
        }
    } failure:^(NSString * _Nonnull error) {

    }];
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getService];
}

- (xxzCenterMageView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzCenterMageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

 

 

 


- ( long long ) fileSizeAtPath:( NSString *) filePath{

    

    NSFileManager * manager = [ NSFileManager defaultManager ];

    

    if ([manager fileExistsAtPath :filePath]){

        

        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];

        

    }

    

    return 0 ;

    

}

 


 

- ( float ) folderSizeAtPath:( NSString *) folderPath{

    

    NSFileManager * manager = [ NSFileManager defaultManager ];

    

    if (![manager fileExistsAtPath :folderPath]) return 0 ;

    

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];

    

    NSString * fileName;

    

    long long folderSize = 0 ;

    

    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){

        

        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];

        

        folderSize += [ self fileSizeAtPath :fileAbsolutePath];

        

    }

    

    return folderSize/( 1024.0 * 1024.0 );

    

}

 

- ( float )filePath

 

{

    

    NSString * div = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];

    

    return [ self folderSizeAtPath :div];

    

}

- (NSString *)getAppVersionCode {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)getAppVersionName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}



@end
