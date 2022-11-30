typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, 
    MKButtonEdgeInsetsStyleLeft, 
    MKButtonEdgeInsetsStyleBottom, 
    MKButtonEdgeInsetsStyleRight 
};
#import <UIKit/UIKit.h>

@interface UIButton (Category)

- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;



@end
