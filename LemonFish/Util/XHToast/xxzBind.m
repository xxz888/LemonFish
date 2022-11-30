#import "xxzBind.h"
#import <QuartzCore/QuartzCore.h>

@interface xxzBind (private)

- (id)initWithText:(NSString *)text_;
- (void)setDuration:(CGFloat) duration_;

- (void)dismisToast;
- (void)toastTaped:(UIButton *)sender_;

- (void)showAnimation;
- (void)hideAnimation;

- (void)show;
- (void)showFromTopOffset:(CGFloat) topOffset_;
- (void)showFromBottomOffset:(CGFloat) bottomOffset_;

@end


@implementation xxzBind


+ (void)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_{
    [xxzBind showWithText:text_  topOffset:topOffset_ duration:DEFAULT_DISPLAY_DURATION];
}



- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:[UIDevice currentDevice]];
}


+ (void)showWithText:(NSString *)text_{
    [xxzBind showWithText:text_ duration:DEFAULT_DISPLAY_DURATION];
}


-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 1.0f;
    [UIView commitAnimations];
}


+ (void)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_
            duration:(CGFloat)duration_{
    xxzBind *huodongjiangli = [[xxzBind alloc] initWithText:text_];
    [huodongjiangli setDuration:duration_];
    [huodongjiangli showFromBottomOffset:bottomOffset_];
}


+ (void)showWithText:(NSString *)text_
        bottomOffset:(CGFloat)bottomOffset_{
    [xxzBind showWithText:text_  bottomOffset:bottomOffset_ duration:DEFAULT_DISPLAY_DURATION];
}


- (void)setDuration:(CGFloat) duration_{
    duration = duration_;
}


+ (void)showWithText:(NSString *)text_
           topOffset:(CGFloat)topOffset_
            duration:(CGFloat)duration_{
    xxzBind *huodongjianglin = [[xxzBind alloc] initWithText:text_];
    [huodongjianglin setDuration:duration_];
    [huodongjianglin showFromTopOffset:topOffset_];
}


- (void)showFromBottomOffset:(CGFloat) bottom_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom_ + contentView.frame.size.height/2));
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}


- (void)deviceOrientationDidChanged:(NSNotification *)notify_{
    [self hideAnimation];
}


-(void)dismissToast{
    [contentView removeFromSuperview];
}



- (id)initWithText:(NSString *)text_
{
    if (self = [super init])
    {
        
        text = [text_ copy];
        
        UIFont *oldF = [UIFont boldSystemFontOfSize:14];
        CGSize input = [text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
        
        UILabel *launchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, input.width + 12, input.height + 12)];
        launchLabel.backgroundColor = [UIColor clearColor];
        launchLabel.textColor = [UIColor whiteColor];
        launchLabel.textAlignment = NSTextAlignmentCenter;
        launchLabel.font = oldF;
        launchLabel.text = text;
        launchLabel.numberOfLines = 0;
        
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, launchLabel.frame.size.width, launchLabel.frame.size.height)];
        contentView.layer.cornerRadius = 5.0f;
        contentView.layer.borderWidth = 1.0f;
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        contentView.backgroundColor = [UIColor colorWithRed:0.2f
                                                      green:0.2f
                                                       blue:0.2f
                                                      alpha:0.75f];
        [contentView addSubview:launchLabel];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [contentView addTarget:self
                        action:@selector(toastTaped:)
              forControlEvents:UIControlEventTouchDown];
        contentView.alpha = 0.0f;
        
        duration = DEFAULT_DISPLAY_DURATION;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}


-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    contentView.alpha = 0.0f;
    [UIView commitAnimations];
}


-(void)toastTaped:(UIButton *)sender_{
    [self hideAnimation];
}


- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = window.center;
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}


- (void)showFromTopOffset:(CGFloat) top_{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    contentView.center = CGPointMake(window.center.x, top_ + contentView.frame.size.height/2);
    [window  addSubview:contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];
}


+ (void)showWithText:(NSString *)text_
            duration:(CGFloat)duration_{
    xxzBind *huodongjiangliN = [[xxzBind alloc] initWithText:text_];
    [huodongjiangliN setDuration:duration_];
    [huodongjiangliN show];
}

@end
