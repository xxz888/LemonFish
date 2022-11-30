
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface xxzRticle : NSObject


+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font;


+ (CGSize)sizeWithText:(NSString *)text andFont:(UIFont *)font andMaxW:(CGFloat)maxW;


+  (CGSize)getSpaceLabelHeightWithText:(NSString*)text withFont:(UIFont*)font withMaxW:(CGFloat)maxW andLineSpacing:(CGFloat)lineSpacing andWordsSpce:(CGFloat)wordsSpace;


+ (CGFloat)filePath;


+ (void)removeCache;


+ (CGRect)getImageRect:(UIImage *)tempImage;


+ (CGSize)getSizeWithImageUrl:(NSString *)imgurl;

+ (CGFloat)getHeightRatioWithYWidth:(CGFloat)Ywidth YHeight:(CGFloat)Yheight CWidth:(CGFloat)Cwidth;

@end
