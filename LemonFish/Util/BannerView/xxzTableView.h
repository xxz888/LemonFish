
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NinaBannerSource) {
    NinaBannerStyleOnlyLocalSource = 0,         
    NinaBannerStyleOnlyWebSource = 1,           
};

@class xxzTableView;
@protocol LZxxzOprationImage <NSObject>

@optional


- (void)hhBannerView:(xxzTableView *)bannerView didSelectItemAtIndex:(NSInteger)index;

@end

@interface xxzTableView : UIView


@property (nonatomic, assign) CGFloat timeInterval;

@property (nonatomic, assign) BOOL showPageControl;

@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;

@property (nonatomic, weak) id<LZxxzOprationImage> delegate;


- (instancetype)initWithFrame:(CGRect)frame WithBannerSource:(NinaBannerSource)bannerSource WithBannerArray:(NSArray *)bannerArray;

@end
