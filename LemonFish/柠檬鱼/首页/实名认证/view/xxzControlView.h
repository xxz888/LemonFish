
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UpLoadBlock)(NSInteger);
typedef void(^NextBlock)(void);

@interface xxzControlView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

- (IBAction)nextAction:(id)sender;
@property (nonatomic ,copy)UpLoadBlock upLoadblock;
@property (nonatomic ,copy)NextBlock nextblock;



@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *bankTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *idCardTf;
@property (weak, nonatomic) IBOutlet UITextField *adressTf;
- (IBAction)selectAction:(id)sender;
- (IBAction)nextAction:(id)sender;

@end

NS_ASSUME_NONNULL_END
