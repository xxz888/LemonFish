
#import "xxzSilderController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^selectDicBlock)(NSDictionary *);
@interface xxzPackageController : xxzSilderController
@property(nonatomic,strong)NSDictionary * startDic;

@property(nonatomic,copy)selectDicBlock block;

@end

NS_ASSUME_NONNULL_END
