
#import "xxzConfirmInstitution.h"

#import <CommonCrypto/CommonCrypto.h>


@implementation NSString (Category)



+ (BOOL)isBlankString:(NSString *)aStr{
    if (!aStr) {
        return YES;
    }
    if ([aStr isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!aStr.length) {
        return YES;
    }
    if ([aStr isEqualToString:@"(null)"]) {
        return YES;
    }
    NSCharacterSet *xplain = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *has = [aStr stringByTrimmingCharactersInSet:xplain];
    if (!has.length) {
        return YES;
    }
    return NO;
}


- (BOOL)SJZL_isPhone {
    
    
    NSString *stringS = @"1\\d{10}$";
    NSPredicate *extra = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringS];
    
    return [extra evaluateWithObject:self];
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
        NSDictionary *insi = @{NSFontAttributeName : font};
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:insi context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize andlineSpacing:(CGFloat) lineSpaceing {
    
    NSMutableParagraphStyle *shoujihao = [[NSMutableParagraphStyle alloc] init];
    shoujihao.lineBreakMode = NSLineBreakByWordWrapping;
    shoujihao.alignment = NSTextAlignmentLeft;
    shoujihao.hyphenationFactor = 1.0;
    shoujihao.lineSpacing = lineSpaceing;
    shoujihao.firstLineHeadIndent = 0.0;
    shoujihao.paragraphSpacingBefore = 0.0;
    shoujihao.headIndent = 0;
    shoujihao.tailIndent = 0;
    NSDictionary *medium = @{NSFontAttributeName : font,NSParagraphStyleAttributeName:shoujihao.copy};
    
    CGSize hand = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:medium context:nil].size;
    
    NSString *qianyuetongdao = @"我们";
    CGSize cell = [qianyuetongdao sizeWithFont:font maxSize:maxSize];
    
    CGFloat selfHeight = [self sizeWithFont:font maxSize:maxSize].height;
    
    if (selfHeight <= cell.height) {
        
        CGSize safe = CGSizeMake(hand.width, font.pointSize);
        
        if (selfHeight == 0) {
            
            safe = CGSizeMake(hand.width, 0);
        }
        
        hand = safe;
    }
    
    return hand;
}

+(NSString *)countNumAndChangeformat:(NSString *)num
{
    NSMutableString *collectionview = [NSMutableString stringWithString:num];
    NSRange hex=NSMakeRange(num.length-3, 3);
    NSString * huankuanrate=[collectionview substringWithRange:hex];
    [collectionview deleteCharactersInRange:hex];
    
    int footer = 0;
    long long int dismiss = collectionview.longLongValue;
    while (dismiss != 0)
    {
        footer++;
        dismiss /= 10;
    }
    NSMutableString *img = [NSMutableString stringWithString:collectionview];
    NSMutableString *nearest = [NSMutableString string];
    while (footer > 3) {
        footer -= 3;
        NSRange screen = NSMakeRange(img.length - 3, 3);
        NSString *qianyuetongdaoP = [img substringWithRange:screen];
        [nearest insertString:qianyuetongdaoP atIndex:0];
        [nearest insertString:@"," atIndex:0];
        [img deleteCharactersInRange:screen];
    }
    [nearest insertString:img atIndex:0];
    [nearest insertString:huankuanrate atIndex:nearest.length];
    return nearest;
}


- (NSString *)trimmedString{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
}


+ (NSString*) getSecrectStringWithPhoneNumber:(NSString*)phoneNum
{
    if (phoneNum.length==11) {
        NSMutableString *newStr = [NSMutableString stringWithString:phoneNum];
        NSRange range = NSMakeRange(3, 4);
        [newStr replaceCharactersInRange:range withString:@"*****"];
        return newStr;
    }
    return nil;
}

- (NSString *)getNameEncryption:(NSString *)name{
    if (name.length == 0) return @"";
    else if (name.length == 2) {
        return [NSString stringWithFormat:@"%@*",[name substringToIndex:1]];
    }
    else {
        NSString *normal = [name substringToIndex:name.length-1];
        NSString *close = [normal substringFromIndex:1];
        NSString *qianyuetongdao4 = @"*";
        for (int i = 0; i < close.length; i++) {
            if (i < 3 && i > 0) {
                qianyuetongdao4 = [NSString stringWithFormat:@"*%@",qianyuetongdao4];
            }
        }
        NSString *daozhangjine = [name stringByReplacingOccurrencesOfString:close withString:qianyuetongdao4];
        return daozhangjine;
    }
}
+ (NSString*) getSecrectStringWithAccountNo:(NSString*)accountNo
{
    NSMutableString *newStr = [NSMutableString stringWithString:accountNo];
    NSRange range = NSMakeRange(4, 8);
    if (newStr.length>12) {
        [newStr replaceCharactersInRange:range withString:@" **** **** "];
    }
    return newStr;
}

+ (NSString*) stringMobileFormat:(NSString *)mobile {
    if (mobile.length==11) {
        NSMutableString* value = [[NSMutableString alloc] initWithString:mobile];
        [value insertString:@"-" atIndex:3];
        [value insertString:@"-" atIndex:8];
        return value;
    }
    
    return nil;
}

+ (NSString*) stringChineseFormat:(double)value{
    
    if (value / 100000000 >= 1) {
        return [NSString stringWithFormat:@"%.2f亿",value/100000000];
    }
    else if (value / 10000 >= 1 && value / 100000000 < 1) {
        return [NSString stringWithFormat:@"%.2f万",value/10000];
    }
    else {
        return [NSString stringWithFormat:@"%.2f",value];
    }
}


+ (NSString *)base64EncodeString:(NSString *)string {
    
    NSData *oney =[string dataUsingEncoding:NSUTF8StringEncoding];
    
    return [oney base64EncodedStringWithOptions:0];
}


