
#import "xxzSilderController.h"
#import "AppDelegate.h"
#import <CoreLocation/CLLocationManager.h>
#import "xxzListHandlerController.h"
#import "xxzSettingController.h"

@interface xxzSilderController ()<AMapLocationManagerDelegate>

@property (nonatomic , assign) BOOL l_superview;

@property (nonatomic, strong) AMapLocationManager *onselectedStatus;

@end

@implementation xxzSilderController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = self.mc_tableview.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    [self.navigationController.navigationBar setTranslucent:false];
    self.navigationController.navigationBar.hidden = YES;
    self.l_superview = NO;
    if (@available(iOS 11.0, *)) {
        self.mc_tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (float)randomBetween:(float)smallNum AndBigNum:(float)bigNum AndPrecision:(NSInteger)precision{
    
    float ime = bigNum - smallNum;
    
    ime = ABS(ime);
    
    ime *= precision;
    
    float changeimg = arc4random() % ((int) ime + 1);
    
    changeimg /= precision;
    
    float buy = MIN(smallNum, bigNum) + changeimg;
    
    return buy;
}

- (void)loginPastDue{
    
    if (!self.l_superview) {
        self.l_superview = YES;
        UIAlertController *font = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"登录已过期,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
        [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.l_superview = NO;
        }]];
        [font addAction:[UIAlertAction actionWithTitle:@"登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.l_superview = NO;
            
            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            xxzListHandlerController *originView = [[xxzListHandlerController alloc]init];
            xxzMainCardController *shouxufei = [[xxzMainCardController alloc]initWithRootViewController:originView];
            delegate.window.rootViewController = shouxufei;
        }]];
        [[UIViewController currentViewController] presentViewController:font animated:YES completion:^{}];
    }
    
}

- (void)layoutTableView {
    BOOL tuandui = !CGRectEqualToRect(self.view.bounds, _mc_tableview.frame);
    if (tuandui) {
        _mc_tableview.qmui_frameApplyTransform = self.view.bounds;
    }
}

- (void)setBubbleSortArray:(NSMutableArray *)dataArr FieldString:(NSString *)fieldStr{
    for (int i = 0; i < [dataArr count] ; i++) {
        for (int j = 0; j < [dataArr count] - i - 1; j++) {
            if ([dataArr[j][fieldStr] doubleValue] < [dataArr[j+1][fieldStr] doubleValue]) {
                NSDictionary *collectionview = dataArr[j];
                dataArr[j] = dataArr[j+1];
                dataArr[j+1] = collectionview;
            }
        }
    }
}



- (QMUITableView *)getMCTableView {
    return _mc_tableview;
}
#pragma mark - MCSessionManagerDelegate


- (BOOL)isEmpty:(id)object{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        return [object isEqualToString:@""];
    } else if ([object isKindOfClass:[NSNumber class]]) {
        return [object isEqualToNumber:@(0)];
    }
    return NO;
}


- (BOOL)CameraPermissions{
    AVAuthorizationStatus next = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (next == AVAuthorizationStatusNotDetermined || next == AVAuthorizationStatusRestricted || next == AVAuthorizationStatusDenied) {
        
        
        UIAlertController *zhengmianfanmian = [UIAlertController alertControllerWithTitle:@"是否开启相机访问权限？"
                                                                          message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *button = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *submit = [UIAlertAction actionWithTitle:@"去开启" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { 
            NSURL *result = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:result]) {
                [[UIApplication sharedApplication] openURL:result options:@{} completionHandler:^(BOOL success) {
                    
                }];
            }
        }];
        [zhengmianfanmian addAction:button];
        [zhengmianfanmian addAction:submit];
        [[UIViewController currentViewController] presentViewController:zhengmianfanmian animated:YES completion:nil];
        return NO;
    } else { 
        
        return YES;
    }
}











