
#import "xxzControlBack.h"

@implementation UIColor (Hex)

+ (UIColor *)colorPairsWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}


+ (UIColor *)colorWithHexString:(NSString *)color{
    return [self colorWithHexString:color alpha:1.0f];
}


+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha{
    
    NSString *nth = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([nth length] < 6)
    {
        return [UIColor clearColor];
    }
    
    
    if ([nth hasPrefix:@"0X"])
    {
        nth = [nth substringFromIndex:2];
    }
    
    if ([nth hasPrefix:@"#"])
    {
        nth = [nth substringFromIndex:1];
    }
    if ([nth length] != 6)
    {
        return [UIColor clearColor];
    }
    
    
    NSRange handxuanzeshijian;
    handxuanzeshijian.location = 0;
    handxuanzeshijian.length = 2;
    
    NSString *nnews = [nth substringWithRange:handxuanzeshijian];
    
    handxuanzeshijian.location = 2;
    NSString *chakanjihua = [nth substringWithRange:handxuanzeshijian];
    
    handxuanzeshijian.location = 4;
    NSString *search = [nth substringWithRange:handxuanzeshijian];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:nnews] scanHexInt:&r];
    [[NSScanner scannerWithString:chakanjihua] scanHexInt:&g];
    [[NSScanner scannerWithString:search] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}
@end
