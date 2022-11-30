
#import "xxzVeryController.h"
#import "xxzDelegateView.h"
#import "xxzUnicodeCell.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzDelegateController.h"

@interface xxzVeryController ()
@property (nonatomic, strong) xxzDelegateView *shoukkuanblock;

@property (nonatomic ,strong)NSMutableArray * insi;
@property (nonatomic ,strong)NSMutableArray * hankanri;
@property (nonatomic ,strong)NSMutableArray * egment;


@end

@implementation xxzVeryController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    [self eventBlock];
}

-(void)eventBlock{
    
    __weak typeof(self) weakSelf = self;

    [self.shoukkuanblock.huankuanrateView bk_whenTapped:^{
        
        if ([weakSelf.insi count] == 0  ) {
            [xxzBase showBottomWithText:@"查询还款费率列表为空"];
            return;
        }
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        xxzConfirmView *comeView = [[xxzConfirmView alloc]initWithDateStyle:DateStyleShowOtherString CompleteBlock:^(NSDate *Data, NSString *Str, id OtherString) {
            weakSelf.shoukkuanblock.huankuanTf.text = Str;
        }];
        comeView.MyearArray = weakSelf.insi;
        comeView.yearLabelColor = [UIColor clearColor];
        [comeView show];
    }];


    
    [self.shoukkuanblock.shuakarateView bk_whenTapped:^{
        if ([weakSelf.hankanri count] == 0  ) {
            [xxzBase showBottomWithText:@"查询刷卡费率列表为空"];
            return;
        }
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        xxzConfirmView *comeView = [[xxzConfirmView alloc]initWithDateStyle:DateStyleShowOtherString CompleteBlock:^(NSDate *Data, NSString *Str, id OtherString) {
            weakSelf.shoukkuanblock.shuakaTf.text = Str;
        }];
        comeView.MyearArray = weakSelf.hankanri;
        comeView.yearLabelColor = [UIColor clearColor];
        [comeView show];
    }];
    
    
    
    
    
    [self.shoukkuanblock.huabeiView bk_whenTapped:^{
        if ([weakSelf.egment count] == 0  ) {
            [xxzBase showBottomWithText:@"查询花呗费率列表为空"];
            return;
        }
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        xxzConfirmView *comeView = [[xxzConfirmView alloc]initWithDateStyle:DateStyleShowOtherString CompleteBlock:^(NSDate *Data, NSString *Str, id OtherString) {
            weakSelf.shoukkuanblock.huabeiTf.text = Str;
        }];
        comeView.MyearArray = weakSelf.egment;
        comeView.yearLabelColor = [UIColor clearColor];
        [comeView show];
    }];
    
    
    
    
    
    
    
    
    
    [self.shoukkuanblock.prePlanBtn bk_whenTapped:^{
        
        NSString * tixian = [self.shoukkuanblock.huankuanTf.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
        tixian = [NSString stringWithFormat:@"%.5f",[tixian floatValue] / 100];
        
        
        NSString * safe = [self.shoukkuanblock.shuakaTf.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
        safe = [NSString stringWithFormat:@"%.5f",[safe floatValue] / 100];
        
        
        NSString * liebianrenshu = [self.shoukkuanblock.huabeiTf.text stringByReplacingOccurrencesOfString:@"%" withString:@""];
        liebianrenshu = [NSString stringWithFormat:@"%.5f",[liebianrenshu floatValue] / 100];
        
        
        [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/change/user/config" Params:@{@"bigFast":safe,
                                                                                                           @"settle":tixian,
                                                                                                    @"huabei":liebianrenshu,
                                                                                                           @"userId":[NSString stringWithFormat:@"%@",self.startDic[@"id"]]
                                                                                                         } success:^(id  _Nonnull responseObject) {
            if ([responseObject[@"code"] intValue] == 0) {
                [weakSelf.xp_rootNavigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSString * _Nonnull error) {
            
        }];
    }];
}

-(void)getConfigList{
    __weak typeof(self) weakSelf = self;
    

    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/change/user/config/list" Params:@{@"type":@"0",@"targetId":[NSString stringWithFormat:@"%@",self.startDic[@"id"]]} success:^(id  _Nonnull responseObject) {
        for (NSNumber * str in responseObject[@"data"]) {
            [weakSelf.hankanri addObject:[NSString stringWithFormat:@"%.3f%%",[str floatValue] * 100]];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
    
        
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/change/user/config/list" Params:@{@"type":@"1",@"targetId":[NSString stringWithFormat:@"%@",self.startDic[@"id"]]} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            for (NSNumber * str in responseObject[@"data"]) {
                [weakSelf.insi addObject:[NSString stringWithFormat:@"%.3f%%",[str floatValue] * 100]];
            }
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
    
  
    
    
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/change/user/config/list" Params:@{@"type":@"2",@"targetId":[NSString stringWithFormat:@"%@",self.startDic[@"id"]]} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            for (NSNumber * str in responseObject[@"data"]) {
                [weakSelf.egment addObject:[NSString stringWithFormat:@"%.3f%%",[str floatValue] * 100]];
            }
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getConfigList];
    self.insi = [[NSMutableArray alloc]init];
    self.hankanri = [[NSMutableArray alloc]init];
    self.egment = [[NSMutableArray alloc]init];

    
    self.shoukkuanblock.huankuanTf.text = [NSString stringWithFormat:@"%.3f%%",[self.startDic[@"settle"] floatValue] * 100];
    self.shoukkuanblock.shuakaTf.text = [NSString stringWithFormat:@"%.3f%%",[self.startDic[@"bigFast"] floatValue] * 100];
    self.shoukkuanblock.huabeiTf.text = [NSString stringWithFormat:@"%.3f%%",[self.startDic[@"huabei"] floatValue] * 100];

  
}

- (xxzDelegateView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzDelegateView alloc] init];
    }
    return _shoukkuanblock;
}

@end
