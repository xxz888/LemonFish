



#if DEBUG  
#define XMLog(...)  NSLog(__VA_ARGS__)
#else
#define XMLog(...)
#endif


#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

#define XMRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XMRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define IS_PhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX_To_Other_Nav_Height_Difference 24

#define iPhoneX_To_Other_Bottom_Height_Difference 34

#define iPhone_Nav_Height 64

#define iPhone_Tabbar_Height 49

#define iPhoneX_Nav_Height (iPhone_Nav_Height+iPhoneX_To_Other_Nav_Height_Difference)

#define iPhoneX_Tabbar_Height (iPhone_Tabbar_Height+iPhoneX_To_Other_Bottom_Height_Difference)

#define NavFrame (IS_PhoneX?CGRectMake(0, 0, WIDTH, iPhoneX_Nav_Height):CGRectMake(0, 0, WIDTH, iPhone_Nav_Height))




#define XMImageAnimationDuration 0.15f


#define XM18Font [UIFont systemFontOfSize:18]


#define XMNetFialText @"网络连接失败"
#define XMVideoUrlText @"请输入视频地址"
#define XMVideoPlayFialText @"播放失败"
#define XMVideoDownFinish  @"下载完成"




#define XMRefreshColor [UIColor whiteColor].CGColor


#define AppDelegateOrientationMaskPortrait [(AppDelegate *)[UIApplication sharedApplication].delegate setOrientationMask:UIInterfaceOrientationMaskPortrait];
#define AppDelegateOrientationMaskLandscape [(AppDelegate *)[UIApplication sharedApplication].delegate setOrientationMask:UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight];

#define PopGestureRecognizerOpen self.navigationController.interactivePopGestureRecognizer.enabled = YES;
#define PopGestureRecognizerCancel self.navigationController.interactivePopGestureRecognizer.enabled = NO;


