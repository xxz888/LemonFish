

#import <UIKit/UIKit.h>

#define SPEED 5       
#define RING_LINE_WIDTH 2  

typedef NS_ENUM(NSInteger, RefreshLogo) {
    RefreshLogoNone,   
    RefreshLogoCommon, 
    RefreshLogoAlbum   
};

@interface xxzRticlesUppotView : UIView

@property(nonatomic, strong)UIColor *lineColor; 
@property(nonatomic, assign, readonly)BOOL isLoading; 

+ (instancetype)refreshViewWithFrame:(CGRect)frame logoStyle:(RefreshLogo)style;

- (void)drawLineWithPercent:(CGFloat)percent;
- (void)startAnimation;
- (void)stopAnimation;

@end
