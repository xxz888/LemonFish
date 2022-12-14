
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzOastView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UILabel *cell1;

@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice1;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellKucun;
@property (weak, nonatomic) IBOutlet UILabel *cellAdress;
@property (weak, nonatomic) IBOutlet UILabel *cellCanshu;
@property (weak, nonatomic) IBOutlet UILabel *cellContent;
@property (weak, nonatomic) IBOutlet UIImageView *collectImv;
@property (weak, nonatomic) IBOutlet UIImageView *collectBuy;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

@end

NS_ASSUME_NONNULL_END
