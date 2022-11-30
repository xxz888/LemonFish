
#import <UIKit/UIKit.h>
typedef void (^TapActionBlock)(UITapGestureRecognizer *gestureRecoginzer);

@interface UIView (Extension1)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;

@property (nonatomic,assign) CGFloat height;

@property (nonatomic,assign,readonly) CGFloat bottom;

@property (nonatomic,assign,readonly) CGFloat maxX;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGSize  size;

- (void)rf_addTapActionWithBlock:(TapActionBlock)block;

@property (assign,nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL  masksToBounds;


@property (assign,nonatomic) IBInspectable CGFloat borderWidth;
@property (strong,nonatomic) IBInspectable NSString  *borderHexRgb;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;

-(void)selectStatus:(UIView *)whoView cornerRadius:(NSInteger)cornerRadius;

- (void)turnUrl:(UILabel *)lbl;
- (void)changeLblColor:(UILabel *)tempLabel descStr:(NSString *)descStr;
- (NSArray*)getURLFromStr:(NSString *)string ;


@end
