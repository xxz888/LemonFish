
#import "xxzButtonMage.h"
#import <UIKit/UIKit.h>

@implementation xxzButtonMage



+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat area6 = self.bounds.size.width / 2;
    CGFloat library = 10.0;
    UIBezierPath * photo = [UIBezierPath bezierPathWithArcCenter:CGPointMake(area6, area6) radius:area6 - library / 2 startAngle:0.f endAngle:M_PI * 2 * self.progress clockwise:YES];
    CGContextSetRGBStrokeColor(ctx, 1, 1, 1, 1.0);
    CGContextSetLineWidth(ctx, 4);
    CGContextAddPath(ctx, photo.CGPath);
    CGContextStrokePath(ctx);
}

- (instancetype)initWithLayer:(xxzButtonMage *)layer {
    
    if (self = [super initWithLayer:layer]) {
        self.progress = layer.progress;
    }
    return self;
}


@end
