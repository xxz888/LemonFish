
#import "xxzXplain.h"

static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (hfx)



+ (NSInteger)comparewithDate:(NSString*)bDate
{
    NSInteger ircle = 0;
    NSDateFormatter *a_view = [[NSDateFormatter alloc] init];
    [a_view setDateFormat:@"yyyy-MM-dd"];
    NSDate *titleview = [[NSDate alloc] init];
    NSDate *loadblock = [[NSDate alloc] init];
    
    titleview = [a_view dateFromString:[a_view stringFromDate:titleview]];
    loadblock = [a_view dateFromString:bDate];
    NSComparisonResult buy = [titleview compare:loadblock];
    if (buy==NSOrderedSame)
    {
        
        ircle = 0;
    }else if (buy==NSOrderedAscending) {
        
        ircle = 1;
    }else if (buy==NSOrderedDescending) {
        
        ircle = -1;
    }
    return ircle;
}



+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate{
    
    
    NSDateFormatter *cycle=[[NSDateFormatter alloc] init];
    [cycle setDateFormat:@"yyyy-MM-dd HH:mm"];

    
    
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];

    int income=((int)time)/(3600*24);
    
    
    return income;

}

+ (NSArray *)getCurrentQuarterBeginDate:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    
    double interval = 0;
    
    NSDate *close = nil;
    
    NSDate *zhifubao = nil;
    
    NSCalendar *xieyi = [NSCalendar currentCalendar];
    
    [xieyi setFirstWeekday:2];
    
    BOOL data = [xieyi rangeOfUnit:NSCalendarUnitMonth startDate:&close interval:&interval forDate:date];
    
    
    if (data) {
        
        zhifubao = [close dateByAddingTimeInterval:interval-1];
        
    }else {
        return nil;
        
    }
    
    NSDateFormatter *footer = [[NSDateFormatter alloc] init];
    
    [footer setDateFormat:@"yyyy-MM-dd"];
    
    NSDateComponents *eceive = nil;
    
    eceive = [[NSDateComponents alloc] init];

    [eceive setMonth:-2];
    NSDate *rate = [xieyi dateByAddingComponents:eceive toDate:close options:0];
    NSString *prefix_5 = [footer stringFromDate:rate];

    NSString *home = [footer stringFromDate:zhifubao];
    
    
    return @[prefix_5,home];
    
}

+ (NSDate *)getEarlyOrLaterDate:(NSDate *)currentDate LeadTime:(NSInteger)lead Type:(NSInteger)timeType {
    
    NSCalendar *xieyi7 = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *channel = [[NSDateComponents alloc] init];
    if (timeType == 0) {
        [channel setYear:lead];
    } else if (timeType == 1) {
        [channel setMonth:lead];
    } else if (timeType == 2) {
        [channel setDay:lead];
    } else if (timeType == 3) {
        [channel setHour:lead];
    } else if (timeType == 4) {
        [channel setMinute:lead];
    } else if (timeType == 5) {
        [channel setSecond:lead];
    }
    return [xieyi7 dateByAddingComponents:channel toDate:currentDate options:0];
}
+ (NSArray *)getCurrentWeekBeginDate:(NSDate *)date {
    
    if (date == nil) {
        date = [NSDate date];
    }
    
     NSCalendar *xieyif = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
     [xieyif setFirstWeekday:2];
    
    NSUInteger info =[xieyif ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:date];
    
     NSDate *middle = [self getEarlyOrLaterDate:date LeadTime:7 - info Type:2];
    
    NSDateComponents *eceiveF = nil;
   
    
    eceiveF = [xieyif components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:middle];
    NSDateComponents *abbar = [[NSDateComponents alloc] init];
    [abbar setDay:-6];
    NSDate * closey = [xieyif dateByAddingComponents:abbar toDate:middle options:0];

    NSDateFormatter *footeri = [[NSDateFormatter alloc] init];
    
    [footeri setDateFormat:@"yyyy-MM-dd"];
    
    NSString *prefix_5s = [footeri stringFromDate:closey];

    NSString *homeB = [footeri stringFromDate:middle];
    
    return @[prefix_5s,homeB];

}
+ (NSArray *)getCurrentYearBeginDate:(NSDate *)date{

    if (date == nil) {
        date = [NSDate date];
    }
    
    double interval = 0;
    
    NSDate *closek = nil;
    
    NSDate *zhifubaoF = nil;
    
    NSCalendar *xieyiS = [NSCalendar currentCalendar];
    
    [xieyiS setFirstWeekday:2];
    
    BOOL data3 = [xieyiS rangeOfUnit:NSCalendarUnitYear startDate:&closek interval:&interval forDate:date];
    
    
    
    if (data3) {
        
        zhifubaoF = [closek dateByAddingTimeInterval:interval-1];
        
    }else {
        
        return nil;
        
    }
    
    NSDateFormatter *footer6 = [[NSDateFormatter alloc] init];
    
    [footer6 setDateFormat:@"yyyy-MM-dd"];
    
    NSString *prefix_5B = [footer6 stringFromDate:closek];
    
    NSString *homea = [footer6 stringFromDate:zhifubaoF];
    
    return @[prefix_5B,homea];
}

