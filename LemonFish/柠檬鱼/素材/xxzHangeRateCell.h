
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddCountBlock)(void);
@interface xxzHangeRateCell : UITableViewCell

+ (instancetype)cellWithTableview:(UITableView *)tableview articleModel:(NSDictionary *)dic;
@property(nonatomic,copy)AddCountBlock block;
@end

NS_ASSUME_NONNULL_END
