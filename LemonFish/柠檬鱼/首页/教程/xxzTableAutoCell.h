
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzTableAutoCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UIImageView *cellImg;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellTime;
- (IBAction)cellDownAction:(id)sender;


@property (strong, nonatomic) NSDictionary * startDic;




typedef enum {
    XMPlayerViewWechatShortVideoType = 0,  
    XMPlayerViewAiqiyiVideoType = 1,  
    XMPlayerViewTwoSynVideoType = 2,  
} XMPlayerViewType;




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

NS_ASSUME_NONNULL_END
