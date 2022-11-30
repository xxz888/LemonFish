

#import "xxzMessage.h"

@implementation NSObject (ZXPUnicode)


+ (NSString *)stringByReplaceUnicode:(NSString *)string
{
    NSMutableString *hankanri = [string mutableCopy];
    [hankanri replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, hankanri.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)hankanri, NULL, transform, YES);
    return hankanri;
}

@end
