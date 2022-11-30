
#import "xxzConfigNavigation.h"

@implementation UISegmentedControl (Style)


- (UIImage *)imageWithColor: (UIColor *)color {
    CGRect corner = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(corner.size);
    CGContextRef area = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(area, [color CGColor]);
    CGContextFillRect(area, corner);
    UIImage *headerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return headerImage;
}


- (void)ensureiOS12Style {
    
    
    if (@available(iOS 13, *)) {
        UIColor *shop = [self tintColor];
        UIImage *channelImage = [self imageWithColor:shop];
        
        [self setBackgroundImage:[self imageWithColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:channelImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:[self imageWithColor:[shop colorWithAlphaComponent:0.2]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [self setBackgroundImage:channelImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: shop, NSFontAttributeName: [UIFont getUIFontSize:15 IsBold:YES]} forState:UIControlStateNormal];
        [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont getUIFontSize:15 IsBold:YES]} forState:UIControlStateSelected];
        [self setDividerImage:channelImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [shop CGColor];
       
        
    }
}

@end
