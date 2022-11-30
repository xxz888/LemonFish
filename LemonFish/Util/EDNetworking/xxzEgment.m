
#import "xxzEgment.h"
#import "xxzUppotAuto.h"
#import "MBProgressHUD.h"
#import "xxzSilderController.h"


@implementation UIViewController (HUD)


- (void)dismiss{
    [MBProgressHUD hideHUDForView:[UIDevice currentWindow] animated:YES];
}


- (void)NetWorkingPostWithAddressURL:(UIViewController *)Controller hiddenHUD:(BOOL)hidden url:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    if (!hidden) {
        [self Show];
    }
    [xxzUppotAuto PostWithAddressURL:url Params:params success:^(id  _Nonnull responseObject) {
        
        [self dismiss];
        
        if ([responseObject[@"code"] intValue] != 0) {
            [xxzBase showBottomWithText:responseObject[@"message"] duration:2];
        }
        if([responseObject[@"code"] intValue] == 5){
            [[xxzSilderController new] loginPastDue];
        }else{
            success(responseObject);
        }
        
        
    } failure:^(NSString * _Nonnull error) {
        [self dismiss];
//        [xxzBase showBottomWithText:error duration:2];
        failure(error);
    }];
}



- (void)Show{
    [MBProgressHUD showHUDAddedTo:[UIDevice currentWindow] animated:YES];
}


- (void)NetWorkingPostWithURL:(UIViewController *)Controller hiddenHUD:(BOOL)hidden url:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    if (!hidden) {
        [self Show];
    }
    [xxzUppotAuto PostWithURL:url Params:params success:^(id  _Nonnull responseObject) {
        [self dismiss];
        
        if (!responseObject) {
            [xxzBase showBottomWithText:@"未知错误" duration:2];
            return;
        }
        
        
        
        
        if ([responseObject[@"code"] intValue] != 0) {
            [xxzBase showBottomWithText:responseObject[@"message"] duration:2];
        }
        if([responseObject[@"code"] intValue] == 5){
            [[xxzSilderController new] loginPastDue];
        }else{
            success(responseObject);
        }
        
    } failure:^(NSString * _Nonnull error) {
        [self dismiss];
        //[xxzBase showBottomWithText:error duration:2];
        failure(error);
    }];
}

- (void)NetWorkingPostWithImageURL:(UIViewController *)Controller hiddenHUD:(BOOL)hidden url:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    if (!hidden) {
        [self Show];
    }
    
    [xxzUppotAuto PostWithImageURL:url Params:params success:^(id  _Nonnull responseObject) {
        
        [self dismiss];
        if([responseObject[@"code"] intValue] == 0){
            success(responseObject);
        }else{
            if([responseObject[@"code"] intValue] == 5){
                [[xxzSilderController new] loginPastDue];
            }else{
                [xxzBase showBottomWithText:responseObject[@"message"] duration:2];
            }
        }
    } failure:^(NSString * _Nonnull error) {
        [self dismiss];
       // [xxzBase showBottomWithText:error duration:2];
        failure(error);
    }];
}



@end
