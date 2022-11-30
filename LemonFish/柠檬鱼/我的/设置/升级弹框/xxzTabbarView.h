
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzTabbarView : UIView
@property (weak, nonatomic) IBOutlet UILabel *currentVersion;
@property (weak, nonatomic) IBOutlet UILabel *storeVersion;
@property (weak, nonatomic) IBOutlet UITextView *versionContent;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;


@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *codeImv;

@end

NS_ASSUME_NONNULL_END
