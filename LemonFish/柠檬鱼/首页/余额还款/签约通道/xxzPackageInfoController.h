
#import "xxzSilderController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SingBlock)(void);

@interface xxzPackageInfoController : xxzSilderController
@property (nonatomic ,strong)NSDictionary * xinyongkaDic;

@property (nonatomic ,strong)NSDictionary * startDic;
@property (nonatomic)UIColor * colorOne;
@property (nonatomic)UIColor * colorTwo;
@property (nonatomic ,copy)SingBlock  singBlock;
@property (nonatomic ,strong)NSString * empowerToken;

@end

NS_ASSUME_NONNULL_END
