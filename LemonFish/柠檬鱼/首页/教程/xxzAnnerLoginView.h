
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzAnnerLoginView : UIView
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navImvHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UIImageView *chuxukaImv;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaImv;
@property (weak, nonatomic) IBOutlet UILabel *chuxukaNum;
@property (weak, nonatomic) IBOutlet UILabel *chuxukaName;
@property (weak, nonatomic) IBOutlet UIImageView *chuxukaIcon;
@property (weak, nonatomic) IBOutlet UIView *chuxukaChange;
@property (weak, nonatomic) IBOutlet UIView *chuxukaView;

@property (weak, nonatomic) IBOutlet UIButton *addBtn;


@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaName;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UIView *xinyongkaChange;
@property (weak, nonatomic) IBOutlet UIView *xinyongkaView;


@end

NS_ASSUME_NONNULL_END