+ (NSArray *)getCurrentMonthBeginDate:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    
    double interval = 0;
    
    NSDate *closeu = nil;
    
    NSDate *zhifubao0 = nil;
    
    NSCalendar *xieyiT = [NSCalendar currentCalendar];
    
    [xieyiT setFirstWeekday:2];
    
    BOOL dataA = [xieyiT rangeOfUnit:NSCalendarUnitMonth startDate:&closeu interval:&interval forDate:date];
    
    if (dataA) {
        
        zhifubao0 = [closeu dateByAddingTimeInterval:interval-1];
        
    }else {
        
        return nil;
        
    }
    
    NSDateFormatter *footers = [[NSDateFormatter alloc] init];
    
    [footers setDateFormat:@"yyyy-MM-dd"];
    
    NSString *prefix_5K = [footers stringFromDate:closeu];
    
    NSString *home7 = [footers stringFromDate:zhifubao0];
    
    return @[prefix_5K,home7];
}



+ (NSString *)GetCurrentDateType: (DateType)type {
    
    NSString *plan;
    switch (type) {
        case DateTypeYMD:
            plan = @"yyyy-MM-dd";
            break;
            
        case DateTypeHms:
            plan = @"HH:mm:ss";
            break;
            
        case DateTypeYMDHms:
            plan = @"yyyy-MM-dd HH:mm:ss";
            break;
        default:
            break;
    }
    
    NSDateFormatter *price = [[NSDateFormatter alloc] init];
    
    [price setDateFormat:plan];
    NSString *qitajiangli = [price stringFromDate:[NSDate date]];
    
    return qitajiangli;
    
}

+ (NSString *)getCurrentWithFormat:(NSString *)format {
    
    NSDateFormatter *priceg = [[NSDateFormatter alloc] init];
    
    [priceg setDateFormat:format];
    NSString *qitajianglij = [priceg stringFromDate:[NSDate date]];
    
    return qitajianglij;
}


+ (NSString *)getBefore{
    return [self getBeforeWithYear:0 Month:-2 Day:0];
}

+ (NSString *)getBeforeWithMonth:(NSInteger)month{
    return [self getBeforeWithYear:0 Month:month Day:0];
}

+ (NSString *)getBeforeWithYear:(NSInteger)year{
    return [self getBeforeWithYear:year Month:0 Day:0];
}

+ (NSString *)getBeforeWithDay:(NSInteger)day{
    return [self getBeforeWithYear:0 Month:0 Day:day];
}

+ (NSString *)getBeforeWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day {
    
    NSDate * line = [NSDate date];
    NSDateFormatter * cycleD = [[NSDateFormatter alloc] init];
    [cycleD setDateFormat:@"yyyy-MM-dd"];
    
    
    
    NSCalendar *xieyiz = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *abbarf = [[NSDateComponents alloc] init];
    
    [abbarf setYear:year];
    [abbarf setMonth:month];
    [abbarf setDay:day];
    NSDate *rate9 = [xieyiz dateByAddingComponents:abbarf toDate:line options:0];
    NSString *debit = [cycleD stringFromDate:rate9];
    return debit;
}


