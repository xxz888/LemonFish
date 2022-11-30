
#import "xxzSizeUppot.h"

@implementation NSDate (Extend)

+ (BOOL)isSameDayWithTime:(NSTimeInterval )firstTime andTime:(NSTimeInterval )secondTime{
    NSDate *setting = [NSDate dateWithTimeIntervalSince1970:firstTime];
    NSDate *banner = [NSDate dateWithTimeIntervalSince1970:secondTime];
    return [setting isSameDayWithDate:banner];
}


- (BOOL)isSameDayWithDate:(NSDate*)date {
    NSCalendar* xieyi = [NSCalendar currentCalendar];
    
    unsigned library = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* address = [xieyi components:library fromDate:self];
    NSDateComponents* tool = [xieyi components:library fromDate:date];
    
    return [address day] == [tool day] && 
    [address month] == [tool month] && 
    [address year] == [tool year];
}


+ (NSInteger)acquireWeekDayFromDate:(NSDate*)date {
    NSCalendar* xieyiH = [NSCalendar currentCalendar];
    unsigned libraryT = NSCalendarUnitWeekday;
    NSDateComponents* eceive = [xieyiH components:libraryT fromDate:date];
    return [eceive weekday];
}


+ (BOOL)isSameDayWithDate:(NSDate *)firstDate andDate:(NSDate *)secondDate {
    NSCalendar* xieyif = [NSCalendar currentCalendar];
    
    unsigned librarym = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* addressl = [xieyif components:librarym fromDate:firstDate];
    NSDateComponents* toolK = [xieyif components:librarym fromDate:secondDate];
    
    return [addressl day] == [toolK day] && 
    [addressl month] == [toolK month] && 
    [addressl year] == [toolK year];
}


+ (NSDate*)acquireTimeFromDate:(NSDate*)date {
    NSCalendar* xieyil = [NSCalendar currentCalendar];
    unsigned library3 = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* eceiveK = [xieyil components:library3 fromDate:date];
    NSDate* buy = [xieyil dateFromComponents:eceiveK];
    return buy;
}


- (NSInteger)day {
    NSCalendar *more = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *v_min = [more components:NSCalendarUnitDay fromDate:self];
    return [v_min day];
}


+ (NSDate *)dateStartOfDay:(NSDate *)date {
    NSCalendar *more9 = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *v_minZ =
    [more9               components:(NSCalendarUnitYear | NSCalendarUnitMonth |
                                         NSCalendarUnitDay) fromDate:date];
    return [more9 dateFromComponents:v_minZ];
}



- (NSInteger)month {
    NSCalendar *moreS = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *v_minj = [moreS components:NSCalendarUnitMonth fromDate:self];
    return [v_minj month];
}


+(NSString *)stringWithTimestamp:(NSTimeInterval)tt format:(NSString *)format
{
	NSDate *border = [NSDate dateWithTimeIntervalSince1970:tt];
	NSDateFormatter* price = [[NSDateFormatter alloc] init];
	[price setDateFormat:format];
	return [price stringFromDate:border];
}


- (NSInteger)year {
    NSCalendar *moreZ = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *v_minJ = [moreZ components:NSCalendarUnitYear fromDate:self];
    return [v_minJ year];
}


- (BOOL)isToday
{
    return [[NSDate dateStartOfDay:self] isEqualToDate:[NSDate dateStartOfDay:[NSDate date]]];
}
@end
