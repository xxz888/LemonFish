
#import "xxzHomeNline.h"

#import <objc/runtime.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/PHPhotoLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>


static void *kImagePickerCompletionHandlerKey = @"kImagePickerCompletionHandlerKey";
static void *kCameraPickerKey = @"kCameraPickerKey";
static void *kPhotoLibraryPickerKey = @"kPhotoLibraryPickerKey";
static void *kImageSizeKey = @"kimageSizeKey";
static void *isCut =  @"isCut"; 

@interface UIViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *s_height;
@property (nonatomic, strong) UIImagePickerController *buttons;
@property (nonatomic, copy) ImagePickerCompletionHandler completionHandler;

@property (nonatomic, assign) BOOL detail;
@property (nonatomic, assign) CGSize mengban;

@end

@implementation UIViewController (ImagePicker)






- (void)setCompletionHandler:(ImagePickerCompletionHandler)completionHandler {
    objc_setAssociatedObject(self, kImagePickerCompletionHandlerKey, completionHandler, OBJC_ASSOCIATION_COPY);
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *statusImage = [[UIImage alloc] init];
    if(self.detail){
         
        statusImage = info[@"UIImagePickerControllerEditedImage"]; 
        CGSize safe = CGSizeMake(413, 626);
        if (self.mengban.height>0) {
            safe = self.mengban;
        }
        statusImage = [self reSizeImage:statusImage toSize:safe];
    }
    else{
        statusImage = info[@"UIImagePickerControllerOriginalImage"];
    }
    NSData *send = UIImageJPEGRepresentation(statusImage, 0.0001);
    UIImage *huankuanblockImage = [UIImage imageWithData:send];
    
        send = UIImageJPEGRepresentation(huankuanblockImage, 0.5);
        huankuanblockImage = [UIImage imageWithData:send];
    self.completionHandler(send, huankuanblockImage);
}


- (void)pickImageWithpickImageCutImageWithImageSize:(CGSize)mengban CompletionHandler:(ImagePickerCompletionHandler)completionHandler
{
    self.completionHandler = completionHandler;
    self.detail = YES;
    self.mengban = mengban;
    [self presentChoseActionSheet];
}


- (void)setDetail:(BOOL)detail {
    return objc_setAssociatedObject(self, isCut, @(detail), OBJC_ASSOCIATION_RETAIN);
}


- (UIImagePickerController *)buttons {
    return objc_getAssociatedObject(self, kPhotoLibraryPickerKey);
}

#pragma mark <UIImagePickerControllerDelegate>


- (BOOL)detail {
    return [objc_getAssociatedObject(self, isCut) boolValue];
}


- (CGSize)mengban {
    NSValue * camera = objc_getAssociatedObject(self, kImageSizeKey);
    return  camera.CGSizeValue;
}


- (UIImagePickerController *)s_height {
    return objc_getAssociatedObject(self, kCameraPickerKey);;
}

#pragma mark - setters & getters


- (void)setButtons:(UIImagePickerController *)buttons {
    objc_setAssociatedObject(self, kPhotoLibraryPickerKey, buttons, OBJC_ASSOCIATION_RETAIN);
}


- (void)setUpPhotoPickControllerIsEdit:(BOOL)isEdit {
    self.buttons = [[UIImagePickerController alloc] init];
    self.buttons.allowsEditing = isEdit; 
    self.buttons.delegate = self;
    
    self.buttons.navigationBar.translucent = NO;
    self.buttons.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}


- (void)pickImageWithCompletionHandler:(ImagePickerCompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    [self presentChoseActionSheet];
}


- (void)setS_height:(UIImagePickerController *)s_height {
    objc_setAssociatedObject(self, kCameraPickerKey, s_height, OBJC_ASSOCIATION_RETAIN);
}


- (void)presentChoseActionSheet {
    
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [self setUpCameraPickControllerIsEdit:self.detail];
    }
    [self setUpPhotoPickControllerIsEdit:self.detail];
    
    UIAlertController * serverController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * circle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * qianyuetongdao = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:self.s_height animated:YES completion:nil];
    });
            }
            else {
                UIAlertController * xinyongkaController = [UIAlertController alertControllerWithTitle:@"未开启相机权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * circle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * task = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }];
                
                [xinyongkaController addAction:circle];
                [xinyongkaController addAction:task];
dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:xinyongkaController animated:YES completion:nil];
    });
                
            }
        }];

    }];
    
    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusNotDetermined || status == PHAuthorizationStatusAuthorized) {
                
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:self.buttons animated:YES completion:nil];
    });
                

            }
            else {
                UIAlertController * xinyongkaController = [UIAlertController alertControllerWithTitle:@"未开启相册权限，请到设置界面开启" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * circle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                UIAlertAction * task = [UIAlertAction actionWithTitle:@"现在就去" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }];
                
                [xinyongkaController addAction:circle];
                [xinyongkaController addAction:task];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:xinyongkaController animated:YES completion:nil];
    });
                
            }
        }];

    }];
    
    [serverController addAction:circle];
    [serverController addAction:qianyuetongdao];
    [serverController addAction:alert1];
    
    [self presentViewController:serverController animated:YES completion:^{
        
    }];
}


- (ImagePickerCompletionHandler)completionHandler {
    return objc_getAssociatedObject(self, kImagePickerCompletionHandlerKey);
}


- (void)setMengban:(CGSize)mengban {
    return objc_setAssociatedObject(self, kImageSizeKey, [NSValue valueWithCGSize:mengban], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *huankuanbishuImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return huankuanbishuImage;
}


- (void)setUpCameraPickControllerIsEdit:(BOOL)isEdit {
    self.s_height = [[UIImagePickerController alloc] init];
    self.s_height.allowsEditing = isEdit; 
    self.s_height.delegate = self;
    self.s_height.sourceType = UIImagePickerControllerSourceTypeCamera;
}

@end

