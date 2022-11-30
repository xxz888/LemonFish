
#import "xxzBoutRticlesController.h"
#import "xxzErsonHangeView.h"
#import "xxzAddressController.h"
#import "xxzToolFootController.h"
#import "xxzConfigNviteController.h"
#import "xxzHangeCell.h"
#import "xxzHeaderController.h"

@interface xxzBoutRticlesController ()<QMUITableViewDataSource, QMUITableViewDelegate>
@property (nonatomic, strong) xxzErsonHangeView *shoukkuanblock;
@property (nonatomic, strong) NSString * nextblockSeconds ;
@property (nonatomic, strong) NSString * hand ;
@property (nonatomic, strong) NSMutableArray * yitixianIndicator ;
@property (nonatomic ,strong)NSDictionary * chuxukaDic;
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;
@end

@implementation xxzBoutRticlesController


-(void)eventBlock{
    
    [self.shoukkuanblock.addBtn bk_whenTapped:^{
        if (self.shoukkuanblock.chuxukaBtn.isSelected) {
            xxzHeaderController * scriptController = [[xxzHeaderController alloc]init];
            scriptController.empowerToken = self.empowerToken;
            scriptController.userDic = self.userDic;
            [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
        }else{
            xxzToolFootController * scriptController = [[xxzToolFootController alloc]init];
            scriptController.empowerToken = self.empowerToken;
            scriptController.userDic = self.userDic;
            [self.xp_rootNavigationController pushViewController:scriptController animated:YES];
        }

    }];
    
    
    [self.shoukkuanblock.chuxukaBtn bk_whenTapped:^{
        self.shoukkuanblock.chuxukaBtn.selected = YES;
        self.shoukkuanblock.xinyongkaBtn.selected = NO;
        [self getCardList];
    }];
    
    
    [self.shoukkuanblock.xinyongkaBtn bk_whenTapped:^{
        self.shoukkuanblock.chuxukaBtn.selected = NO;
        self.shoukkuanblock.xinyongkaBtn.selected = YES;
        [self getCardList];
    }];

}


-(void)deleteXinyongka:(NSInteger )tag{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIAlertController *font = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除吗？" preferredStyle:UIAlertControllerStyleAlert];
    [font addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [font addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString * result ;
        if (self.shoukkuanblock.chuxukaBtn.isSelected) {
            result = [NSString stringWithFormat:@"/api/user/debit/card/delete/%ld",tag] ;

        }else{
            result = [NSString stringWithFormat:@"/api/user/credit/card/delete/%ld",tag] ;
        }
        NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
        if (self.empowerToken) {
            [pass setValue:self.empowerToken forKey:@"empowerToken"];
        }
        [self NetWorkingPostWithAddressURL:self hiddenHUD:NO url:result Params:pass success:^(id  _Nonnull responseObject) {
            
            
            if ([responseObject[@"code"] integerValue] == 0) {
                
                [xxzBase showBottomWithText:@"删除成功"];
                [self getCardList];
            }
            
            
      

        } failure:^(NSString * _Nonnull error) {
            
        }];
    }]];
    [[UIViewController currentViewController] presentViewController:font animated:YES completion:^{}];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.empowerToken || !self.isChangeCome) {
        return;
    }
    NSDictionary * date = self.yitixianIndicator[indexPath.row];
    NSString * resultl = self.shoukkuanblock.chuxukaBtn.isSelected ? @"/api/user/debit/card/change/def/" : @"/api/user/credit/card/change/def/";
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:[NSString stringWithFormat:@"%@%@",resultl,date[@"id"]] Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [self.xp_rootNavigationController popViewControllerAnimated:YES];
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}


- (void)getCardList{
    NSString * resultE = self.shoukkuanblock.chuxukaBtn.isSelected ? @"/api/user/debit/card/list" : @"/api/user/credit/card/list";
    
    NSMutableDictionary * passc= [[ NSMutableDictionary alloc]init];
    if (self.empowerToken) {
        [passc setValue:self.empowerToken forKey:@"empowerToken"];
    }

    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:resultE Params:passc success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            self.yitixianIndicator = responseObject[@"data"];
            [self.mc_tableview reloadData];
        }else{
            self.shoukkuanblock.chuxukaView.hidden = YES;
            self.shoukkuanblock.chuxukaImv.image = [UIImage imageNamed:@"pdataImv"];
            
            
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
        self.mc_tableview.delegate = self;
        self.mc_tableview.dataSource = self;
        self.mc_tableview.tableHeaderView.height = 120 + kStatusBarHeight;
        self.mc_tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.mc_tableview registerNib:[UINib nibWithNibName:@"xxzHangeCell" bundle:nil] forCellReuseIdentifier:@"xxzHangeCell"];

}

