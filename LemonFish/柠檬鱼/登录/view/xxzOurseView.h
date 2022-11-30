
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginActoinBlock)(NSString *,NSString *);
@interface xxzOurseView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *xieyiBtn;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
- (IBAction)regAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *passTf;
- (IBAction)loginAction:(id)sender;
@property (nonatomic ,copy)LoginActoinBlock loginBlock;
@end

NS_ASSUME_NONNULL_END
