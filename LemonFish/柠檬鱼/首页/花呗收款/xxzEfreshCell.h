
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzEfreshCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;


@property (weak, nonatomic) IBOutlet UILabel *channelTitle;
@property (weak, nonatomic) IBOutlet UILabel *danbixianeLbl;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyishijianLbl;
@property (weak, nonatomic) IBOutlet UILabel *danrixianeLbl;
@property (weak, nonatomic) IBOutlet UILabel *jiaoyifeiLvLbl;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

NS_ASSUME_NONNULL_END