- (QMUITableView *)mc_tableview {
    if (!_mc_tableview) {
        _mc_tableview = [[QMUITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _mc_tableview.showsHorizontalScrollIndicator = NO;
        _mc_tableview.showsVerticalScrollIndicator = NO;
        
        
        _mc_tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(mc_tableviewRefresh)];
        [self.view addSubview:_mc_tableview];
        

    }
    return _mc_tableview;
}

- (BOOL)RealNameAuthentication{
    
    NSUserDefaults *lijitixian = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblock = [lijitixian objectForKey:@"UserData"];
    if (huabeiblock != nil && [huabeiblock[@"selfLevel"] intValue] == 0) {
        UIAlertController *fontu = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您的帐号还未实名，是否立即去实名？" preferredStyle:UIAlertControllerStyleAlert];
        [fontu addAction:[UIAlertAction actionWithTitle:@"暂不实名" style:UIAlertActionStyleCancel handler:nil]];
        [fontu addAction:[UIAlertAction actionWithTitle:@"去实名" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            xxzSettingController *scriptController = [xxzSettingController new];
            [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
        }]];
        [self presentViewController:fontu animated:YES completion:nil];
        return NO;
    }else{
        return YES;
    }
}

- (QMUINavigationTitleView *)mc_titleview {
    if (!_mc_titleview) {
        _mc_titleview = [[QMUINavigationTitleView alloc] initWithStyle:QMUINavigationTitleViewStyleDefault];
    }
    return _mc_titleview;
}

- (void)updateToObtainTheSpecified:(NSString *)key Data:(NSDictionary *)data{
    NSUserDefaults *lijitixianE = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *huabeiblockY = [NSMutableDictionary dictionaryWithDictionary:[lijitixianE objectForKey:key]];

    [huabeiblockY addEntriesFromDictionary:data];
    [lijitixianE setObject:huabeiblockY forKey:key];
    [lijitixianE synchronize];
}



- (NSDictionary *)loadUserData{
    NSUserDefaults *lijitixianu = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblockI = [lijitixianu objectForKey:@"UserData"];
    return huabeiblockI;
}

- (NSDictionary *)getToObtainTheSpecified:(NSString *)key{
    NSUserDefaults *lijitixian_ = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblocku = [lijitixian_ objectForKey:key];
    return huabeiblocku;
}



- (void)dealloc
{
}


- (NSDictionary *)loadSuperMembersData{
    NSUserDefaults *lijitixianT = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblockU = [lijitixianT objectForKey:@"SuperMembers"];
    return huabeiblockU;
}



- (BOOL)toLogin{
    
    
    NSDictionary *huabeiblockT = [self loadUserData];
    if ([huabeiblockT allKeys].count == 0) {
        
        UIAlertController *fontZ = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请登录" preferredStyle:UIAlertControllerStyleAlert];
        [fontZ addAction:[UIAlertAction actionWithTitle:@"稍后" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [fontZ addAction:[UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            xxzListHandlerController *pickerController = [xxzListHandlerController new];
            [self.xp_rootNavigationController pushViewController:pickerController animated:YES];
            
        }]];
        [[UIViewController currentViewController] presentViewController:fontZ animated:YES completion:^{}];
        return NO;
    }
    return YES;
}

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager*)locationManager{
    [locationManager requestAlwaysAuthorization];
}
#pragma 冒泡排序 大的在前

- (void)addLocationManager:(void(^)(NSString *province,NSString *city))backname{
    
    
    [AMapLocationManager updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    [AMapLocationManager updatePrivacyAgree:AMapPrivacyAgreeStatusDidAgree];
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
        
    }
    else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请打开APP定位权限" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:settingsURL options:@{} completionHandler:nil];
        }];
        
        [sureAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
        
        [alertController addAction:cancelAction];
        [alertController addAction:sureAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [AMapServices sharedServices].apiKey = AMaPAppKey;
    self.onselectedStatus = [[AMapLocationManager alloc] init];
    self.onselectedStatus.delegate = self;
    if (@available(iOS 14.0, *)) {
        self.onselectedStatus.locationAccuracyMode = AMapLocationFullAndReduceAccuracy;
    } else {
        
    }
    
    [self.onselectedStatus setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    self.onselectedStatus.locationTimeout =5;
    
    self.onselectedStatus.reGeocodeTimeout = 5;
    
    [self.onselectedStatus requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error){
            if (error.code == AMapLocationErrorLocateFailed){
                [xxzBase showBottomWithText:@"定位失败，请手动选择"];
                return;
            }
        }
        if (regeocode){
            
            NSString *province = regeocode.province;
            if([province containsString:@"市"]){
                province = [province stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
            backname(province,regeocode.city);
        }
    }];
    
}


-(UIView *)returnCardView:(CGRect)frame colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo{

    
    UIView *confirmView = [[UIView alloc] init];
    confirmView.frame = frame;
    
    NSArray *trading = [NSArray arrayWithObjects:(id)colorOne.CGColor, (id)colorTwo.CGColor, nil];
   
   CAGradientLayer *two = [CAGradientLayer layer];
   two.frame = frame;
   two.startPoint = CGPointMake(0.74, 1);
   two.endPoint = CGPointMake(0.01, 0);
   two.colors = trading;
   two.locations = @[@(0), @(1.0f)];
   confirmView.layer.cornerRadius = 10;
   [confirmView.layer insertSublayer:two atIndex:-1];
    return confirmView;
}

#pragma mark - 获取单次定位地址 返回

- (void)mc_tableviewRefresh {
    [_mc_tableview.mj_header endRefreshing];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutTableView];
}






- (void)getAddressThan:(NSString *)province City:(NSString *)city isThan:(void(^)(NSString *provinceCode,NSString *cityCode,BOOL isThan))backname{
    [self NetWorkingPostWithAddressURL:[UIViewController currentViewController] hiddenHUD:YES url:@"/api/payment/province/list" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            
            NSArray *array = [NSArray arrayWithArray:responseObject[@"data"]];
            for(int i = 0 ; i < array.count ; i++){
                
                NSDictionary *provinceDic = array[i];
                if ([provinceDic[@"name"] containsString:[province substringToIndex:2]]) {
                    NSMutableDictionary *params = [NSMutableDictionary dictionary];
                    [params setValue:provinceDic[@"id"] forKey:@"parent"];
                    
                    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/payment/city/list" Params:params success:^(id  _Nonnull responseObject) {
                        if ([responseObject[@"code"] intValue] == 0) {
                            NSArray *array = [NSArray arrayWithArray:responseObject[@"data"]];
                            BOOL isThan = NO;
                            NSDictionary *cityDic = [NSDictionary dictionary];
                            for(NSDictionary *dic in array){
                                if ([dic[@"name"] containsString:city]) {
                                    cityDic = dic;
                                    isThan = YES;
                                }
                            }
                            backname(provinceDic[@"id"],cityDic[@"id"],isThan);
                        }else{
                            backname(@"",@"",NO);
                            [xxzBase showCenterWithText:responseObject[@"message"]];
                        }
                    } failure:^(NSString * _Nonnull error) {
                        backname(@"",@"",NO);
                    }];
                }
            }
        }else{
            [xxzBase showCenterWithText:responseObject[@"message"]];
            backname(@"",@"",NO);
        }
    } failure:^(NSString * _Nonnull error) {
        backname(@"",@"",NO);
    }];
    
}




- (void)updateSuperMembersData:(NSDictionary *)data{
    NSUserDefaults *lijitixianw = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *huabeiblockt = [NSMutableDictionary dictionaryWithDictionary:[lijitixianw objectForKey:@"SuperMembers"]];

    [huabeiblockt addEntriesFromDictionary:data];
    [lijitixianw setObject:huabeiblockt forKey:@"SuperMembers"];
    [lijitixianw synchronize];
}

- (void)updateUserData:(NSDictionary *)data{
    NSUserDefaults *lijitixian7 = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *huabeiblockD = [NSMutableDictionary dictionaryWithDictionary:[lijitixian7 objectForKey:@"UserData"]];

    [huabeiblockD addEntriesFromDictionary:data];
    [lijitixian7 setObject:huabeiblockD forKey:@"UserData"];
    [lijitixian7 synchronize];
}

@end
