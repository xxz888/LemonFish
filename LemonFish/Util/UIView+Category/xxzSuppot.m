
#import "xxzSuppot.h"

@implementation UIImageView (Category)


+ (instancetype)getUIImageView:(NSString *)imageName{
    UIImageView *wideoView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    return wideoView;
}

@end
