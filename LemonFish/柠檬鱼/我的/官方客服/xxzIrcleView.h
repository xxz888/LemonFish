
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzIrcleView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;

@property (weak, nonatomic) IBOutlet UIImageView *backImv;

@property (weak, nonatomic) IBOutlet UILabel *guiguangContent;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellPhone;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;

@property (weak, nonatomic) IBOutlet UILabel *cellContent;
@property (weak, nonatomic) IBOutlet UIButton *cellCall;
@property (weak, nonatomic) IBOutlet UIButton *offWxBtn;

@end

NS_ASSUME_NONNULL_END
