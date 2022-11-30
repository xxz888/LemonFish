
#import "xxzOrgetController.h"
#import <QMUIKit/QMUIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface xxzSilderController : xxzOrgetController

@property (nonatomic, strong) QMUITableView *mc_tableview;
@property (nonatomic, strong) QMUINavigationTitleView *mc_titleview;


- (QMUITableView *)getMCTableView;



- (void)layoutTableView;









- (NSDictionary *)loadUserData;
- (void)updateUserData:(NSDictionary *)data;
- (NSDictionary *)loadSuperMembersData;
- (void)updateSuperMembersData:(NSDictionary *)data;

- (NSDictionary *)getToObtainTheSpecified:(NSString *)key;
- (void)updateToObtainTheSpecified:(NSString *)key Data:(NSDictionary *)data;


- (BOOL)RealNameAuthentication;
- (BOOL)CameraPermissions;

- (void)loginPastDue;

- (BOOL)toLogin;

#pragma 冒泡排序 大的在前
- (void)setBubbleSortArray:(NSMutableArray *)dataArr FieldString:(NSString *)fieldStr;


- (BOOL)isEmpty:(id)object;


#pragma mark - 获取单次定位地址
- (void)addLocationManager:(void(^)(NSString *province,NSString *city))backname;


- (void)getAddressThan:(NSString *)province City:(NSString *)city isThan:(void(^)(NSString *provinceCode,NSString *cityCode,BOOL isThan))backname;




- (float)randomBetween:(float)smallNum AndBigNum:(float)bigNum AndPrecision:(NSInteger)precision;
-(UIView *)returnCardView:(CGRect)frame colorOne:(UIColor *)colorOne colorTwo:(UIColor *)colorTwo;
@end

NS_ASSUME_NONNULL_END
