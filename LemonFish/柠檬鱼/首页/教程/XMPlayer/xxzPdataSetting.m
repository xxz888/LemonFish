
#import "xxzPdataSetting.h"
#import "xxzInfo.h"
#import "xxzRticle.h"
#import "XMPlayerConfig.h"

@implementation xxzPdataSetting
static UIView *bgView;



+ (void)removeAlertLabel:(UILabel *)sender {
    
    UILabel *boutLabel = (UILabel *)sender;
    [UIView animateWithDuration:0.5 animations:^{
        boutLabel.alpha = 0;
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [boutLabel removeFromSuperview];
        [bgView removeFromSuperview];
    }];
}

#pragma mark - 清除当初的提示框

+ (void)xm_showText:(NSString *)text{
    
    if (!text.length) return;
    
    [bgView removeFromSuperview];
    bgView = [[UIView alloc] init];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    bgView.layer.cornerRadius = 6;
    bgView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    
    CGSize input = [xxzRticle sizeWithText:text andFont:[UIFont systemFontOfSize:14] andMaxW:(WIDTH - 2*40)];
    
    UILabel *boutLabelb = [[UILabel alloc] init];
    boutLabelb.frame = CGRectMake(16, 10, input.width, input.height);
    boutLabelb.text = text;
    boutLabelb.textColor = [UIColor whiteColor];
    boutLabelb.textAlignment = NSTextAlignmentCenter;
    boutLabelb.font = [UIFont systemFontOfSize:14];
    boutLabelb.numberOfLines = 0;
    boutLabelb.lineBreakMode = NSLineBreakByWordWrapping | NSLineBreakByTruncatingTail;
    [bgView addSubview:boutLabelb];
    
    CGFloat nvite = boutLabelb.width+2*boutLabelb.x;
    CGFloat tint = boutLabelb.height+2*boutLabelb.y;
    bgView.frame = CGRectMake((WIDTH-nvite)/2.0, (HEIGHT-tint)/2.0, nvite, tint);
    
    
    [self performSelector:@selector(removeAlertLabel:) withObject:boutLabelb afterDelay:1.0];
}

@end
