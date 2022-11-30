
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellIcon;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellTime;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (weak, nonatomic) IBOutlet UILabel *cellStatus;

@end

NS_ASSUME_NONNULL_END
