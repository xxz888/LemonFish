
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzInstitutionExtensionView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;


@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

@property (weak, nonatomic) IBOutlet UILabel *countLbl;

@property (weak, nonatomic) IBOutlet UILabel *zhituirenshuLbl;
@property (weak, nonatomic) IBOutlet UILabel *liebianrenshuLBl;
@property (weak, nonatomic) IBOutlet UILabel *benyuejiaoyiliangLbl;

@property (weak, nonatomic) IBOutlet UITextField *searchTf;

@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@end

NS_ASSUME_NONNULL_END
