
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzTitleHuxukaView : UIView
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navImvHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;

@property (weak, nonatomic) IBOutlet UILabel *dingdanzhuangkuangLbl;

@property (weak, nonatomic) IBOutlet UILabel *shoukuanrenLbl;
@property (weak, nonatomic) IBOutlet UILabel *shoujihaoLbl;

@property (weak, nonatomic) IBOutlet UILabel *dingdanhaoLbl;

@property (weak, nonatomic) IBOutlet UILabel *jiaoyishijianLbl;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaLbl;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyijineLbl;
@property (weak, nonatomic) IBOutlet UILabel *chuxukaLbl;
@property (weak, nonatomic) IBOutlet UILabel *daozhangjineLbl;
@property (weak, nonatomic) IBOutlet UIImageView *logoImv;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *titlePricelbl;

@end

NS_ASSUME_NONNULL_END
