
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzOginEmptyController : xxzSilderController

@property(nonatomic,strong)NSString * currentId;
@property (weak, nonatomic) IBOutlet UIImageView *bg_image;
@property (weak, nonatomic) IBOutlet UIImageView *QrCode_img;

@property (weak, nonatomic) IBOutlet UIView *content_view;

@property (weak, nonatomic) IBOutlet UIView *navigation_View;
@property (weak, nonatomic) IBOutlet UIButton *nav_back;

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *content_image;

@property (weak, nonatomic) IBOutlet UIButton *baocun_btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTop;

@end

NS_ASSUME_NONNULL_END
