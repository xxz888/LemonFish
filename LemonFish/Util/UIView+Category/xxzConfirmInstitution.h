
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Category)

+ (NSString *)secondTransToDate:(NSInteger)totalSecond;


+ (BOOL)isBlankString:(NSString *)aStr;

- (NSString *)RemoveTheBlankSpace:(NSString *)spaceStr;


- (NSString *)getNameEncryption:(NSString *)name;



- (NSString *)getNamelength:(NSString *)name;


+ (BOOL)isTheWholeTen:(NSString *)digital;

+ (NSString*) getSecrectStringWithPhoneNumber:(NSString*)phoneNum;

- (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length;

+ (NSString*) getSecrectStringWithAccountNo:(NSString*)accountNo;



+ (NSString*) stringMobileFormat:(NSString*)mobile;



+ (NSString*) stringChineseFormat:(double)value;



+ (NSString*) countNumAndChangeformat:(NSString *)num;


- (NSNumber*) toNumber;


- (CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width;


- (CGFloat)widthWithFontSize:(CGFloat)fontSize height:(CGFloat)maxHeight;

- (NSString*) removeUnwantedZero;


- (NSString*) trimmedString;

+ (NSString *)base64EncodeString:(NSString *)string;

+ (NSString *)base64DecodeString:(NSString *)string;

+ (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width;

+ (CGFloat) widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHight:(CGFloat)hight;

- (BOOL)SJZL_isPhone;



- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;


- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize andlineSpacing:(CGFloat) lineSpaceing;


+ (NSString *)MD5ForUpper32Bate:(NSString *)str;
+ (NSString *)formateBankNum:(NSString *)cardId;
@end

NS_ASSUME_NONNULL_END
