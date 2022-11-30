
#import "xxzEtworkingConfig.h"
static char kActionHandlerTapBlockKey;

static char kActionHandlerTapGestureKey;

@implementation UIView (Extension1)

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setMasksToBounds:(BOOL)bounds
{
    self.layer.masksToBounds = bounds;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

#pragma mark - 


- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}


- (void)setSize:(CGSize)size {
    CGRect corner = self.frame;
    corner.size = size;
    self.frame = corner;
}

#pragma mark - 

-(NSString *)borderHexRgb
{
    return @"0xffffff";
}


- (void)rf_addTapActionWithBlock:(TapActionBlock)block
{
    UITapGestureRecognizer *clear = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!clear)
    {
        clear = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:clear];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, clear, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}


- (void)setHeight:(CGFloat)height {
    CGRect cornerQ = self.frame;
    cornerQ.size.height = height;
    self.frame = cornerQ;
}


- (void)changeLblColor:(UILabel *)tempLabel descStr:(NSString *)descStr {
    if (tempLabel.text) {
        NSMutableAttributedString *order = [[NSMutableAttributedString alloc]initWithString:tempLabel.text];
        [order addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#1989FA"] range:[tempLabel.text rangeOfString:descStr]];
        tempLabel.attributedText = order;
    }

}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (CGFloat)y{
    return self.frame.origin.y;
}


- (CGFloat)width {
    return self.frame.size.width;
}


- (CGSize)size {
    return self.frame.size;
}



- (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int h_bounds = (hex >> 16) & 0xFF;
    int day = (hex >> 8) & 0xFF;
    int fist = (hex) & 0xFF;
    
    return [UIColor colorWithRed:h_bounds / 255.0f
                           green:day / 255.0f
                            blue:fist / 255.0f
                           alpha:1.0f];
}



- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
#pragma mark - 


- (void)setWidth:(CGFloat)width {
    CGRect cornerK = self.frame;
    cornerK.size.width = width;
    self.frame = cornerK;
}


- (void)setCenterY:(CGFloat)centerY{
    CGPoint mine = self.center;
    mine.y = centerY;
    self.center = mine;
}


- (BOOL)masksToBounds
{
    return self.layer.masksToBounds;
}


- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (NSArray*)getURLFromStr:(NSString *)string {
    if (!string) {
        return @[@""];
    }
    NSError *canshu;
    
    NSString *stop = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *stringS = [NSRegularExpression regularExpressionWithPattern:stop
    options:NSRegularExpressionCaseInsensitive
    error:&canshu];

    NSArray *lbl = [stringS matchesInString:string
    options:0
    range:NSMakeRange(0, [string length])];

    
    NSMutableArray *modity=[[NSMutableArray alloc] init];

    for (NSTextCheckingResult *match in lbl){
        NSString* end;
        end = [string substringWithRange:match.range];
        [modity addObject:end];
    }
    if ([modity count] == 0) {
        [modity addObject:@""];
    }
    return modity;
}


- (CGPoint)origin
{
    return self.frame.origin;
}


- (CGFloat)centerX{
    return self.center.x;
}


- (CGFloat)x{
    return self.frame.origin.x;
}


- (void)turnUrl:(UILabel *)lbl{
    if ([[self getURLFromStr:lbl.text] count] == 0) {
        return;
    }
    NSString * result = [self getURLFromStr:lbl.text][0];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result]];
}


- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

- (void)setBorderHexRgb:(NSString *)borderHexRgb
{
    NSScanner *pdata = [NSScanner scannerWithString:borderHexRgb];
    unsigned touch;
    
    if (![pdata scanHexInt:&touch])
        return;
    self.layer.borderColor = [self colorWithRGBHex:touch].CGColor;
}


- (void)setCenterX:(CGFloat)centerX{
    CGPoint miney = self.center;
    miney.x = centerX;
    self.center = miney;
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        TapActionBlock zongshouxufei = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (zongshouxufei)
        {
            zongshouxufei(gesture);
        }
    }
}


- (CGFloat)maxX {
    return self.frame.origin.x + self.frame.size.width;
}


@end
