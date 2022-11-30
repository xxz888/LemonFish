


#import "xxzInfo.h"

@implementation UIView (Extension)


- (void)setX:(CGFloat)x{
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setCenterY:(CGFloat)centerY{
    
    CGPoint mine = self.center;
    mine.y = centerY;
    self.center = mine;
}

- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    return;
}

- (void)setCenterX:(CGFloat)centerX{
    
    CGPoint mineD = self.center;
    mineD.x = centerX;
    self.center = mineD;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)height{
    
    return self.frame.size.height;
}

- (CGFloat)x{
    
   return self.frame.origin.x;
}

- (CGFloat)width{
    
    return self.frame.size.width;
}

- (void)setOrigin:(CGPoint)origin{
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width{
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(UIView *)lastSubviewOnX{
    if(self.subviews.count > 0){
        UIView *extendView = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.x > extendView.x)
                extendView = v;
        
        return extendView;
    }
    
    return nil;
}

- (void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)centerX{
    
    return self.center.x;
}


-(UIView *)lastSubviewOnY{
    if(self.subviews.count > 0){
        UIView *extendViewP = self.subviews[0];
        
        for(UIView *v in self.subviews)
            if(v.y > extendViewP.y)
                extendViewP = v;
        
        return extendViewP;
    }
    
    return nil;
}


- (CGFloat)centerY{
    
    return self.center.y;
}



- (void)setHeight:(CGFloat)height{
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGPoint)origin{
    
    return self.frame.origin;
}

#pragma mark ---------------- other-----------------


- (CGSize)size{
    
    return self.frame.size;
}

@end
