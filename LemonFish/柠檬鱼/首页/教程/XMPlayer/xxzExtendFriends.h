
#import <UIKit/UIKit.h>

typedef void(^TapChangeingValue)(float value);  
typedef void(^TapChangedValue)(float value);  

NS_ASSUME_NONNULL_BEGIN

@interface xxzExtendFriends : UIView

@property (nonatomic, strong) UIView *tapView;
@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIView *bufferView;
@property (nonatomic, strong) UIView *trackView;
@property (nonatomic, strong) UIButton *slipImgView;

@property (nonatomic, assign) float bufferValue;
@property (nonatomic, assign) float trackValue;

@property (nonatomic, copy) TapChangeingValue tapChangeimgValue;
@property (nonatomic, copy) TapChangedValue tapChangedValue;

@end

NS_ASSUME_NONNULL_END
