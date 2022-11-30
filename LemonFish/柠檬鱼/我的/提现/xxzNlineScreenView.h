
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzNlineScreenView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnCopy;
- (IBAction)copyAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *inputTf;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

NS_ASSUME_NONNULL_END
