
#import "xxzInfoView.h"
#import "xxzButtonMage.h"
#import "xxzInfo.h"

@interface xxzInfoView ()<CAAnimationDelegate>

@end

@implementation xxzInfoView



- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.circleProgressLayer = [xxzButtonMage layer];
        self.circleProgressLayer.frame = CGRectMake(8, 8, self.width-2*8, self.height-2*8);
        
        self.circleProgressLayer.contentsScale = [UIScreen mainScreen].scale;
        [self.layer addSublayer:self.circleProgressLayer];
        
        self.progressLabel = [[UILabel alloc]initWithFrame:self.bounds];
        self.progressLabel.textColor = [UIColor whiteColor];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        self.progressLabel.font = [UIFont systemFontOfSize:14.0];
        self.progressLabel.text = @"0%";
        [self addSubview:self.progressLabel];
    }
    return self;
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.circleProgressLayer.progress = self.progress;
}


- (void)setProgress:(CGFloat)progress {
    
    CABasicAnimation * rgb = [CABasicAnimation animationWithKeyPath:@"progress"];
    rgb.duration = 5.0 * fabs(progress - _progress);
    rgb.toValue = @(progress);
    rgb.removedOnCompletion = YES;
    rgb.fillMode = kCAFillModeForwards;
    rgb.delegate = self;
    [self.circleProgressLayer addAnimation:rgb forKey:@"progressAni"];
    
    self.progressLabel.text = [NSString stringWithFormat:@"%0.f%%", progress * 100];
    _progress = progress;
    
    
}


- (void)drawRect:(CGRect)rect {
    
}



@end
