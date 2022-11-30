
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzPhoneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellIcon;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIView *cellDiv;
@property (weak, nonatomic) IBOutlet UILabel *cellTime;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

NS_ASSUME_NONNULL_END
