
#import "xxzUppotMain.h"

@implementation UILabel (Category)



+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *buy = label.text;
    NSMutableAttributedString *ime = [[NSMutableAttributedString alloc] initWithString:buy attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *shoujihao = [[NSMutableParagraphStyle alloc] init];
    [ime addAttribute:NSParagraphStyleAttributeName value:shoujihao range:NSMakeRange(0, [buy length])];
    label.attributedText = ime;
    [label sizeToFit];

}


+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {

    NSString *buy0 = label.text;
    NSMutableAttributedString *imeA = [[NSMutableAttributedString alloc] initWithString:buy0 attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *shoujihaoq = [[NSMutableParagraphStyle alloc] init];
    [shoujihaoq setLineSpacing:lineSpace];
    [imeA addAttribute:NSParagraphStyleAttributeName value:shoujihaoq range:NSMakeRange(0, [buy0 length])];
    label.attributedText = imeA;
    [label sizeToFit];

}

+(NSString *)splitSpace:(NSString * )text{
    
    
    NSUInteger login = text.length;
    NSString *zhangdanri = [text substringToIndex:4];
    NSString *huabeiblock = [text substringFromIndex:login - 4];
    NSMutableString *send = [[NSMutableString alloc]init];
    for (int i = 0; i < login - 8; i++) {
        [send appendString:@"*"];
    }

    text = [NSString stringWithFormat:@"%@%@%@",@"****",send,huabeiblock];
    
    
    
    
    
    
            NSCharacterSet *qianyuetongdao = [NSCharacterSet characterSetWithCharactersInString:@"0123456789*\b"];
            NSString *  img = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
            if ([img rangeOfCharacterFromSet:[qianyuetongdao invertedSet]].location != NSNotFound) {
                return text;
            }

            NSString *content = @"";
            while (text.length > 0) {
                NSString *photo = [text substringToIndex:MIN(text.length, 4)];
                content = [content stringByAppendingString:photo];
                if (photo.length == 4) {
                    content = [content stringByAppendingString:@" "];
                }
                text = [text substringFromIndex:MIN(text.length, 4)];
            }
            
            content = [content stringByTrimmingCharactersInSet:[qianyuetongdao invertedSet]];
            
            if ([content stringByReplacingOccurrencesOfString:@" " withString:@""].length >= 21) {
                return text;
            }
            
    return content;
}



+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {

    NSString *buyG = label.text;
    NSMutableAttributedString *imeQ = [[NSMutableAttributedString alloc] initWithString:buyG];
    NSMutableParagraphStyle *shoujihaoz = [[NSMutableParagraphStyle alloc] init];
    [shoujihaoz setLineSpacing:space];
    [imeQ addAttribute:NSParagraphStyleAttributeName value:shoujihaoz range:NSMakeRange(0, [buyG length])];
    label.attributedText = imeQ;
    [label sizeToFit];

}


+ (void)getToChangeTheLabel:(UILabel *)label
                  TextColor:(UIColor *)color
                   TextFont:(UIFont *)font{
    label.textColor = color;
    label.font = font;
}


+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color textFont:(UIFont *)font{
    NSRange section = [text rangeOfString:rangeText];
    NSMutableAttributedString *pdata = [[NSMutableAttributedString alloc] initWithString:text];
    if (section.length > 0) {
        [pdata addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:section];
        [pdata addAttribute:NSFontAttributeName value:font range:section];
        return pdata;
    }else {
        return [rangeText copy];
    }
}
#pragma mark - 富文本设置部分字体颜色

+ (instancetype)getUILabelText:(NSString *)text
                     TextColor:(UIColor *)color
                      TextFont:(UIFont *)font
             TextNumberOfLines:(NSInteger)lines{
    
    UILabel *menuLabel = [UILabel new];
    menuLabel.text = text;
    menuLabel.textColor = color;
    menuLabel.font = font;
    menuLabel.numberOfLines = lines;
    return menuLabel;
    
}

+ (NSMutableAttributedString *)AddLabelTheUnderline:(NSString *)text{
    NSDictionary *info = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle],
                                 NSBaselineOffsetAttributeName : [NSNumber numberWithInteger:2]
    };
    NSMutableAttributedString *medium = [[NSMutableAttributedString alloc]initWithString:text attributes:info];
    return medium;
}
@end
