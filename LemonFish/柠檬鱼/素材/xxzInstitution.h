
#import <Foundation/Foundation.h>
#import "QMUIPopupContainerView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^didSelectedBlock)(NSInteger index);
@interface xxzInstitution : QMUIPopupContainerView

@property(nonatomic, copy) didSelectedBlock selectedBlock;

@end

NS_ASSUME_NONNULL_END