#pragma mark - QMUITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.yitixianIndicator count];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    
    if (self.isChangeCome) {
        if (self.isChuxukaCome) {
            self.shoukkuanblock.chuxukaBtn.selected = YES;
            self.shoukkuanblock.xinyongkaBtn.selected = NO;
            self.shoukkuanblock.xinyongkaBtn.enabled = NO;
            self.shoukkuanblock.xinyongkaBtn.userInteractionEnabled = NO;
        }else{
            self.shoukkuanblock.chuxukaBtn.selected = NO;
            self.shoukkuanblock.xinyongkaBtn.selected = YES;
            
            self.shoukkuanblock.chuxukaBtn.enabled = NO;
            self.shoukkuanblock.chuxukaBtn.userInteractionEnabled = NO;
        }
    }else{
        self.shoukkuanblock.chuxukaBtn.selected = YES;
        self.shoukkuanblock.xinyongkaBtn.selected = NO;
    }
    
    if (self.empowerToken) {
        self.shoukkuanblock.navTitle.text = [NSString stringWithFormat:@"%@的卡包",self.userDic[@"fullname"]];
        self.shoukkuanblock.empowerToken = self.empowerToken;
    }

    [self getCardList];
    
    [self eventBlock];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 120;
    
}

- (xxzErsonHangeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzErsonHangeView alloc] init];
     
    }
    return _shoukkuanblock;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    xxzHangeCell *yitixianCell = [xxzHangeCell cellWithTableView:tableView];
    NSDictionary * dateK = self.yitixianIndicator[indexPath.row];
    yitixianCell.xinyongkaChange.tag = [dateK[@"id"] integerValue];
    yitixianCell.xinyongkaNum.text = [UILabel splitSpace:dateK[@"cardNo"]];
    yitixianCell.xinyongkaName.text = dateK[@"bankName"];
    yitixianCell.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(dateK[@"bankAcronym"])];
    
    if (dateK[@"securityCode"] && dateK[@"expiredTime"]) {
        yitixianCell.cardType.text = @"信用卡";
    }else{
        yitixianCell.cardType.text = @"储蓄卡";

    }
    if (!self.isChangeCome) {
        yitixianCell.xinyongkaChange.hidden = NO;
        yitixianCell.setChuxukaBtn.hidden = YES;
    }else{
        yitixianCell.xinyongkaChange.hidden = YES;

        if (self.isChuxukaCome) {
            yitixianCell.setChuxukaBtn.hidden = NO;
            yitixianCell.setXinyongkaBtn.hidden = YES;
            if ([dateK[@"def"] integerValue] == 1) {
                yitixianCell.setChuxukaBtn.selected = YES;
            }else{
                yitixianCell.setChuxukaBtn.selected = NO;
            }
        }else{
            yitixianCell.setXinyongkaBtn.hidden = NO;
            yitixianCell.setChuxukaBtn.hidden = YES;
            if ([dateK[@"def"] integerValue] == 1) {
                yitixianCell.setXinyongkaBtn.selected = YES;
            }else{
                yitixianCell.setXinyongkaBtn.selected = NO;
            }
        }
        
    }
    
    __weak typeof(self) weakSelf = self;

    [yitixianCell.xinyongkaChange bk_whenTapped:^{
        [weakSelf deleteXinyongka:yitixianCell.xinyongkaChange.tag];
    }];
    
    
    UIView *confirmView = [[UIView alloc] init];
    confirmView.frame = CGRectMake(0,0,kScreenWidth-52,159);
   
    UIColor * yuliujin ;
    UIColor * huxukaW ;
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 9 || indexPath.row == 12 ) {
    
        yuliujin = [UIColor colorWithRed:81.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
        huxukaW = [UIColor colorWithRed:80/255.0 green:149/255.0 blue:254/255.0 alpha:1.0];
    }else if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 10 || indexPath.row == 13 ) {
        yuliujin = [UIColor colorWithRed:255.0/255.0 green:93.0/255.0 blue:97.0/255.0 alpha:1.0];
        huxukaW = [UIColor colorWithRed:255/255.0 green:140/255.0 blue:137/255.0 alpha:1.0];
    }else{
        yuliujin = [UIColor colorWithRed:0/255.0 green:176/255.0 blue:193/255.0 alpha:1.0];
        huxukaW = [UIColor colorWithRed:58/255.0 green:213/255.0 blue:226/255.0 alpha:1.0];
    }

   [yitixianCell.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,159) colorOne:yuliujin colorTwo:huxukaW] atIndex:0];
    
    
    return yitixianCell;
}
@end
