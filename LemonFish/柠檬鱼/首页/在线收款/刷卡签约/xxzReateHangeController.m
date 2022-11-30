
#import "xxzReateHangeController.h"
#import "xxzPrefixHangeView.h"

@interface xxzReateHangeController ()
@property (nonatomic, strong) xxzPrefixHangeView *shoukkuanblock;
@property (nonatomic ,strong)NSString * more;
@end

@implementation xxzReateHangeController


- (xxzPrefixHangeView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzPrefixHangeView alloc] init];
    }
    return _shoukkuanblock;
}

#pragma 确定绑定

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    
    self.shoukkuanblock.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(self.xinyongkaDic[@"bankAcronym"])];
    self.shoukkuanblock.xinyongkaNum.text = [NSString stringWithFormat:@"%@(尾号%@)",self.xinyongkaDic[@"bankName"],[self.xinyongkaDic[@"cardNo"] substringFromIndex:[self.xinyongkaDic[@"cardNo"] length]-4]];

    
    self.shoukkuanblock.anquanmaTf.text = self.xinyongkaDic[@"securityCode"];
    self.shoukkuanblock.youxiaoqiTf.text = self.xinyongkaDic[@"expiredTime"];
    self.shoukkuanblock.phoneTf.text = self.xinyongkaDic[@"phone"];

    [self blockAction];
}

- (void)changeSendBtnText{

    __block NSInteger acc = 60;
    
    dispatch_queue_t tixianjine = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t sing = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, tixianjine);
    
    dispatch_source_set_timer(sing, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(sing, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (acc >= 0) {
                self.shoukkuanblock.sendBtn.userInteractionEnabled = NO;
                [self.shoukkuanblock.sendBtn setTitle:[NSString stringWithFormat:@"%lds", acc] forState:0];
                
                acc--;
                
                
            }else {
                self.shoukkuanblock.sendBtn.userInteractionEnabled = YES;
                dispatch_source_cancel(sing);
                [self.shoukkuanblock.sendBtn setTitle:@"重新发送" forState:0];

            }
            
        });
    });
    
    dispatch_resume(sing);
}


- (void)blockAction{


    [self.shoukkuanblock.sendBtn bk_whenTapped:^{
        
        [self fastApply];
    }];
    
    [self.shoukkuanblock.nextBtn bk_whenTapped:^{
        [self submitAction];
    }];
 
}


-(void)fastApply{
    NSDictionary *huabeiblock = [self loadUserData];

    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *pass = [NSMutableDictionary new];
    [pass setValue:huabeiblock[@"id"] forKey:@"userId"];
    [pass setValue:huabeiblock[@"fullname"] forKey:@"userName"];
    [pass setValue:self.xinyongkaDic[@"bankName"] forKey:@"bankName"];
    [pass setValue:self.xinyongkaDic[@"cardNo"] forKey:@"bankCard"];
    [pass setValue:self.xinyongkaDic[@"phone"] forKey:@"bankPhone"];
    [pass setValue:self.xinyongkaDic[@"securityCode"] forKey:@"securityCode"];
    [pass setValue:self.xinyongkaDic[@"expiredTime"] forKey:@"expiredTime"];
    [pass setValue:self.xinyongkaDic[@"idCard"] forKey:@"idCard"];
    [pass setValue:[NSString stringWithFormat:@"%@",self.startDic[@"id"]] forKey:@"channelId"];
    [pass setValue:brandId forKey:@"brandId"];
    
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/payment/fast/bindcard" Params:pass success:^(id  _Nonnull responseObject) {
        
        
        if ([responseObject[@"code"] intValue] == 0) {
            if([responseObject[@"message"] isEqualToString:@"重复签约"]){
                [weakSelf.xp_rootNavigationController popViewControllerAnimated:YES];
                [xxzBase showBottomWithText:responseObject[@"message"]];
             
            }else{
                weakSelf.more = responseObject[@"data"];
                [weakSelf changeSendBtnText];
            }
        }
        else{
        }
        
        
        
  
        
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

-(void)submitAction{
    if ([self isEmpty:self.shoukkuanblock.codeTf.text]) {
        [xxzBase showBottomWithText:@"请输入验证码"];
        return;
    }

    NSDictionary * date = @{@"bankCard":self.xinyongkaDic[@"cardNo"],
                           @"channelId":[NSString stringWithFormat:@"%@",self.startDic[@"id"]],
                           @"smsMsg":self.shoukkuanblock.codeTf.text,
    };
    
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/payment/fast/bindcard/confirm" Params:date success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            [self.xp_rootNavigationController popViewControllerAnimated:YES];
        }
        else{
       
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}




@end
