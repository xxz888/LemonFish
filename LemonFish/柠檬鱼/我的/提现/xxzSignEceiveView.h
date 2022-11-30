
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzSignEceiveView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UILabel *shouruLbl;


@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

@property (weak, nonatomic) IBOutlet UILabel *zhanghuyueLbl;

@property (weak, nonatomic) IBOutlet UILabel *leijishouruLbl;

@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;
@property (weak, nonatomic) IBOutlet UIView *zhifubaoLine;
@property (weak, nonatomic) IBOutlet UIButton *yinhangkaBtn;
@property (weak, nonatomic) IBOutlet UIView *yinhangkaLine;
@property (weak, nonatomic) IBOutlet UILabel *yijiesuanLbl;
@property (weak, nonatomic) IBOutlet UITextField *tixianjineTf;

@property (weak, nonatomic) IBOutlet UIView *price100;
@property (weak, nonatomic) IBOutlet UIView *price200;
@property (weak, nonatomic) IBOutlet UIView *price500;
@property (weak, nonatomic) IBOutlet UIView *price1000;

@property (weak, nonatomic) IBOutlet UIView *segmentSuperview;

@property (weak, nonatomic) IBOutlet UIButton *lijitixianBtn;


@end

NS_ASSUME_NONNULL_END
