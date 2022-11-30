
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzDrawFormatterCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImv;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *cellSize;
@property (weak, nonatomic) IBOutlet UILabel *cellPrice;
@property (weak, nonatomic) IBOutlet UILabel *cellCount;

@end

NS_ASSUME_NONNULL_END
