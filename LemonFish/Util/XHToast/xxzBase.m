
#import "xxzBase.h"

#define ToastDispalyDuration 1.2f
#define ToastBackgroundColor [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75]

@interface xxzBase ()
{
    UIButton *_contentView;
    CGFloat  _duration;
}

@end
@implementation xxzBase

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {

        UIFont *oldF = [UIFont boldSystemFontOfSize:16];
        NSDictionary * medium=[NSDictionary dictionaryWithObject: oldF forKey:NSFontAttributeName];
        CGRect cornerm=[text boundingRectWithSize:CGSizeMake(250,CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:medium context:nil];
        UILabel *launchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,cornerm.size.width + 40, cornerm.size.height+ 20)];
        launchLabel.backgroundColor = [UIColor clearColor];
        launchLabel.textColor = [UIColor whiteColor];
        launchLabel.textAlignment = NSTextAlignmentCenter;
        launchLabel.font = oldF;
        launchLabel.text = text;
        launchLabel.numberOfLines = 0;
        
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, launchLabel.frame.size.width, launchLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 20.0f;
        _contentView.backgroundColor = ToastBackgroundColor;
        [_contentView addSubview:launchLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self action:@selector(toastTaped:) forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        _duration = ToastDispalyDuration;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    
    return self;
}

- (void)deviceOrientationDidChanged:(NSNotification *)notify{
    [self hideAnimation];
}

+ (void)dismissToastView{
    xxzBase *huodongjiangli = [[xxzBase alloc] init];
    [huodongjiangli hideAnimation];
}

-(void)dismissToast{
    [_contentView removeFromSuperview];
}

-(void)toastTaped:(UIButton *)sender{
    [self hideAnimation];
}

- (void)setDuration:(CGFloat)duration{
    _duration = duration;
}

-(void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

-(void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)show{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = window.center;
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromTopOffset:(CGFloat)top{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    _contentView.center = CGPointMake(window.center.x, top + _contentView.frame.size.height/2);
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromBottomOffset:(CGFloat)bottom{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom + _contentView.frame.size.height/2));
    [window  addSubview:_contentView];
    [self showAnimation];

    [self performSelector:@selector(hideAnimation) withObject:self afterDelay:3.0f];

}

#pragma mark-中间显示
+ (void)showCenterWithText:(NSString *)text{
    [xxzBase showCenterWithText:text duration:ToastDispalyDuration];
}

+ (void)showCenterWithText:(NSString *)text duration:(CGFloat)duration{
    xxzBase *huodongjianglia = [[xxzBase alloc] initWithText:text];
    [huodongjianglia setDuration:duration];
    [huodongjianglia show];
}
#pragma mark-上方显示
+ (void)showTopWithText:(NSString *)text{
    
    [xxzBase showTopWithText:text  topOffset:100.0f duration:ToastDispalyDuration];
}
+ (void)showTopWithText:(NSString *)text duration:(CGFloat)duration
{
     [xxzBase showTopWithText:text  topOffset:100.0f duration:duration];
}
+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [xxzBase showTopWithText:text  topOffset:topOffset duration:ToastDispalyDuration];
}

+ (void)showTopWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    xxzBase *huodongjiangliM = [[xxzBase alloc] initWithText:text];
    [huodongjiangliM setDuration:duration];
    [huodongjiangliM showFromTopOffset:topOffset];
}
#pragma mark-下方显示
+ (void)showBottomWithText:(NSString *)text{
    
    [xxzBase showBottomWithText:text  bottomOffset:100.0f duration:ToastDispalyDuration];
}
+ (void)showBottomWithText:(NSString *)text duration:(CGFloat)duration
{
    if (text.length == 0) {
        return;
    }
    [xxzBase dismissToastView];
    [xxzBase showBottomWithText:text  bottomOffset:100.0f duration:duration];
}
+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [xxzBase showBottomWithText:text  bottomOffset:bottomOffset duration:ToastDispalyDuration];
}

+ (void)showBottomWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    xxzBase *huodongjianglii = [[xxzBase alloc] initWithText:text];
    [huodongjianglii setDuration:duration];
    [huodongjianglii showFromBottomOffset:bottomOffset];
}

@end
