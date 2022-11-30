
#import <UIKit/UIKit.h>
typedef void(^huabeiBlock)(void);
typedef void(^xinyongkaBlock)(void);
typedef void(^zaixiankefuBlock)(void);
typedef void(^xinshoujiaochengBlock)(void);
typedef void(^shoukkuanBlock)(void);
typedef void(^huankuanBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface xxzHangeView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *safeTopHeight;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view10;
@property (weak, nonatomic) IBOutlet UIView *view11;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;

@property (weak, nonatomic) IBOutlet UIView *view1;

@property (nonatomic ,copy)huabeiBlock huabeiblock;
@property (nonatomic ,copy)xinyongkaBlock xinyongkablock;
@property (nonatomic ,copy)zaixiankefuBlock zaixiankefublock;
@property (nonatomic ,copy)xinshoujiaochengBlock xinshoujiaochengblock;
@property (weak, nonatomic) IBOutlet UIImageView *logoImv;
@property (weak, nonatomic) IBOutlet UIImageView *messageImv;

@property (nonatomic ,copy)shoukkuanBlock shoukkuanblock;
@property (nonatomic ,copy)huankuanBlock huankuanblock;
@end

NS_ASSUME_NONNULL_END
