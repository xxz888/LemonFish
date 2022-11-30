

#import <UIKit/UIKit.h>



typedef enum {
    XMPlayerViewWechatShortVideoType = 0,  
    XMPlayerViewAiqiyiVideoType = 1,  
    XMPlayerViewTwoSynVideoType = 2,  
} XMPlayerViewType;

@interface xxzShopView : UIView


@property (nonatomic,strong) UIImage *currentImage;


@property (nonatomic,strong) NSURL *videoURL;
@property (nonatomic,strong) NSURL *subVideoURL;


@property (nonatomic, weak) UIView *sourceImagesContainerView;


@property (nonatomic, assign) BOOL isAllowDownload;


@property (nonatomic, assign) BOOL isAllowCyclePlay;


- (void)show;


@property (nonatomic, assign) BOOL isFullScreen; 


@property (nonatomic, assign) XMPlayerViewType playerViewType;


- (void)settingPlayerItemWithUrl:(NSURL *)playerUrl;


@end
