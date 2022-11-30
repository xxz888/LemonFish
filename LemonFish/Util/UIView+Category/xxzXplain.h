
#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

typedef NS_ENUM(NSUInteger, DateType) {
    DateTypeYMD,
    DateTypeHms,
    DateTypeYMDHms
};
@interface NSDate (hfx)

- (BOOL)isYesterday;


- (BOOL)isToday;


- (BOOL)isThisYear;

+ (NSInteger)comparewithDate:(NSString*)bDate;


+ (NSString *)getBefore;

+ (NSString *)getBeforeWithYear:(NSInteger)year;
+ (NSString *)getBeforeWithMonth:(NSInteger)month;
+ (NSString *)getBeforeWithDay:(NSInteger)day;

+ (NSString *)GetCurrentDateType: (DateType)type;

+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;



+ (NSString *)getCurrentWithFormat:(NSString *)format;

+ (NSString *)timeStr:(long long)timestamp;

+ (NSString *)dateTimeDifferenceWithType: (DateType)type startTime:(NSString *)startTime endTime:(NSString *)endTime;


+ (NSString *) compareCurrentTime:(NSTimeInterval) compareDate;

+ (NSString *) getDateStringWithTimestamp:(NSTimeInterval)timestamp;

+ (NSString *) getStringWithTimestamp:(NSNumber *)timestamp formatter:(NSString*)formatter;
+ (NSString *)stringFromDate:(NSDate *)date WithFormat:(NSString *)format;

+ (NSDate *)dateFromString:(NSString *)string WithFormat:(NSString *)format;

+ (NSArray *)getCurrentWeekBeginDate:(NSDate *)date;
+ (NSArray *)getCurrentYearBeginDate:(NSDate *)date;
+ (NSArray *)getCurrentQuarterBeginDate:(NSDate *)date;
+ (NSArray *)getCurrentMonthBeginDate:(NSDate *)date;


+ (NSCalendar *) currentCalendar; 

+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle;
- (NSString *) stringWithFormat: (NSString *) format;
@property (nonatomic, readonly) NSString *shortString;
@property (nonatomic, readonly) NSString *shortDateString;
@property (nonatomic, readonly) NSString *shortTimeString;
@property (nonatomic, readonly) NSString *mediumString;
@property (nonatomic, readonly) NSString *mediumDateString;
@property (nonatomic, readonly) NSString *mediumTimeString;
@property (nonatomic, readonly) NSString *longString;
@property (nonatomic, readonly) NSString *longDateString;
@property (nonatomic, readonly) NSString *longTimeString;

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;

- (BOOL) isTomorrow;

- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;

- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isThisMonth;
- (BOOL) isNextMonth;
- (BOOL) isLastMonth;

- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isNextYear;
- (BOOL) isLastYear;

- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

- (BOOL) isInFuture;
- (BOOL) isInPast;

- (BOOL) isTypicallyWorkday;
- (BOOL) isTypicallyWeekend;

- (NSDate *) dateByAddingYears: (NSInteger) dYears;
- (NSDate *) dateBySubtractingYears: (NSInteger) dYears;
- (NSDate *) dateByAddingMonths: (NSInteger) dMonths;
- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths;
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes;

- (NSDate *) dateAtStartOfDay;
- (NSDate *) dateAtEndOfDay;

- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;
- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate;

@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; 
@property (readonly) NSInteger year;

- (NSDate *)dateWithYMD;
- (NSDate *)dateWithFormatter:(NSString *)formatter;
@end