-(CGFloat)heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width
{
    NSDictionary *insi7 = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [self boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:insi7 context:nil].size.height;
}

- (CGFloat) widthWithFontSize:(CGFloat)fontSize height:(CGFloat)maxHeight
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [self boundingRectWithSize:CGSizeMake(0, maxHeight) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}


+ (NSString *)base64DecodeString:(NSString *)string {
    
    
    NSData *oneyP=[[NSData alloc]initWithBase64EncodedString:string options:0];
    
    return [[NSString alloc]initWithData:oneyP encoding:NSUTF8StringEncoding];
}



- (NSString *)removeUnwantedZero {
    
    if ([[self substringWithRange:NSMakeRange(self.length- 6, 6)] isEqualToString:@"000000"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-7)]; 
    } else if ([[self substringWithRange:NSMakeRange(self.length- 3, 3)] isEqualToString:@"000"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-4)]; 
    } else if ([[self substringWithRange:NSMakeRange(self.length- 2, 2)] isEqualToString:@"00"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-2)];
    } else if ([[self substringWithRange:NSMakeRange(self.length- 1, 1)] isEqualToString:@"0"]) {
        return [self substringWithRange:NSMakeRange(0, self.length-1)];
    } else {
        return self;
    }
}


+ (NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    
    const char* shengyushijian = [[NSString stringWithFormat:@"%@HengchUang33@",str] UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(shengyushijian, (CC_LONG)strlen(shengyushijian), result);
    
    NSMutableString *cache = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [cache appendFormat:@"%02X", result[i]];
    }
    return cache;
}


+ (NSString *)formateBankNum:(NSString *)cardId {
    NSUInteger login = cardId.length;
    NSString *zhangdanri = [cardId substringToIndex:4];
    NSString *huabeiblock = [cardId substringFromIndex:login - 4];
    NSMutableString *send = [[NSMutableString alloc]init];
    for (int i = 0; i < login - 8; i++) {
        [send appendString:@"*"];
    }
    NSString *qianyuetongdaos = [NSString stringWithFormat:@"%@%@%@",zhangdanri,send,huabeiblock];
    return qianyuetongdaos;
}


+ (NSString *)secondTransToDate:(NSInteger)totalSecond{
    NSInteger acc = totalSecond % 60;
    NSInteger single = (totalSecond / 60) % 60;
    NSInteger erson = (totalSecond / 3600) % 24;
    NSInteger income = totalSecond / (24*3600);
    
    NSString *qianyuetongdaof = [NSString stringWithFormat:@"%ld",(long)acc];
    NSString *daozhangjinef = [NSString stringWithFormat:@"%ld",(long)single];
    NSString *onselected = [NSString stringWithFormat:@"%ld",(long)erson];
    NSString *totalU = [NSString stringWithFormat:@"%ld",(long)income];
    if (acc < 10) {
        qianyuetongdaof = [NSString stringWithFormat:@"0%ld",(long)acc];
    }
    if (single < 10) {
        daozhangjinef = [NSString stringWithFormat:@"0%ld",(long)single];
    }
    if (erson < 10) {
        onselected = [NSString stringWithFormat:@"0%ld",(long)erson];
    }
    if (income < 10) {
        totalU = [NSString stringWithFormat:@"0%ld",(long)income];
    }
    if (erson <= 0) {
        return [NSString stringWithFormat:@"%@:%@",daozhangjinef,qianyuetongdaof];
    }
    if (income <= 0) {
        return [NSString stringWithFormat:@"%@:%@:%@",onselected,daozhangjinef,qianyuetongdaof];
    }
    return [NSString stringWithFormat:@"%@:%@:%@:%@",totalU,onselected,daozhangjinef,qianyuetongdaof];
}

+  (CGFloat) heightForString:(NSString *)value fontSize:(CGFloat)fontSize andWidth:(CGFloat)width
{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:font ,NSParagraphStyleAttributeName:paragraphStyle}
                                           context:nil];
    return sizeToFit.size.height;
}

+ (CGFloat) widthForString:(NSString *)value fontSize:(CGFloat)fontSize andHight:(CGFloat)hight{
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];
    CGRect sizeToFit = [value boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, hight)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{NSFontAttributeName:font ,NSParagraphStyleAttributeName:paragraphStyle}
                                           context:nil];
    return sizeToFit.size.width;
    
}


- (NSString *)replaceStringWithAsterisk:(NSInteger)startLocation length:(NSInteger)length {
    NSString *time_j = self;
    for (NSInteger i = 0; i < length; i++) {
        NSRange handxuanzeshijian = NSMakeRange(startLocation, 1);
        time_j = [time_j stringByReplacingCharactersInRange:handxuanzeshijian withString:@"*"];
        startLocation ++;
    }
    return time_j;
}

+ (BOOL)isTheWholeTen:(NSString *)digital{
    if([digital containsString:@"."]){
        return NO;
    }else{
        NSLog(@"%@",[digital substringFromIndex:digital.length-1]);
        if ([[digital substringFromIndex:digital.length-1] isEqualToString:@"0"]) {
            return YES;
        }else{
            return NO;
        }
    }
}


- (NSString *)getNamelength:(NSString *)name{
    if (name.length == 0) return @"";
    else if (name.length > 4) {
        
        return [NSString stringWithFormat:@"%@*",[name substringToIndex:4]];
    }
    return name;
}


#pragma mark - MD5加密 32位 大写

- (NSNumber*)toNumber
{
    NSNumberFormatter *price=[[NSNumberFormatter alloc] init];
    [price setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *shiming=[price numberFromString:self];
    return shiming;
}

- (NSString *)RemoveTheBlankSpace:(NSString *)spaceStr{
    return [spaceStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
