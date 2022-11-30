
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzHangeCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIView *cardBackView;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaName;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UIView *xinyongkaChange;

@property (weak, nonatomic) IBOutlet UIButton *setChuxukaBtn;

@property (weak, nonatomic) IBOutlet UIButton *setXinyongkaBtn;


@property (weak, nonatomic) IBOutlet UILabel *cardType;



@end

NS_ASSUME_NONNULL_END
