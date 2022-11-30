
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzDelegateFormatterView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UIView *changePhoneView;
@property (weak, nonatomic) IBOutlet UIView *versionView;
@property (weak, nonatomic) IBOutlet UILabel *versionLbl;
@property (weak, nonatomic) IBOutlet UITextField *oldPhone;
@property (weak, nonatomic) IBOutlet UITextField *phoneNew;

@property (weak, nonatomic) IBOutlet UIView *setPsdView;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;
@property (weak, nonatomic) IBOutlet UILabel *cacheLbl;
@property (weak, nonatomic) IBOutlet UIView *cacheView;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (weak, nonatomic) IBOutlet UIButton *offWxBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UITextField *onePwdTf;
@property (weak, nonatomic) IBOutlet UITextField *twoPwdTf;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

NS_ASSUME_NONNULL_END
