
#import <UIKit/UIKit.h>
#import "LDCalendarConst.h"

typedef void(^DaysSelectedBlock)(NSArray *result);

@interface xxzFriendsTouchView : UIView
@property (nonatomic, strong) NSArray          *defaultDays;
@property (nonatomic, copy  ) DaysSelectedBlock complete;

@property (nonatomic, assign) NSInteger minDay;
@property (nonatomic, assign) BOOL isSingle;

@property (nonatomic, strong) NSString   * zhangdanri;
@property (nonatomic, strong) NSString   * huankuanri;

-(void)setMinDay:(NSInteger)minDay;

- (id)initWithFrame:(CGRect)frame minDay:(NSInteger)minDay isSingle:(BOOL)isSingle zhangdanri:(NSString *)zhangdanri huankuanri:(NSString *)huankuanri ;
- (void)show;
- (void)hide;
@end
