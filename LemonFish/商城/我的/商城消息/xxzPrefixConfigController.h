
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzPrefixConfigController : xxzSilderController


@property (weak, nonatomic) IBOutlet UIImageView *bg_image;


@property (weak, nonatomic) IBOutlet UIView *navigation_View;
@property (weak, nonatomic) IBOutlet UIButton *nav_back;

@property(nonatomic,strong)NSDictionary * startDic;
@property(nonatomic,strong)NSString * type;
@property (weak, nonatomic) IBOutlet UILabel *cellContent;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellTime;

@end

NS_ASSUME_NONNULL_END
