
#import "xxzRticle.h"

@implementation xxzRticle



+ ( float )filePathfolderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *kapianguanli = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * process;
    
    long long masks = 0 ;
    
    while ((process = [kapianguanli nextObject ]) != nil ){
        
        NSString * line = [folderPath stringByAppendingPathComponent :process];
        
        masks += [self fileSizeAtPath:line];
        
    }
    
    return masks/( 1024.0 * 1024.0 );
}



+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxW:(CGFloat)maxW{
    
    NSMutableDictionary *insi = [NSMutableDictionary dictionary];
    insi[NSFontAttributeName] = font;
    CGSize animate = CGSizeMake(maxW, MAXFLOAT);
    
    return [text boundingRectWithSize:animate options:NSStringDrawingUsesLineFragmentOrigin attributes:insi context:nil].size;
}



+ (void)removeCache
{
    
    NSString *off = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *separator = [[NSFileManager defaultManager] subpathsAtPath:off];
    
    for (NSString *p in separator)
    {
        NSError *canshu;
        NSString *photo = [off stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:photo])
        {
            [[NSFileManager defaultManager] removeItemAtPath:photo error:&canshu];
        }
    }
}




+ (CGFloat)filePath{
    
    NSString *div = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    CGFloat lab = [self filePathfolderSizeAtPath:div];
    
    return lab;
}


+ (CGSize)getSizeWithImageUrl:(NSString *)imgurl{
    
    NSData *oney = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgurl]];
    UIImage *huankuanblockImage = [UIImage imageWithData:oney];
    
    return CGSizeMake(huankuanblockImage.size.width, huankuanblockImage.size.height);
}


+ ( long long )fileSizeAtPath:( NSString *)filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    
    return 0 ;
}



+ (CGRect)getImageRect:(UIImage *)tempImage {
    CGRect corner;
    
    corner = CGRectMake(0, 0, tempImage.size.width, tempImage.size.height);
    return corner;
}



+ (CGFloat)getHeightRatioWithYWidth:(CGFloat)Ywidth YHeight:(CGFloat)Yheight CWidth:(CGFloat)Cwidth{
    
    return (Cwidth*Yheight)/(Ywidth*1.0);
}



+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font{
    
    return [self sizeWithText:text andFont:font andMaxW:MAXFLOAT];
}


+  (CGSize)getSpaceLabelHeightWithText:(NSString*)text withFont:(UIFont*)font withMaxW:(CGFloat)maxW andLineSpacing:(CGFloat)lineSpacing andWordsSpce:(CGFloat)wordsSpace{
    NSMutableParagraphStyle *zhifubao = [[NSMutableParagraphStyle alloc] init];
    zhifubao.lineBreakMode = NSLineBreakByCharWrapping;
    zhifubao.alignment = NSTextAlignmentLeft;
    zhifubao.lineSpacing = lineSpacing;  
    zhifubao.hyphenationFactor = 1.0;
    zhifubao.firstLineHeadIndent = 0.0;
    zhifubao.paragraphSpacingBefore = 0.0;
    zhifubao.headIndent = 0;
    zhifubao.tailIndent = 0;
    NSDictionary *date = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:zhifubao, NSKernAttributeName:@(wordsSpace)
                          };  
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:date context:nil].size;
    return size;
}

@end
