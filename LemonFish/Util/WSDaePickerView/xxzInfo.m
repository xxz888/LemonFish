
#import "xxzInfo.h"

@implementation UIView (Extension)
#pragma mark - frame

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


+ (CGFloat)getLabelHeightByWidth:(CGFloat)width Title:(NSString *)title font:(UIFont *)font {
    
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    menuLabel.text = title;
    menuLabel.font = font;
    menuLabel.numberOfLines = 0;
    [menuLabel sizeToFit];
    CGFloat masks = menuLabel.frame.size.height;
    return masks;
}


- (UIViewController *)viewController {
    
    id register_d = [self nextResponder];
    while (register_d != nil) {
        if ([register_d isKindOfClass:[UIViewController class]]) {
            UIViewController *scriptController = (UIViewController *)register_d;
            return scriptController;
        }
        register_d = [register_d nextResponder];
    }
    return nil;
}


- (CGFloat)navigationBarHeight {
    if ([UIScreen mainScreen].bounds.size.width >= 375 && [UIScreen mainScreen].bounds.size.width <= 428 && [UIScreen mainScreen].bounds.size.height >= 812 && [UIScreen mainScreen].bounds.size.height <= 926) {
        return 88.0f;
    }
    return 64.0f;
}


+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    
    
    CAGradientLayer *shouxufei = [CAGradientLayer layer];
    shouxufei.frame = view.bounds;
    
    shouxufei.cornerRadius = view.cornerRadius;
    shouxufei.masksToBounds = YES;

    shouxufei.colors = @[(__bridge id)[UIColor colorWithHexString:fromHexColorStr].CGColor,(__bridge id)[UIColor colorWithHexString:toHexColorStr].CGColor];
    
    
    shouxufei.startPoint = CGPointMake(0, 0);
    shouxufei.endPoint = CGPointMake(1, 1);
    
    
    shouxufei.locations = @[@0,@1];
    
    return shouxufei;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (void)setPartCornerRadiusWithRoundRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    
    UIBezierPath *keyongyue = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners: corners cornerRadii:cornerRadii];
    CAShapeLayer *foot = [[CAShapeLayer alloc] init];
    foot.frame = self.bounds;
    foot.path = keyongyue.CGPath;
    self.layer.mask = foot;
    
}


- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGFloat)centerX {
    return self.center.x;
}


- (CGSize)size {
    return self.frame.size;
}


- (CGFloat)centerY {
    return self.center.y;
}


- (CGFloat)x {
    return self.frame.origin.x;
}


- (void)setShadowAddWithView:(UIView *)view{
    
    CALayer *sign = [CALayer layer];
    sign.frame = self.frame;
    sign.cornerRadius= self.cornerRadius;
    sign.backgroundColor= [UIColor grayColor].CGColor;
    sign.masksToBounds=NO;
    sign.shadowColor = [UIColor grayColor].CGColor;
    sign.shadowOffset = CGSizeMake(0,0);
    sign.shadowOpacity = 0.4f;
    sign.shadowRadius = self.cornerRadius;
    [view.layer insertSublayer:sign below:self.layer];
}


- (CGFloat)statusBarHeight {
    
    CGRect clean = [[UIApplication sharedApplication] statusBarFrame];
    return clean.size.height;
}


- (void)rounded:(CGFloat)cornerRadius {
    [self rounded:cornerRadius width:0 color:nil];
}


- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}


- (CGFloat)top {
    return self.frame.origin.y;
}


- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}


- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}



- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}


- (CGFloat)tabBarHeight {
    if ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812) {
        return 83.0f;
    }
    return 49.0f;
}


-(void)shadow:(UIColor *)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset {
    
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowOffset = offset;
}


- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint mine = self.center;
    mine.x = centerX;
    self.center = mine;
    
}

#pragma mark - layer

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.size.height + self.frame.origin.y;
}


- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



- (CGFloat)left {
    return self.frame.origin.x;
}



- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.clipsToBounds = YES;
}


#pragma mark - base

- (UIColor *)borderColor{
    return self.borderColor;
}


- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}


- (void)border:(CGFloat)borderWidth color:(UIColor *)borderColor {
    [self rounded:0 width:borderWidth color:borderColor];
}


- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}



