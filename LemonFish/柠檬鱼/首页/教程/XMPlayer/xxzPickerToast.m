
#import "xxzPickerToast.h"

@implementation xxzPickerToast



+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger stack = [totalTime integerValue];
    
    
    NSString *top = [NSString stringWithFormat:@"%02ld",stack/3600];
    
    NSString *interval_ov = [NSString stringWithFormat:@"%02ld",(stack%3600)/60];
    
    NSString *zaixiankefublock = [NSString stringWithFormat:@"%02ld",stack%60];
    
    NSString *back = [NSString stringWithFormat:@"%@:%@:%@",top,interval_ov,zaixiankefublock];
    
    return back;
}



@end
