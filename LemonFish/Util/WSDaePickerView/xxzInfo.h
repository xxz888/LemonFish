
#import <UIKit/UIKit.h>

@interface UIView (Extension)


@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;


@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (assign, nonatomic) IBInspectable UIColor *borderColor;


- (void)rounded:(CGFloat)cornerRadius;


- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor;


- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor;


-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;


-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

- (UIViewController *)viewController;

+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font;
- (CGFloat)navigationBarHeight;
- (CGFloat)tabBarHeight;
- (CGFloat)statusBarHeight;
- (void)setShadowAddWithView:(UIView *)view;

+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
- (void)setGradualChangingColorAddView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
- (void)setPartCornerRadiusWithRoundRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii ;

@end

@interface UIView (MotionEffect)
- (void) addCenterMotionEffectsXYWithOffset:(CGFloat)offset;
@end


@interface UIView (Window)

- (void) addToWindow;

@end

@interface UIView (Screenshot)

- (UIImage*) screenshot;

- (UIImage*) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;

- (UIImage*) screenshotInFrame:(CGRect)frame;


@end

@interface UIView (HFXBadge)


@property (nonatomic, strong) UILabel *badge;


- (void)showBadge;


- (void)showBadgeWithCount:(NSInteger)redCount;


- (void)hidenBadge;

@end
