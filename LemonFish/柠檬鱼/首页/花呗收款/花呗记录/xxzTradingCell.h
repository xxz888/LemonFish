
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzTradingCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property (weak, nonatomic) IBOutlet UILabel *channelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *titleImv;
@property (weak, nonatomic) IBOutlet UILabel *cardNumLbl;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

@end

NS_ASSUME_NONNULL_END
