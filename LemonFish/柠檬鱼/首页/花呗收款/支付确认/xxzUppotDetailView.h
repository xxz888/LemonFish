
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SendCodeBlock)(void);
typedef void(^NextBlock)(void);

@interface xxzUppotDetailView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet UIImageView *backImv;

- (IBAction)nextAction:(id)sender;
@property (nonatomic ,copy)SendCodeBlock sendCodeBlock;
@property (nonatomic ,copy)NextBlock nextblock;

- (IBAction)sendCodeAction:(id)sender;
- (IBAction)selectAction:(id)sender;
@property (nonatomic ,strong)NSDictionary * startDic;



@property (weak, nonatomic) IBOutlet UITextField *priceTf;
@property (weak, nonatomic) IBOutlet UITextField *danbixianeLbl;
@property (weak, nonatomic) IBOutlet UITextField *danrixianeLbl;
@property (weak, nonatomic) IBOutlet UITextField *zongshouxufeiLbl;

@property (weak, nonatomic) IBOutlet UITextField *daozhangjineLbl;
@property (weak, nonatomic) IBOutlet UITextField *xiaofeidiqvLbl;
@property (weak, nonatomic) IBOutlet UIView *xiaofeidiqvView;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeViewHeight;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (nonatomic ,strong)NSString * cityCode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleHeight;

@end

NS_ASSUME_NONNULL_END
