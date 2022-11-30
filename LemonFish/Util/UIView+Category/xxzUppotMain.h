
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Category)

+ (instancetype)getUILabelText:(NSString *)text
                     TextColor:(UIColor *)color
                      TextFont:(UIFont *)font
             TextNumberOfLines:(NSInteger)lines;


+ (void)getToChangeTheLabel:(UILabel *)label
                  TextColor:(UIColor *)color
                   TextFont:(UIFont *)font;

+ (NSMutableAttributedString *)AddLabelTheUnderline:(NSString *)text;

#pragma mark - 富文本设置部分字体颜色
+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text rangeText:(NSString *)rangeText textColor:(UIColor *)color textFont:(UIFont *)font;


+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;


+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;


+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

+(NSString *)splitSpace:(NSString * )text;
@end

NS_ASSUME_NONNULL_END
