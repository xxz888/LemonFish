
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UpLoadBlock)(void);
typedef void(^NextBlock)(void);

@interface xxzAddressMessageView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

- (IBAction)nextAction:(id)sender;
@property (nonatomic ,copy)UpLoadBlock upLoadblock;
@property (nonatomic ,copy)NextBlock nextblock;

@property (weak, nonatomic) IBOutlet UILabel *navTitle;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;


@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *bankTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;


@property (weak, nonatomic) IBOutlet UITextField * nickTf;
@property (weak, nonatomic) IBOutlet UITextField * weixinTf;
@property (weak, nonatomic) IBOutlet UITextField * zhifubaoTf;
@property (weak, nonatomic) IBOutlet UITextField *shimingTf;
@property (weak, nonatomic) IBOutlet UIView *weixinView;

@property (weak, nonatomic) IBOutlet UIView *nichengView;
@property (weak, nonatomic) IBOutlet UIView *zhifubaoView;

@property (weak, nonatomic) IBOutlet UIView *nameView;

- (IBAction)paizhaoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewHeight;
@property (weak, nonatomic) IBOutlet UIView *bankView;



- (IBAction)selectAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
