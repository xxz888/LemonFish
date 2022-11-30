
#import "xxzUpdate.h"

@implementation xxzUpdate


+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation{
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL register_u  = NSSelectorFromString(@"setOrientation:");
        NSInvocation *edit = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:register_u]];
        [edit setSelector:register_u];
        [edit setTarget:[UIDevice currentDevice]];
        int single = orientation;
        
        [edit setArgument:&single atIndex:2];
        [edit invoke];
    }
}

@end