+ (NSString *)timeStr:(long long)timestamp{
    
    
    
    
    
    NSCalendar   *xieyig = [NSCalendar currentCalendar];
    
    NSDate *reate = [NSDate date];
    
    
    NSDateComponents *v_min = [xieyig components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:reate];
    NSInteger shouxufei = v_min.year;
    NSInteger controller = v_min.month;
    NSInteger planE = v_min.day;
    
    
    
    
    
    
    NSDate *anner = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    
    v_min = [xieyig components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:anner];
    CGFloat sub = v_min.year;
    CGFloat a_hide = v_min.month;
    CGFloat endk = v_min.day;
    
    
    
    
    
    
    
    NSDateFormatter *hot = [[NSDateFormatter alloc] init];
    if (shouxufei == sub
        && controller == a_hide
        && planE == endk) {
        hot.dateFormat= @"HH:mm";
    }else if(shouxufei == sub
             && controller == a_hide
             && planE - 1 == endk){
        hot.dateFormat= @"昨天 HH:mm";
    }else{
        hot.dateFormat= @"yyyy-MM-dd HH:mm";
    }
    
    return [hot stringFromDate:anner];
}



+ (NSString *)dateTimeDifferenceWithType: (DateType)type startTime:(NSString *)startTime endTime:(NSString *)endTime {
    NSString *plani;
    
    switch (type) {
        case DateTypeYMD:
            plani = @"YYYY-MM-DD";
            break;
            
        case DateTypeHms:
            plani = @"HH:mm:ss";
            break;
            
        case DateTypeYMDHms:
            plani = @"YYYY-MM-dd HH:mm:ss";
            break;
        default:
            break;
    }
    
    NSDateFormatter *border = [[NSDateFormatter alloc]init];
    [border setDateFormat:plani];
    NSDate *cache =[border dateFromString:startTime];
    NSDate *single = [border dateFromString:endTime];
    
    NSCalendar *xieyiB = [NSCalendar currentCalendar];
    NSCalendarUnit xinyongkablock = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *library = [xieyiB components:xinyongkablock fromDate:cache toDate:single options:0];
    
    
    NSString *time = [NSString stringWithFormat:@"%@:%@:%@",[self StringPanDuan:library.hour],[self StringPanDuan:library.minute], [self StringPanDuan:library.second]];
    
    
    return time;
}

+ (NSString *)StringPanDuan:(NSInteger)index{
    NSString * baocun;
    if (index<10) {
        baocun=[NSString stringWithFormat:@"0%ld",(long)index];
    }else{
        baocun=[NSString stringWithFormat:@"%ld",(long)index];
    }
    return baocun;
}


