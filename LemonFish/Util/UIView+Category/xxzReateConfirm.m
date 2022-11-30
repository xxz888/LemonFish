
#import "xxzReateConfirm.h"

@implementation NSArray (Category)


+ (NSMutableArray*)getRandomArrFrome:(NSArray*)arr{
    NSMutableArray *add_ = [NSMutableArray new];
    while (add_.count != arr.count) {
        
        int liebianrenshu =arc4random() % arr.count;
        id labObj = arr[liebianrenshu];
        if (![add_ containsObject:labObj]) {
            [add_ addObject:labObj];
        }
    }
    return add_;
}

@end
