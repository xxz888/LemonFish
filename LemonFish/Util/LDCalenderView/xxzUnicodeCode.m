
#import "xxzUnicodeCode.h"

@implementation UIColor (Extend)

+ (UIColor *)hexColorWithString:(NSString *)string alpha:(float) alpha
{
    if ([string hasPrefix:@"#"]) {
        string = [string substringFromIndex:1];
    }
    
    NSString *stack = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([stack length] != 6) {
        return [UIColor whiteColor];
    }
    
    NSRange handxuanzeshijian;
    handxuanzeshijian.location = 0;
    handxuanzeshijian.length = 2;
    NSString *nnews = [stack substringWithRange:handxuanzeshijian];
    
    handxuanzeshijian.location += handxuanzeshijian.length ;
    NSString *chakanjihua = [stack substringWithRange:handxuanzeshijian];
    
    handxuanzeshijian.location += handxuanzeshijian.length ;
    NSString *search = [stack substringWithRange:handxuanzeshijian];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:nnews] scanHexInt:&r];
    [[NSScanner scannerWithString:chakanjihua] scanHexInt:&g];
    [[NSScanner scannerWithString:search] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}


+ (UIColor *)hexColorWithString:(NSString *)string
{
    return [UIColor hexColorWithString:string alpha:1.0f];
}
@end