+ (NSString *) compareCurrentTime:(NSTimeInterval) compareDate
{
    
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    
    
    
    NSInteger referenceHour  =referenceComponents.hour;
    
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
+ (NSString*) getDateStringWithTimestamp:(NSTimeInterval)timestamp
{
    NSDate *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  =referenceComponents.year;
    NSInteger referenceMonth =referenceComponents.month;
    NSInteger referenceDay   =referenceComponents.day;
    
    return [NSString stringWithFormat:@"%d年%d月%d日",(int)referenceYear,(int)referenceMonth,(int)referenceDay];
}



+ (NSString*) getStringWithTimestamp:(NSNumber *)timestamp formatter:(NSString*)formatter
{
    
    long long t = [timestamp longLongValue];
    if ([NSString stringWithFormat:@"%@",timestamp].length == 13) {
        t /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:t];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}

- (BOOL)isYesterday {
    
    NSDate * slider = [NSDate date];
    NSDate *borderu = self;
    NSDateFormatter * reates = [[NSDateFormatter alloc]init];
    reates.dateFormat = @"yyyy-MM-dd";
    NSString *loadblockt = [reates stringFromDate:self];
    NSString *huodongjiangli = [reates stringFromDate:slider];
    borderu = [reates dateFromString:loadblockt];
    slider = [reates dateFromString:huodongjiangli];
    NSCalendar * extra = [NSCalendar currentCalendar];
    NSDateComponents * navigation = [extra components:NSCalendarUnitMonth | NSCalendarUnitDay fromDate:slider toDate:borderu options:0];
    return navigation.month == 0 && navigation.day == 1 && navigation.year == 0;
}

- (BOOL)isToday {
    
    NSDate *slider7 = [NSDate date];
    NSDateFormatter *reatesh = [[NSDateFormatter alloc]init];
    reatesh.dateFormat = @"yyyy-MM-dd";
    NSString *huodongjianglig = [reatesh stringFromDate:slider7];
    NSString *yinhangka = [reatesh stringFromDate:self];
    
    return [huodongjianglig isEqualToString:yinhangka];
    
}

- (BOOL)isThisYear {
    
    
    NSCalendar *xieyiA = [NSCalendar currentCalendar];
    
    
    NSDateComponents *collect =[xieyiA components:NSCalendarUnitYear fromDate:self];
    
    NSDateComponents *sliderz =[xieyiA components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return collect.year == sliderz.year;
}



+ (NSString *)stringFromDate:(NSDate *)date WithFormat:(NSString *)format{
    
    
    NSDateFormatter *cycle1 = [[NSDateFormatter alloc] init];
    
    [cycle1 setDateFormat:format];
    
    NSString *masks = [cycle1 stringFromDate:date];
    return masks;
}


+ (NSDate *)dateFromString:(NSString *)string WithFormat:(NSString *)format{
    
    NSDateFormatter *price2 = [[NSDateFormatter alloc] init] ;
    [price2 setDateFormat:format];
    
    NSDate *border1=[price2 dateFromString:string];
    return border1;
}

+ (NSCalendar *) currentCalendar
{
    static NSCalendar *sharedCalendar = nil;
    if (!sharedCalendar)
        sharedCalendar = [NSCalendar autoupdatingCurrentCalendar];
    return sharedCalendar;
}

#pragma mark - Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - String Properties
- (NSString *) stringWithFormat: (NSString *) format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *) stringWithDateStyle: (NSDateFormatterStyle) dateStyle timeStyle: (NSDateFormatterStyle) timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    
    return [formatter stringFromDate:self];
}

- (NSString *) shortString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *) shortDateString
{
    return [self stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) mediumString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *) mediumDateString
{
    return [self stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *) longString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longTimeString
{
    return [self stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *) longDateString
{
    return [self stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}

#pragma mark - Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    
    if (components1.weekOfMonth != components2.weekOfMonth) return NO;
    
    
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

- (BOOL) isSameMonthAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL) isThisMonth
{
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL) isLastMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

- (BOOL) isNextMonth
{
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL) isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

- (BOOL) isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark - Roles
- (BOOL) isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL) isTypicallyWorkday
{
    return ![self isTypicallyWeekend];
}

#pragma mark - Adjusting Dates

- (NSDate *) dateByAddingYears: (NSInteger) dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingYears: (NSInteger) dYears
{
    return [self dateByAddingYears:-dYears];
}

- (NSDate *) dateByAddingMonths: (NSInteger) dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingMonths: (NSInteger) dMonths
{
    return [self dateByAddingMonths:-dMonths];
}

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [[NSDate currentCalendar] components:componentFlags fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark - Extremes

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSDate *) dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; 
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

#pragma mark - Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *dengji = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *v_minm = [dengji components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return v_minm.day;
}

#pragma mark - Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger) hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger) minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger) seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger) day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger) month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger) week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfMonth;
}

- (NSInteger) weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger) nthWeekday 
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger) year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format
{
    NSDateFormatter *cyclee = [[NSDateFormatter alloc] init];
    [cyclee setLocale:[NSLocale currentLocale]];
    [cyclee setTimeZone:[NSTimeZone localTimeZone]];
    [cyclee setDateFormat:format];
    NSDate *borderb = [cyclee dateFromString:datestr];
#if ! __has_feature(objc_arc)
    [cyclee release];
#endif
    return borderb;
}

- (NSDate *)dateWithYMD
{
    NSDateFormatter *share = [[NSDateFormatter alloc] init];
    share.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [share stringFromDate:self];
    return [share dateFromString:selfStr];
}

-(NSDate *)dateWithFormatter:(NSString *)formatter {
    NSDateFormatter *shareT = [[NSDateFormatter alloc] init];
    shareT.dateFormat = formatter;
    NSString *selfStr = [shareT stringFromDate:self];
    return [shareT dateFromString:selfStr];
}
@end
