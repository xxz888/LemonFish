
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface xxzBase : NSObject

#pragma mark-中间显示

+ (void)showCenterWithText:(NSString *)text;

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration;

#pragma mark-上方显示

+ (void)showTopWithText:(NSString *)text;

+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration;

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset;

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

#pragma mark-下方显示

+ (void)showBottomWithText:(NSString *)text;

+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration;

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;

+ (void)dismissToastView;
@end
