
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzSizeCategoryView : UIView
@property (weak, nonatomic) IBOutlet UILabel *wxLbl;
@property (weak, nonatomic) IBOutlet UIButton *btnCopy;
- (IBAction)copyAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *codeImv;

@end

NS_ASSUME_NONNULL_END
