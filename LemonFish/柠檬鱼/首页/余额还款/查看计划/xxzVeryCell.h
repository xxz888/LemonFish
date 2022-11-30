
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzVeryCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (weak, nonatomic) IBOutlet UIView *cardBackView;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaNum;
@property (weak, nonatomic) IBOutlet UILabel *xinyongkaName;
@property (weak, nonatomic) IBOutlet UIImageView *xinyongkaIcon;
@property (weak, nonatomic) IBOutlet UIView *xinyongkaChange;

@property (weak, nonatomic) IBOutlet UIView *processView;
@property (weak, nonatomic) IBOutlet UILabel *processLbl;
@property (weak, nonatomic) IBOutlet UILabel *jihuahuankuanLbl;
@property (weak, nonatomic) IBOutlet UILabel *yihuanjineLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *processWidth;


@end

NS_ASSUME_NONNULL_END
