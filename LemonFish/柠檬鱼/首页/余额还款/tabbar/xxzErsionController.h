
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzErsionController : UITabBarController
@property (nonatomic ,strong)NSString * empowerToken;
- (instancetype)initWithEmpowerToken:(NSString *)empowerToken userDic:(NSDictionary *)userDic;
@property (nonatomic ,strong)NSDictionary * userDic;


@end

NS_ASSUME_NONNULL_END
