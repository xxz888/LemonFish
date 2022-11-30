
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzEditTitleView : UIView
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navImvHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UIImageView *chuxukaImv;
@property (weak, nonatomic) IBOutlet UILabel *chuxukaNum;
@property (weak, nonatomic) IBOutlet UILabel *chuxukaName;
@property (weak, nonatomic) IBOutlet UIImageView *chuxukaIcon;
@property (weak, nonatomic) IBOutlet UIView *chuxukaChange;
@property (weak, nonatomic) IBOutlet UIView *chuxukaView;

- (IBAction)recordAction:(id)sender;




@end

NS_ASSUME_NONNULL_END
