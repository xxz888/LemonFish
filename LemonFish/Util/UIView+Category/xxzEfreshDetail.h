
#import <UIKit/UIKit.h>


@interface UIImage (Category)



+ (UIImage *)createQRCodeWithTargetString:(NSString *)targetString logoImage:(UIImage *)logoImage;

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image
                                       size:(CGSize)asize;



+ (UIImage *)sourceImage:(UIImage *)sourceImage
              targetSize:(CGSize)targetSize;


- (UIImage *)sourceImage:(UIImage *)sourceImage
             targetWidth:(CGFloat)targetWidth;


- (UIImage *)sourceImage:(UIImage *)sourceImage
                   scale:(CGFloat)scale;


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName;






- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit;

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit;



+ (UIImage *)resizableImageONE:(NSString *)name;

+ (UIImage *)clipImage:(UIImage *)image;

+ (UIImage *) imageWithColor:(UIColor*)color;

+ (UIImage *) imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

- (UIImage *) imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *) resizableImageTWO:(UIEdgeInsets)insets;

- (UIImage *) imageByResizeToScale:(CGFloat)scale;

+ (UIImage *)changeImageSize:(UIImage *)icon AndSize:(CGSize)size;

- (UIImage *) imageByResizeWithMaxSize:(CGSize)size;

- (UIImage *) imageWithThumbnailForSize:(CGSize)size;

- (UIImage *) imageByCropToRect:(CGRect)rect;

- (UIImage *) imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *) imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor;



- (UIImage *)imageByRotate180;



@end


@interface UIImage (Blur)
- (UIImage *)imageByBlurSoft;

- (UIImage *)imageByBlurLight;

- (UIImage *)imageByBlurExtraLight;

- (UIImage *)imageByBlurDark;

- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor;

- (UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(UIImage *)maskImage;

- (UIImage *) boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
@end





@interface UIImage (ImageEffects)


- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyBlurEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;
@end
