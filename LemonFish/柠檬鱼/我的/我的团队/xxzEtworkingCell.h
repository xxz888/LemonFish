
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzEtworkingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *setRateBtn;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellPhone;
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UILabel *incomeTIme;
@property (weak, nonatomic) IBOutlet UILabel *leijishouruLbl;
@property (weak, nonatomic) IBOutlet UILabel *tuanduizhongshuLbl;
@property (weak, nonatomic) IBOutlet UILabel *benyuejiaoyiliangLbl;
@property (weak, nonatomic) IBOutlet UILabel *kehushuLbl;
@property (nonatomic ,strong)NSDictionary * startDic;
@end

NS_ASSUME_NONNULL_END
