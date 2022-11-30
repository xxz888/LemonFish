
#import "xxzUppotAuto.h"
#import "AFHTTPSessionManager.h"


#import <MJExtension/MJExtension.h>

@implementation xxzUppotAuto


+ (void)PostWithURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock __nullable)success failure:(FailureBlock __nullable)failure{
    
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *reate = [AFHTTPResponseSerializer serializer];
    reate.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = reate;
    
    url = [ApiUrl stringByAppendingString:url];
    
    NSMutableURLRequest *total = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];

    total.timeoutInterval= 20;
    [total setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSUserDefaults *lijitixian = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblock = [lijitixian objectForKey:@"UserData"];
    if(huabeiblock != nil){
        
        [total setValue:huabeiblock[@"token"] forHTTPHeaderField:@"token"];
    }
    [total setValue:@"ios" forHTTPHeaderField:@"platform"];
    
    NSDictionary *nav = [[NSBundle mainBundle] infoDictionary];
    NSString  *main_n = [nav objectForKey:@"CFBundleShortVersionString"];
    [total setValue:main_n forHTTPHeaderField:@"version"];
    
    
    [total setHTTPBody:[params mj_JSONData]];
    NSLog(@"\n ---------请求地址：--------- \n %@",url);
    NSLog(@"\n ---------请求参数：--------- \n %@",params);
    
    [[manager dataTaskWithRequest:total uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){

        if(responseObject != nil ){
            
            NSString *zhangdanri = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
           

            NSString * pricelbl = [zhangdanri stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
            
            NSData * huodongjiangli = [pricelbl dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary * chuxuka = [NSJSONSerialization JSONObjectWithData:huodongjiangli options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"\n ---------返回结果：--------- \n %@",chuxuka);
            
            
            success(chuxuka);
            
            
            
        }else{
            failure(@"服务器无响应");
        }
    }]resume];
}




+ (void)PostWithImageURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock __nullable)success failure:(FailureBlock __nullable)failure{
    
    url = [ApiUrl stringByAppendingString:url];
    
    NSUserDefaults *lijitixiano = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblockE = [lijitixiano objectForKey:@"UserData"];
    if (huabeiblockE != nil) {
        UIImage *huankuanblockImage = params[@"file"];
 
        AFHTTPSessionManager * empower = [AFHTTPSessionManager manager];
        
        empower.requestSerializer.timeoutInterval = 20;
        
        empower.responseSerializer = [AFHTTPResponseSerializer serializer];
        empower.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json",@"text/html", nil];
        
        [empower.requestSerializer setValue:huabeiblockE[@"token"] forHTTPHeaderField:@"token"];
        [empower.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
        
        NSDictionary *nav8 = [[NSBundle mainBundle] infoDictionary];
        NSString  *main_n7 = [nav8 objectForKey:@"CFBundleShortVersionString"];
        [empower.requestSerializer setValue:main_n7 forHTTPHeaderField:@"version"];
        NSLog(@"%@",url);
        [empower POST:url parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSString * process = [NSString stringWithFormat:@"sfz.jpg"];
            
            NSData *oney = [self compressImageDataWithMaxLimit:0.2 images:[self compressImageWith:huankuanblockImage]];
            
            NSString * i_count = @"file";
            if ([url containsString:@"/api/user/update/avatar"]) {
                i_count = @"avatar";
                
            }
            [formData appendPartWithFileData:oney name:i_count fileName:process mimeType:@"image/jpeg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"上传完成比率：%f",uploadProgress.fractionCompleted * 100);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);

            NSError * observer = nil;
            
            NSString *buy =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * huodongjiangliv = [buy dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary * oney= [NSJSONSerialization JSONObjectWithData:huodongjiangliv options:0 error:&observer];
            
            success(oney);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(@"服务未响应,请重试！");
        }];
        
    }
    
}
#pragma mark 字典转化字符串

+ (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit images:(UIImage *)image{
    
    CGFloat left = 0.9f;
    CGFloat phone = 0.2f; 
    NSData *send = UIImageJPEGRepresentation(image, left);
    NSInteger sure = [send length];
    while ((sure <= maxLimit * 1000 * 1000) && (left >= phone)) {
        left -= 0.03;
        send = UIImageJPEGRepresentation(image, left);
        sure = [send length];
    }
    return send;
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *btn = nil;
    NSData *zhituirenshu = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&btn];
    
    return [[NSString alloc] initWithData:zhituirenshu encoding:NSUTF8StringEncoding];
}


+ (UIImage *)compressImageWith:(UIImage *)image{
    float huankuanjine = image.size.width;
    float request = image.size.height;
    float clear = 640;
    float masks = image.size.height/(image.size.width/clear);
    float sendR = huankuanjine /clear;
    float yangkajigou = request /masks;
    
    
    UIGraphicsBeginImageContext(CGSizeMake(clear, masks));
    if (sendR > yangkajigou) {
        [image drawInRect:CGRectMake(0, 0, huankuanjine /yangkajigou , masks)];
    }
    else {
        [image drawInRect:CGRectMake(0, 0, clear , request /sendR)];
    }
    
    UIImage *tuiguangImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return tuiguangImage;
}


+ (void)PostWithAddressURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock __nullable)success failure:(FailureBlock __nullable)failure{
    
    
    url = [ApiUrl stringByAppendingString:url];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSUserDefaults *lijitixian9 = [NSUserDefaults standardUserDefaults];
    NSDictionary *huabeiblockQ = [lijitixian9 objectForKey:@"UserData"];
    if(huabeiblockQ != nil){
        
        [manager.requestSerializer setValue:huabeiblockQ[@"token"] forHTTPHeaderField:@"token"];
    }
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
    
    NSDictionary *navK = [[NSBundle mainBundle] infoDictionary];
    NSString  *main_nR = [navK objectForKey:@"CFBundleShortVersionString"];
    [manager.requestSerializer setValue:main_nR forHTTPHeaderField:@"version"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain",nil];
    NSLog(@"%@",url);
    NSLog(@"%@",params);
    [manager POST:url parameters:params headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            if(responseObject != nil){
                NSString * pricelbl7 = [[self dictionaryToJson:responseObject] stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
                NSData * huodongjiangli_ = [pricelbl7 dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary * chuxukaH = [NSJSONSerialization JSONObjectWithData:huodongjiangli_ options:NSJSONReadingMutableLeaves error:nil];
                
                success(chuxukaH);
                
                
                
                
            }else{
                failure(@"服务器无响应");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);

            failure(@"服务器无响应");
        }];
    
}

@end
