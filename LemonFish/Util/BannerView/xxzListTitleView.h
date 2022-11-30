
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SXxxzInsiPhone<NSObject>
-(void)sendImageName:(NSInteger)selectImage;

@end



@interface xxzListTitleView : UIView

@property (nonatomic,weak)id<SXxxzInsiPhone>delegate;
-(id)initWithFrame:(CGRect)frame andImageNameArray:
(NSMutableArray * )imageNameArray andIsRunning:(BOOL)isRunning;

@end

NS_ASSUME_NONNULL_END
