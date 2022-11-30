
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzMainEgmentView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;

- (IBAction)nextAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *huankuanjineLbl;
@property (weak, nonatomic) IBOutlet UILabel *huankuanriqiLbl;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaName;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;
@property (weak, nonatomic) IBOutlet UILabel *yuliujinLbl;
@property (weak, nonatomic) IBOutlet UILabel *jihuahuankuanbishuLbl;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiLbl;
@property (weak, nonatomic) IBOutlet UIView *cardBackView;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeijianmianLbl;
@property (weak, nonatomic) IBOutlet UIView *shouxufeijianmianView;

@end

NS_ASSUME_NONNULL_END
