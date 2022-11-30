
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^UpLoadBlock)(NSInteger);
typedef void(^NextBlock)(void);

@interface xxzNewsView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;
@property (weak, nonatomic) IBOutlet UIImageView *zhengmianImv;
@property (weak, nonatomic) IBOutlet UIImageView *fanmianImv;
- (IBAction)nextAction:(id)sender;
@property (nonatomic ,copy)UpLoadBlock upLoadblock;
@property (nonatomic ,copy)NextBlock nextblock;

@property (weak, nonatomic) IBOutlet UILabel *zhengmianTag;
@property (weak, nonatomic) IBOutlet UILabel *fanmianTag;


@end

NS_ASSUME_NONNULL_END
