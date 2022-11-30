
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UpLoadBlock)(NSInteger);
typedef void(^NextBlock)(void);

@interface xxzPrefixHangeView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;

@property (weak, nonatomic) IBOutlet UIView *cardBackView;
@property (weak, nonatomic) IBOutlet UITextField *youxiaoqiTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@property (weak, nonatomic) IBOutlet UITextField *anquanmaTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

NS_ASSUME_NONNULL_END
