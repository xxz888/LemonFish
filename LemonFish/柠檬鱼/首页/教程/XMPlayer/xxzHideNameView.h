
#import <UIKit/UIKit.h>
#import "xxzExtendFriends.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapChangeingMoveX)(float moveX);  
typedef void(^TapChangedMoveX)(float moveX);  

@interface xxzHideNameView : UIView



@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIButton *closeButton;



@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *fullScreenButton;

@property (nonatomic, strong) UIButton *playButton;


@property (nonatomic, strong) UILabel *playTimeLabel;


@property (nonatomic, strong) UILabel *totalTimeLabel;



@property (nonatomic, strong) xxzExtendFriends *playerSilder;



@property (nonatomic, assign) BOOL menuShow;

@property (nonatomic, copy) TapChangeingMoveX tapChangeimgValue;
@property (nonatomic, copy) TapChangedMoveX tapChangedValue;

@end

NS_ASSUME_NONNULL_END
