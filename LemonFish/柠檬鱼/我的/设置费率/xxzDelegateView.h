
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzDelegateView : UIView
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navImvHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;

@property (weak, nonatomic) IBOutlet UILabel *navTitle;

@property (weak, nonatomic) IBOutlet UIView *cardBackView;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaName;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UILabel *zhangdanriLbl;
@property (weak, nonatomic) IBOutlet UILabel *hankanriLbl;
@property (weak, nonatomic) IBOutlet UILabel *shengyushijianLbl;
@property (weak, nonatomic) IBOutlet UIView *huankuanrateView;
@property (weak, nonatomic) IBOutlet UIView *shuakarateView;

@property (weak, nonatomic) IBOutlet UIView *huabeiView;




@property (weak, nonatomic) IBOutlet UITextField *huankuanTf;
@property (weak, nonatomic) IBOutlet UITextField *shuakaTf;
@property (weak, nonatomic) IBOutlet UITextField *huabeiTf;


@property (weak, nonatomic) IBOutlet UIView *handCishuView;

@property (weak, nonatomic) IBOutlet UIView *handxuanzeshijianView;
@property (weak, nonatomic) IBOutlet UIView *autoJieshushijianView;



@property (weak, nonatomic) IBOutlet UITextField *zhangdanjineTf;
@property (weak, nonatomic) IBOutlet UITextField *keyongyueTf;
@property (weak, nonatomic) IBOutlet UITextField *huankuancishuTf;
@property (weak, nonatomic) IBOutlet UITextField *xuanzeshjianTf;
@property (weak, nonatomic) IBOutlet UITextField *jieshushijianTf;
@property (weak, nonatomic) IBOutlet UITextField *xuanzediqvTf;
@property (weak, nonatomic) IBOutlet UIView *xuanzedeqvView;


@property (weak, nonatomic) IBOutlet UIButton *huankuancishuBtn;
@property (weak, nonatomic) IBOutlet UIButton *xuanzeshijianBtn;
@property (weak, nonatomic) IBOutlet UIButton *jieshushijianBtn;
@property (weak, nonatomic) IBOutlet UIButton *xiaofeidiqvBtn;

@property (weak, nonatomic) IBOutlet UIButton *prePlanBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stackViewHeight;

@end

NS_ASSUME_NONNULL_END