- (void)setGradualChangingColorAddView:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr{
    
    
    CAGradientLayer *shouxufeig = [CAGradientLayer layer];
    shouxufeig.frame = self.frame;
    
    shouxufeig.cornerRadius = self.cornerRadius;
    shouxufeig.masksToBounds = YES;
    
    shouxufeig.colors = @[(__bridge id)[UIColor colorWithHexString:fromHexColorStr].CGColor,(__bridge id)[UIColor colorWithHexString:toHexColorStr].CGColor];
    
    
    shouxufeig.startPoint = CGPointMake(0, 0);
    shouxufeig.endPoint = CGPointMake(1, 1);
    
    
    shouxufeig.locations = @[@0,@1];
    
    [view.layer insertSublayer:shouxufeig below:self.layer];
}


- (void)setCenterY:(CGFloat)centerY{
    CGPoint minez = self.center;
    minez.y = centerY;
    self.center = minez;
}


- (CGFloat)right {
    return self.frame.size.width + self.frame.origin.x;
}


- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *)borderColor {
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [borderColor CGColor];
    self.layer.masksToBounds = YES;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGPoint)origin {
    return self.frame.origin;
}


- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}


- (CGFloat)height {
    return self.frame.size.height;
}


- (CGFloat)width {
    return self.frame.size.width;
}


-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner {
    
    UIBezierPath *keyongyueD = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *foot9 = [[CAShapeLayer alloc] init];
    foot9.frame = self.bounds;
    foot9.path = keyongyueD.CGPath;
    self.layer.mask = foot9;
}

@end

@implementation UIView (MotionEffect)

NSString *const centerX = @"center.x";
NSString *const centerY = @"center.y";

#pragma mark - Motion Effect

- (void)addCenterMotionEffectsXYWithOffset:(CGFloat)offset {
    
    
    if(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) return;
    
    UIInterpolatingMotionEffect *tap;
    UIInterpolatingMotionEffect *move;
    
    tap = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:centerX
                                                            type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    tap.maximumRelativeValue = @(offset);
    tap.minimumRelativeValue = @(-offset);
    
    move = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:centerY
                                                            type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    move.minimumRelativeValue = @(-offset);
    move.maximumRelativeValue = @(offset);
    
    UIMotionEffectGroup *rate = [[UIMotionEffectGroup alloc] init];
    rate.motionEffects = @[tap, move];
    
    [self addMotionEffect:rate];
}

@end



@implementation UIView (AddToWindow)

-(void) addToWindow
{
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)])
    {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}


@end


@implementation UIView (Screenshot)

- (UIImage*) screenshot {
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
    
}

- (UIImage *) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    UIGraphicsBeginImageContext(self.bounds.size);
    
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (UIImage*) screenshotInFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end

@implementation UIView (HFXBadge)
static const void *badgeViewKey = "badgeViewKey";
static NSInteger const pointWidth = 10; 
static NSInteger const rightRange = 2; 
static CGFloat const badgeFont = 9; 



- (void)showBadge {
    
    if (self.badge == nil) {
        CGRect frame = CGRectMake(CGRectGetWidth(self.frame) + rightRange, -pointWidth / 2, pointWidth, pointWidth);
        self.badge = [[UILabel alloc] initWithFrame:frame];
        self.badge.backgroundColor = [UIColor redColor];
        
        self.badge.layer.cornerRadius = pointWidth / 2;
        
        self.badge.layer.masksToBounds = YES;
        [self addSubview:self.badge];
        [self bringSubviewToFront:self.badge];
    }else {
        [self hidenBadge];
        [self addSubview:self.badge];
    }
}


- (void)showBadgeWithCount:(NSInteger)redCount {
    if (redCount < 0) {
        return;
    }
    [self showBadge];
    self.badge.textColor = [UIColor whiteColor];
    self.badge.font = [UIFont systemFontOfSize:badgeFont];
    self.badge.textAlignment = NSTextAlignmentCenter;
    self.badge.text = (redCount > 99 ? [NSString stringWithFormat:@"99+"] : [NSString stringWithFormat:@"%@", @(redCount)]);
    [self.badge sizeToFit];
    CGRect frame = self.badge.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    frame.origin.y = -frame.size.height / 2;
    if (CGRectGetWidth(frame) < CGRectGetHeight(frame)) {
        frame.size.width = CGRectGetHeight(frame);
    }
    self.badge.frame = frame;
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame) / 2;
}


- (void)setBadge:(UILabel *)badge{
    objc_setAssociatedObject(self, badgeViewKey, badge, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - GetterAndSetter


- (UILabel *)badge
{
    
    return objc_getAssociatedObject(self, badgeViewKey);
}


- (void)hidenBadge
{
    
    [self.badge removeFromSuperview];
}

@end
