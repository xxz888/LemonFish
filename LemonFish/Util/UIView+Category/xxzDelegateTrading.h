
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Category)
+ (instancetype)getUIFontSize:(CGFloat)size IsBold:(BOOL)isBold;
+ (instancetype)getUIFontSize:(CGFloat)size FontType:(NSString *)typeStr;

@end

NS_ASSUME_NONNULL_END
