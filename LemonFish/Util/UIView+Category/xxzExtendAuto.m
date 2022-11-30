
#import "xxzExtendAuto.h"

@implementation UIView (Category)



- (void)setViewTypeshadow{
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.layer.shadowOffset = CGSizeMake(0, 0.3);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 3;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = 10;
}

- (void)AddViewTypeRadius:(NSInteger)Radius{
    self.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:46/255.0 blue:35/255.0 alpha:0.05].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,4);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 6;
    self.layer.cornerRadius = Radius;
}

- (void)setYlCornerRadius:(CGFloat)ylCornerRadius{
    
    self.layer.cornerRadius = ylCornerRadius;
    self.clipsToBounds = YES;
}

-(UIImage *)captureImageFromView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size,NO, 0);
    [[UIColor clearColor] setFill];
    [[UIBezierPath bezierPathWithRect:view.bounds] fill];
    CGContextRef inyongka = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:inyongka];
    UIImage *huankuanblockImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return huankuanblockImage;
}

#pragma 给view添加同意样式

-(CGFloat)ylCornerRadius{
    return self.layer.cornerRadius;
}



- (void)getPartOfTheCornerRadius:(CGRect)frame CornerRadius:(CGFloat)radius UIRectCorner:(UIRectCorner)corner{
    UIBezierPath * photo = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *foot = [[CAShapeLayer alloc] init];
    foot.frame = frame;
    foot.path = photo.CGPath;
    self.layer.mask = foot;
}

@end


