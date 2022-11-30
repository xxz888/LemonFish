
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzUnicodeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIView *cardBackView;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaName;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UIView *xinyongkaChange;

@property (weak, nonatomic) IBOutlet UILabel *zhangdanriLbl;
@property (weak, nonatomic) IBOutlet UILabel *hankanriLbl;
@property (weak, nonatomic) IBOutlet UILabel *shengyushijianLbl;


@property (weak, nonatomic) IBOutlet UIView *zhidingjihuaView;
@property (weak, nonatomic) IBOutlet UIView *qianyuetongdaoView;
@property (weak, nonatomic) IBOutlet UIView *chakanjihuaView;
@property (weak, nonatomic) IBOutlet UIView *xiugaiziliaoView;
@property (nonatomic ,strong)NSString * empowerToken;


@end

NS_ASSUME_NONNULL_END
