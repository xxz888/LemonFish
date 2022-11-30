
#import "xxzErsionTabbar.h"

#import "xxzExtendAuto.h"

@implementation UIButton (Category)


- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space {
    
    
    
    
    
    CGFloat acc = self.imageView.frame.size.width;
    CGFloat request = self.imageView.frame.size.height;
    
    CGFloat safe = 0.0;
    CGFloat accX = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        
        safe = self.titleLabel.intrinsicContentSize.width;
        accX = self.titleLabel.intrinsicContentSize.height;
    } else {
        safe = self.titleLabel.frame.size.width;
        accX = self.titleLabel.frame.size.height;
    }
    
    
    UIEdgeInsets zaixiankefublock = UIEdgeInsetsZero;
    UIEdgeInsets huankuanri = UIEdgeInsetsZero;
    
    
    
    switch (style) {
        case MKButtonEdgeInsetsStyleTop:
        {
            zaixiankefublock = UIEdgeInsetsMake(-accX-space/2.0, 0, 0, -safe);
            huankuanri = UIEdgeInsetsMake(0, -acc, -request-space/2.0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleLeft:
        {
            zaixiankefublock = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            huankuanri = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case MKButtonEdgeInsetsStyleBottom:
        {
            zaixiankefublock = UIEdgeInsetsMake(0, 0, -accX-space/2.0, -safe);
            huankuanri = UIEdgeInsetsMake(-request-space/2.0, -acc, 0, 0);
        }
            break;
        case MKButtonEdgeInsetsStyleRight:
        {
            zaixiankefublock = UIEdgeInsetsMake(0, safe+space/2.0, 0, -safe-space/2.0);
            huankuanri = UIEdgeInsetsMake(0, -acc-space/2.0, 0, acc+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = huankuanri;
    self.imageEdgeInsets = zaixiankefublock;
}

@end
