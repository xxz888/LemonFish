
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginActoinBlock)(NSString *,NSString *);
@interface xxzTitlePrefixView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *onePsdTf;
@property (weak, nonatomic) IBOutlet UITextField *twoPsdTf;
@property (weak, nonatomic) IBOutlet UILabel *regTip;
@property (weak, nonatomic) IBOutlet UILabel *regTip1;
@property (weak, nonatomic) IBOutlet UIButton *regtip2;
@property (weak, nonatomic) IBOutlet UILabel *regtip3;
@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (nonatomic ,copy)LoginActoinBlock loginBlock;
@end

NS_ASSUME_NONNULL_END
