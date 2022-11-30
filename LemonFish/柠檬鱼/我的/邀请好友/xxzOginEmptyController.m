
#import "xxzOginEmptyController.h"

@interface xxzOginEmptyController ()

@end

@implementation xxzOginEmptyController


- (void)saveAction{
    
    [self.baocun_btn bk_whenTapped:^{
        self.nav_back.hidden = self.baocun_btn.hidden = self.closeBtn.hidden = YES;
        
        [self.content_image setNeedsLayout];
        [self.content_image layoutIfNeeded];
        UIImage *huankuanblockImage = [self.view captureImageFromView:self.view];
        UIImageWriteToSavedPhotosAlbum(huankuanblockImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:), nil);
    }];
    [self.closeBtn bk_whenTapped:^{
        [self.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    [self.nav_back bk_whenTapped:^{
        [self.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
}


#pragma 获取版本信息

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.mc_tableview removeFromSuperview];
    [self saveAction];
    [self getVersionData];
    [self addCount];
    
    self.codeTop.constant = kScreenHeight * 170/926;
    NSLog(@"%f",kScreenHeight * 170/926);
}



- (void)loadUI{

    
    [self.bg_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.offset(-KBottomHeight);
    }];
    [self.navigation_View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH, 44));
        make.top.equalTo(self.bg_image.mas_top).offset(kStatusBarHeight);
        make.left.equalTo(self.view);
    }];
    [self.nav_back setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    [self.nav_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.equalTo(self.navigation_View);
    }];
    [self.nav_back bk_whenTapped:^{
        [self.xp_rootNavigationController popViewControllerAnimated:YES];
    }];
    
    [self.content_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset( (DEVICE_HEIGHT-450) / 2 - 20);
        make.centerX.equalTo(self.view);
    }];
    [self.content_image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.offset(0);

    }];

    
    [self.QrCode_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(130, 130));
        make.centerX.equalTo(self.content_image);
        make.top.equalTo(self.content_image.mas_top).offset(215);
    }];
    
    
    
    [self.baocun_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(260, 40));
        make.top.equalTo(self.content_image.mas_bottom).offset(RatioH(20));
        make.centerX.equalTo(self.content_image);
    }];
    
}
- (void)addCount{
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/material/add/share/count" Params:@{@"id":self.currentId} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
         
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    
}
- (void)getVersionData{
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/app/config/get" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * oney= responseObject[@"data"];
            
            NSDictionary *huabeiblock = [self loadUserData];
            NSString *qianyuetongdao = [NSString stringWithFormat:@"%@?userId=%@",oney[@"shareUrl"],huabeiblock[@"id"]];
            
            self.QrCode_img.image = [UIImage createQRCodeWithTargetString:qianyuetongdao logoImage:nil];
        }
    } failure:^(NSString * _Nonnull error) {

    }];
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}




- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        self.nav_back.hidden = self.baocun_btn.hidden = self.closeBtn.hidden = NO;

        [xxzBase showBottomWithText:@"保存成功"];
    }
}

@end
