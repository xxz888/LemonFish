
#import <UIKit/UIKit.h>
#import "xxzXplain.h"


typedef enum{
    DateStyleShowYearMonthDayHourMinute  = 0,
    DateStyleShowMonthDayHourMinute,
    DateStyleShowYearMonthDay,
    DateStyleShowMonthDay,
    DateStyleShowHourMinute,
    DateStyleShowMonthDayWeekHourMinute,
    
    DateStyleShowHourPMAM,
    DateStyleShowMonth,
    DateStyleShowWeekly,
    DateStyleShowMM,
    DateStyleShowDD,
    DateStyleShowYear,
    DateStyleShowOtherString
}WSDateStyle;


@interface xxzConfirmView : UIView


@property (nonatomic,strong)UIColor *doneButtonColor;

@property (nonatomic,strong)UIColor *dateLabelColor;

@property (nonatomic,strong)UIColor *datePickerColor;


@property (nonatomic,strong) NSArray * MyearArray;


@property (nonatomic,strong) NSString * DicKey;

@property (nonatomic, retain) NSDate *maxLimitDate;

@property (nonatomic, retain) NSDate *minLimitDate;


@property (nonatomic, retain) UIColor *yearLabelColor;


@property (nonatomic, strong) NSString *showYearViewMax;




-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle CompleteBlock:(void(^)(NSDate * Data , NSString * Str , id OtherString))completeBlock;


-(instancetype)initWithDateStyle:(WSDateStyle)datePickerStyle scrollToDate:(NSDate *)scrollToDate CompleteBlock:(void(^)(NSDate * Data , NSString * Str , id OtherString))completeBlock;


-(void)show;


@end

