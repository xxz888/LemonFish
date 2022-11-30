
#import <Foundation/Foundation.h>

@interface NSDate (Extend)

- (BOOL)isToday;

+ (NSDate *)dateStartOfDay:(NSDate *)date;


+ (BOOL)isSameDayWithDate:(NSDate*)firstDate andDate:(NSDate*)secondDate;

+ (BOOL)isSameDayWithTime:(NSTimeInterval )firstTime andTime:(NSTimeInterval )secondTime;

+ (NSDate*)acquireTimeFromDate:(NSDate*)date;


+ (NSInteger)acquireWeekDayFromDate:(NSDate*)date;

- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;


+ (NSString *)stringWithTimestamp:(NSTimeInterval)tt format:(NSString *)format;
@end
