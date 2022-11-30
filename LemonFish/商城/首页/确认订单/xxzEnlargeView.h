
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzEnlargeView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UILabel *cell1;

@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice1;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice2;

@property (weak, nonatomic) IBOutlet UILabel *cellKucun;
@property (weak, nonatomic) IBOutlet UILabel *cellAdress;
@property (weak, nonatomic) IBOutlet UILabel *cellCanshu;
@property (weak, nonatomic) IBOutlet UILabel *cellContent;
@property (weak, nonatomic) IBOutlet UIImageView *collectImv;
@property (weak, nonatomic) IBOutlet UIImageView *collectBuy;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;
@property (weak, nonatomic) IBOutlet UIView *cellNoAdress;
@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *adressLbl;
@property (weak, nonatomic) IBOutlet UIView *adressView1;

@end

NS_ASSUME_NONNULL_END
