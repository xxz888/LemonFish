
#import "xxzSilderController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^AddSuccessBlock)(void);
@interface xxzHeaderController : xxzSilderController
@property (nonatomic ,strong)NSString * name;
@property (nonatomic ,strong)NSString * idCard;
@property (nonatomic ,copy)AddSuccessBlock block;
@property (nonatomic ,strong)NSString * empowerToken;
@property (nonatomic ,strong)NSDictionary * userDic;

@end

NS_ASSUME_NONNULL_END
