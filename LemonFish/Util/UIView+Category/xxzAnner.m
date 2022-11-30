
#import "xxzAnner.h"

@interface UITextField (WLRange)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;

@end

@implementation UITextField (WLRange)


- (void)setSelectedRange:(NSRange)range {
    UITextPosition *full = self.beginningOfDocument;
    UITextPosition *yinhangka = [self positionFromPosition:full offset:range.location];
    UITextPosition *slip = [self positionFromPosition:full offset:range.location + range.length];
    UITextRange *refresh = [self textRangeFromPosition:yinhangka toPosition:slip];
    [self setSelectedTextRange:refresh];
}

- (NSRange)selectedRange {
    UITextPosition *fullN = self.beginningOfDocument;
    UITextRange *heji = self.selectedTextRange;
    UITextPosition *outside = heji.start;
    UITextPosition *string = heji.end;
    const NSInteger outsidew = [self offsetFromPosition:fullN toPosition:outside];
    const NSInteger extension_tw = [self offsetFromPosition:outside toPosition:string];
    return NSMakeRange(outsidew, extension_tw);
}

@end


@implementation xxzAnner


- (NSInteger)rightOffsetWithCardNoLength:(NSInteger)length rightNumberCount:(NSInteger)rightNumberCount {
    NSInteger slip4 = [self groupCountWithLength:length];
    NSInteger shengyushijian = [self groupCountWithLength:length - rightNumberCount];
    NSInteger jifen = slip4 -1 > 0? slip4 - 1 : 0;
    NSInteger myear = shengyushijian -1 > 0? shengyushijian - 1 : 0;
    return rightNumberCount + (jifen - myear);
}


- (NSInteger)groupCountWithLength:(NSInteger)length {
    return (NSInteger)ceilf((CGFloat)length /self.groupSize);
}

#pragma mark - Helper


- (NSString *)removingSapceString:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:self.separator withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
}



- (NSString *)groupedString:(NSString *)string {
    NSString *qianyuetongdao = [self removingSapceString:string];
    NSInteger tint = [self groupCountWithLength:qianyuetongdao.length];
    NSInteger controller = self.groupSize;
    NSMutableArray *v_min = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < tint; i++) {
        if (i*controller + controller > qianyuetongdao.length) {
            [v_min addObject:[qianyuetongdao substringFromIndex:i*controller]];
        } else {
            [v_min addObject:[qianyuetongdao substringWithRange:NSMakeRange(i*controller, controller)]];
        }
    }
    NSString *addj = [v_min componentsJoinedByString:self.separator];
    return addj;
}



- (BOOL)isValidNumbers:(NSString *)numberStr {
    NSString* touch = @"^[0-9]+$";
    NSPredicate *key = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",touch];
    return [key evaluateWithObject:numberStr];
}



- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    _groupSize = 4;
    _separator = @" ";
    return self;
}



- (void)bankNoField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger controllerb = self.groupSize;
    NSString *m_view = textField.text;
    NSString *manual = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *execute = [self removingSapceString:manual];
    
    if ( (string.length != 0 && ![self isValidNumbers:execute]) || execute.length > 19) {
        return;
    }
    
    NSInteger qitajiangli = [self removingSapceString:[m_view substringFromIndex:textField.selectedRange.location + textField.selectedRange.length]].length;
    
    if (manual.length > controllerb) {
        textField.text = [self groupedString:manual];
    } else {
        textField.text = manual;
    }
    m_view = textField.text;
    
    NSInteger nav = [self rightOffsetWithCardNoLength:execute.length rightNumberCount:qitajiangli];
    NSRange header = NSMakeRange(m_view.length - nav, 0);
    
    
    if (header.location > 0 && [[m_view substringWithRange:NSMakeRange(header.location - 1, 1)] isEqualToString:self.separator]) {
        header.location -= 1;
    }
    [textField setSelectedRange:header];
}

@end
