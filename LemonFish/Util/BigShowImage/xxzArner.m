
#import "xxzArner.h"

@implementation xxzArner

static CGRect oldframe;



+(void)scanBigImageWithImageView:(UIImageView *)currentImageview alpha:(CGFloat)alpha {
    
    
    UIImage *huankuanblockImage = currentImageview.image;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *remenhuodongView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    oldframe = [currentImageview convertRect:currentImageview.bounds toView:window];
    [remenhuodongView setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:alpha]];
    
    
    [remenhuodongView setAlpha:0];
    
    UIImageView *wideoView = [[UIImageView alloc] initWithFrame:oldframe];
    [wideoView setImage:huankuanblockImage];
    wideoView.contentMode =UIViewContentModeScaleAspectFit;
    [wideoView setTag:1024];
    [remenhuodongView addSubview:wideoView];
    
    [window addSubview:remenhuodongView];
    
    
    
    UITapGestureRecognizer *card = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImageView:)];
    [remenhuodongView addGestureRecognizer:card];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        CGFloat y,width,height;
        y = ([UIScreen mainScreen].bounds.size.height - huankuanblockImage.size.height * [UIScreen mainScreen].bounds.size.width / huankuanblockImage.size.width) * 0.5;
        
        width = [UIScreen mainScreen].bounds.size.width;
        
        height = huankuanblockImage.size.height * [UIScreen mainScreen].bounds.size.width / huankuanblockImage.size.width;
        [wideoView setFrame:CGRectMake(0, y, width, height)];
        
        [remenhuodongView setAlpha:1];
    } completion:^(BOOL finished) {
        
    }];
    
}



+(void)hideImageView:(UITapGestureRecognizer *)tap{
    
    UIView *remenhuodongView2 = tap.view;
    
    UIImageView *wideoViewt = [tap.view viewWithTag:1024];
    
    [UIView animateWithDuration:0.4 animations:^{
        [wideoViewt setFrame:oldframe];
        [remenhuodongView2 setAlpha:0];
    } completion:^(BOOL finished) {
        
        [remenhuodongView2 removeFromSuperview];
    }];
}


@end
