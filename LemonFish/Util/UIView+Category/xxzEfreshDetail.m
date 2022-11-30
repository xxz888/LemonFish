
#import "xxzEfreshDetail.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#define ORIGINAL_MAX_WIDTH 640.0f
#define YY_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)

@implementation UIImage (Category)

+ (UIImage *)createQRCodeWithTargetString:(NSString *)targetString logoImage:(UIImage *)logoImage {
    
    CIFilter *formatter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [formatter setDefaults];
    
    
    NSString *cvn = targetString;
    NSData *request = [cvn dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [formatter setValue:request forKey:@"inputMessage"];
    
    
    CIImage *huankuanblockImage = [formatter outputImage];
    
    
    UIImage *status = [self createNonInterpolatedUIImageFromCIImage:huankuanblockImage size:[UIScreen mainScreen].bounds.size.width];
    
    
    
    UIGraphicsBeginImageContext(status.size);
    
    [status drawInRect:CGRectMake(0, 0, status.size.width, status.size.height)];
    
    UIImage *statusn = logoImage;
    CGFloat extend=status.size.width*0.25;
    CGFloat origin=extend;
    CGFloat lbl=(status.size.width-extend)*0.5;
    CGFloat upgrade=(status.size.height -origin)*0.5;
    [statusn drawInRect:CGRectMake(lbl, upgrade, extend, origin)];
    
    UIImage *minute=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    
    return minute;
}

+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image size:(CGFloat)size {
    CGRect store = CGRectIntegral(image.extent);
    CGFloat rate = MIN(size/CGRectGetWidth(store), size/CGRectGetHeight(store));
    
    
    size_t clear = CGRectGetWidth(store)*rate;
    size_t masks = CGRectGetHeight(store)*rate;
    
    CGColorSpaceRef goods = CGColorSpaceCreateDeviceGray();
    CGContextRef dic = CGBitmapContextCreate(nil, clear, masks, 8, 0, goods, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *area = [CIContext contextWithOptions:nil];
    CGImageRef showImage = [area createCGImage:image fromRect:store];
    CGContextSetInterpolationQuality(dic, kCGInterpolationNone);
    CGContextScaleCTM(dic, rate, rate);
    CGContextDrawImage(dic, store, showImage);
    
    
    CGImageRef tabbarImage = CGBitmapContextCreateImage(dic);
    CGContextRelease(dic);
    CGImageRelease(showImage);
    
    return [UIImage imageWithCGImage:tabbarImage];
}


+ (UIImage *)resizableImageONE:(NSString *)name
{
    UIImage *call = [UIImage imageNamed:name];
    CGFloat nvite = call.size.width * 0.5;
    CGFloat tint = call.size.height * 0.5;
    
    
    
    return [call resizableImageWithCapInsets:UIEdgeInsetsMake(tint, nvite, tint, nvite)];
}



- (NSData *)compressImageDataWithMaxLimit:(CGFloat)maxLimit {
    
    CGFloat left = 0.9f;
    CGFloat phone = 0.2f; 
    NSData *send = UIImageJPEGRepresentation(self, left);
    NSInteger sure = [send length];
    while ((sure <= maxLimit * 1000 * 1000) && (left >= phone)) {
        left -= 0.03;
        send = UIImageJPEGRepresentation(self, left);
        sure = [send length];
    }
    return send;
}

- (UIImage *)compressImageWithMaxLimit:(CGFloat)maxLimit {
    NSData *sendd = [self compressImageDataWithMaxLimit:maxLimit];
    UIImage *safeImage = [UIImage imageWithData:sendd];
    return safeImage;
}


+ (UIImage *)sourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    
    UIImage *tuiguangImage = nil;
    CGSize safe = sourceImage.size;
    CGFloat cleard = safe.width;
    CGFloat masksV = safe.height;
    CGFloat icon = targetSize.width;
    CGFloat trading = targetSize.height;
    CGFloat xcopy_np = 0.0f;
    CGFloat magnification = icon;
    CGFloat shiming = trading;
    CGPoint tixianjine = CGPointZero;
    
    if(CGSizeEqualToSize(safe, targetSize) == NO){
        
        CGFloat year = icon / cleard;
        CGFloat calli = trading / masksV;
        
        if(year > calli){
            xcopy_np = year;
            
        }
        else{
            
            xcopy_np = calli;
        }
        magnification = cleard * xcopy_np;
        shiming = masksV * xcopy_np;
        
        if(year > calli){
            
            tixianjine.y = (trading - shiming) * 0.5;
        }else if(year < calli){
            
            tixianjine.x = (icon - magnification) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect alert = CGRectZero;
    alert.origin = tixianjine;
    alert.size.width = magnification;
    alert.size.height = shiming;
    
    [sourceImage drawInRect:alert];
    tuiguangImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (!tuiguangImage) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return tuiguangImage;
}

- (UIImage *)sourceImage:(UIImage *)sourceImage targetWidth:(CGFloat)targetWidth {
    UIImage *tuiguangImageP = nil;
    CGSize safeJ = sourceImage.size;
    CGFloat clear5 = safeJ.width;
    CGFloat masksL = safeJ.height;
    CGFloat tradingO = masksL / (clear5 / targetWidth);
    CGSize size = CGSizeMake(targetWidth, tradingO);
    CGFloat xcopy_npM = 0.0;
    CGFloat magnificationv = targetWidth;
    CGFloat shimingX = tradingO;
    CGPoint tixianjineQ = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(safeJ, size) == NO){
        
        CGFloat yeard = targetWidth / clear5;
        CGFloat calliT = tradingO / masksL;
        
        if(yeard > calliT){
            xcopy_npM = yeard;
        }
        else{
            xcopy_npM = calliT;
        }
        magnificationv = clear5 * xcopy_npM;
        shimingX = masksL * xcopy_npM;
        
        if(yeard > calliT){
            
            tixianjineQ.y = (tradingO - shimingX) * 0.5;
            
        }else if(yeard < calliT){
            
            tixianjineQ.x = (targetWidth - magnificationv) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect alertv = CGRectZero;
    alertv.origin = tixianjineQ;
    alertv.size.width = magnificationv;
    alertv.size.height = shimingX;
    
    [sourceImage drawInRect:alertv];
    
    tuiguangImageP = UIGraphicsGetImageFromCurrentImageContext();
    
    if(tuiguangImageP == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    
    return tuiguangImageP;
}


+ (UIImage *)resizableImageWithImageName:(NSString *)imageName {
    UIImage *textImage = [UIImage imageNamed:imageName];
    CGFloat base = textImage.size.height * 0.5;
    CGFloat arrow = textImage.size.width * 0.5;
    return [textImage resizableImageWithCapInsets:UIEdgeInsetsMake(base, arrow, base, arrow)];
}

- (UIImage *)sourceImage:(UIImage *)sourceImage scale:(CGFloat)scale {
    if (scale > 1) {
        return sourceImage;
    }
    
    UIImage *tuiguangImageT = nil;
    CGSize safeE = sourceImage.size;
    CGPoint t_tag = CGPointZero;
    t_tag.x = (safeE.width - safeE.width * scale) * 0.5f;
    t_tag.y = (safeE.height - safeE.height * scale) * 0.5f;
    
    CGFloat change = safeE.width;
    CGFloat epayment = safeE.height;
    CGFloat iconW = change * scale;
    CGFloat tradings = epayment * scale;
    CGRect xinshoujiaochengblock = (CGRect){t_tag, CGSizeMake(iconW, tradings)};
    [sourceImage drawInRect:xinshoujiaochengblock];
    tuiguangImageT = UIGraphicsGetImageFromCurrentImageContext();
    if (!tuiguangImageT) {
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return tuiguangImageT;
    
}

+ (UIImage *)clipImage:(UIImage *)image
{
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    
    UIBezierPath *photo = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    [photo addClip];
    
    [image drawAtPoint:CGPointZero];
    
    UIImage *tuiguangImageL = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return tuiguangImageL;
}

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *buttonImage;
    if (nil == image) {
        buttonImage = nil;
    }
    else{
        CGSize huankuanblock = image.size;
        CGRect corner;
        if (asize.width/asize.height > huankuanblock.width/huankuanblock.height) {
            corner.size.width = asize.height*huankuanblock.width/huankuanblock.height;
            corner.size.height = asize.height;
            corner.origin.x = (asize.width - corner.size.width)/2;
            corner.origin.y = 0;
        }
        else{
            corner.size.width = asize.width;
            corner.size.height = asize.width*huankuanblock.height/huankuanblock.width;
            corner.origin.x = 0;
            corner.origin.y = (asize.height - corner.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef areaa = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(areaa, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));
        [image drawInRect:corner];
        buttonImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return buttonImage;
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat clearv = CGImageGetWidth(self.CGImage);
    CGFloat masksu = CGImageGetHeight(self.CGImage);
    
    CGSize url;
    
    url.width = clearv;
    url.height = masksu;
    
    UIGraphicsBeginImageContext(url);
    CGContextRef current = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(current, url.width/2, url.height/2);
    CGContextRotateCTM(current, degrees * M_PI / 180);
    CGContextRotateCTM(current, M_PI);
    CGContextScaleCTM(current, -1.0, 1.0);
    CGContextDrawImage(current, CGRectMake(-url.width/2, -url.height/2, url.width, url.height), self.CGImage);
    UIImage* tuiguangImage6 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tuiguangImage6;
}

- (UIImage*) resizableImageTWO:(UIEdgeInsets)insets {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0f) {
        return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    }
    
    return [self stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];
}


+ (UIImage *) imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; 
        else
            scaleFactor = heightFactor; 
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); 
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    UIGraphicsEndImageContext();
    return newImage;
}
+ (UIImage*) imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData* imageData = UIImageJPEGRepresentation(image, 1.0f);
    image = [UIImage imageWithData:imageData];
    return image;
}


- (UIImage *)imageByResizeToScale:(CGFloat)scale{
    CGSize size = CGSizeMake(self.size.width *scale, self.size.height * scale);
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *huankuanblockImage5 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return huankuanblockImage5;
}

+ (UIImage *)changeImageSize:(UIImage *)icon AndSize:(CGSize)size{
    CGSize showed = size;
    UIGraphicsBeginImageContextWithOptions(showed, NO,0.0);
    CGRect footer = CGRectMake(0.0, 0.0, showed.width, showed.height);
    [icon drawInRect:footer];
    UIImage *huankuanblockImaget = UIGraphicsGetImageFromCurrentImageContext();
    huankuanblockImaget = [huankuanblockImaget imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIGraphicsEndImageContext();
    return huankuanblockImaget;
}

- (UIImage *)imageByResizeWithMaxSize:(CGSize)size{
    CGSize shuaka = self.size;
    if(shuaka.width > size.width){
        shuaka = CGSizeMake(size.width, size.width/shuaka.width * shuaka.height);
    }
    if(shuaka.height > size.height){
        shuaka = CGSizeMake(size.height/shuaka.height * shuaka.width, size.height);
    }
    if (shuaka.width <= 0 || shuaka.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(shuaka, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, shuaka.width, shuaka.height)];
    UIImage *huankuanblockImageX = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return huankuanblockImageX;
}

- (UIImage *)imageWithThumbnailForSize:(CGSize)size{
    CGSize safeF = self.size;
    if(safeF.width < safeF.height){
        safeF = CGSizeMake(size.width, size.width/safeF.width * safeF.height);
    }
    else{
        safeF = CGSizeMake(size.height/safeF.height * safeF.width, size.height);
    }
    if (safeF.width <= 0 || safeF.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(safeF, NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, safeF.width, safeF.height)];
    UIImage *huankuanblockImagea = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return huankuanblockImagea;
}

- (UIImage *)imageByCropToRect:(CGRect)rect {
    rect.origin.x *= self.scale;
    rect.origin.y *= self.scale;
    rect.size.width *= self.scale;
    rect.size.height *= self.scale;
    if (rect.size.width <= 0 || rect.size.height <= 0) return nil;
    CGImageRef done = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *huankuanblockImageG = [UIImage imageWithCGImage:done scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(done);
    return huankuanblockImageG;
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius {
    return [self imageByRoundCornerRadius:radius borderWidth:0 borderColor:nil];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor {
    return [self imageByRoundCornerRadius:radius
                                  corners:UIRectCornerAllCorners
                              borderWidth:borderWidth
                              borderColor:borderColor
                           borderLineJoin:kCGLineJoinMiter];
}

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius
                              corners:(UIRectCorner)corners
                          borderWidth:(CGFloat)borderWidth
                          borderColor:(UIColor *)borderColor
                       borderLineJoin:(CGLineJoin)borderLineJoin {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef areag = UIGraphicsGetCurrentContext();
    CGRect cornerx = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(areag, 1, -1);
    CGContextTranslateCTM(areag, 0, -cornerx.size.height);
    
    CGFloat div = MIN(self.size.width, self.size.height);
    if (borderWidth < div / 2) {
        UIBezierPath *photoq = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(cornerx, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [photoq closePath];
        
        CGContextSaveGState(areag);
        [photoq addClip];
        CGContextDrawImage(areag, cornerx, self.CGImage);
        CGContextRestoreGState(areag);
    }
    
    if (borderColor && borderWidth < div / 2 && borderWidth > 0) {
        CGFloat complete = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect type_ss = CGRectInset(cornerx, complete, complete);
        CGFloat address = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *photoq = [UIBezierPath bezierPathWithRoundedRect:type_ss byRoundingCorners:corners cornerRadii:CGSizeMake(address, borderWidth)];
        [photoq closePath];
        
        photoq.lineWidth = borderWidth;
        photoq.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [photoq stroke];
    }
    UIImage *huankuanblockImageZ = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return huankuanblockImageZ;
}



- (UIImage *)_yy_flipHorizontal:(BOOL)horizontal vertical:(BOOL)vertical {
    if (!self.CGImage) return nil;
    size_t clearn = (size_t)CGImageGetWidth(self.CGImage);
    size_t masksm = (size_t)CGImageGetHeight(self.CGImage);
    size_t nick = clearn * 4;
    CGColorSpaceRef qitajiangli = CGColorSpaceCreateDeviceRGB();
    CGContextRef arear = CGBitmapContextCreate(NULL, clearn, masksm, 8, nick, qitajiangli, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(qitajiangli);
    if (!arear) return nil;
    
    CGContextDrawImage(arear, CGRectMake(0, 0, clearn, masksm), self.CGImage);
    UInt8 *oney = (UInt8 *)CGBitmapContextGetData(arear);
    if (!oney) {
        CGContextRelease(arear);
        return nil;
    }
    vImage_Buffer huodongjiangli = { oney, masksm, clearn, nick };
    vImage_Buffer baocun = { oney, masksm, clearn, nick };
    if (vertical) {
        vImageVerticalReflect_ARGB8888(&huodongjiangli, &baocun, kvImageBackgroundColorFill);
    }
    if (horizontal) {
        vImageHorizontalReflect_ARGB8888(&huodongjiangli, &baocun, kvImageBackgroundColorFill);
    }
    CGImageRef buttom = CGBitmapContextCreateImage(arear);
    CGContextRelease(arear);
    UIImage *statusO = [UIImage imageWithCGImage:buttom scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(buttom);
    return statusO;
}

- (UIImage *)imageByRotate180 {
    return [self _yy_flipHorizontal:YES vertical:YES];
}

- (UIImage *)imageByFlipVertical {
    return [self _yy_flipHorizontal:NO vertical:YES];
}

- (UIImage *)imageByFlipHorizontal {
    return [self _yy_flipHorizontal:YES vertical:NO];
}


@end


@implementation UIImage (Blur)

- (UIImage *)imageByBlurSoft {
    return [self imageByBlurRadius:60 tintColor:[UIColor colorWithWhite:0.84 alpha:0.36] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurLight {
    return [self imageByBlurRadius:60 tintColor:[UIColor colorWithWhite:1.0 alpha:0.3] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurExtraLight {
    return [self imageByBlurRadius:40 tintColor:[UIColor colorWithWhite:0.97 alpha:0.82] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurDark {
    return [self imageByBlurRadius:40 tintColor:[UIColor colorWithWhite:0.11 alpha:0.73] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor {
    const CGFloat style = 0.6;
    UIColor *type_qp = tintColor;
    size_t screen = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (screen == 2) {
        CGFloat fist;
        if ([tintColor getWhite:&fist alpha:NULL]) {
            type_qp = [UIColor colorWithWhite:fist alpha:style];
        }
    } else {
        CGFloat r, g, fist;
        if ([tintColor getRed:&r green:&g blue:&fist alpha:NULL]) {
            type_qp = [UIColor colorWithRed:r green:g blue:fist alpha:style];
        }
    }
    return [self imageByBlurRadius:20 tintColor:type_qp tintMode:kCGBlendModeNormal saturation:-1.0 maskImage:nil];
}

- (UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(UIImage *)maskImage {
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog(@"UIImage+YYAdd error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog(@"UIImage+YYAdd error: inputImage must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog(@"UIImage+YYAdd error: effectMaskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    
    BOOL xieyi = (long)vImageBuffer_InitWithCGImage != 0 && (long)vImageCreateCGImageFromBuffer != 0;
    BOOL city = blurRadius > __FLT_EPSILON__;
    BOOL modity = fabs(saturation - 1.0) > __FLT_EPSILON__;
    
    CGSize size = self.size;
    CGRect cornerB = { CGPointZero, size };
    CGFloat ratep = self.scale;
    CGImageRef doneQ = self.CGImage;
    BOOL display = NO;
    
    if (!city && !modity) {
        return [self _yy_mergeImageRef:doneQ tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:display];
    }
    
    vImage_Buffer separator = { 0 }, scratch = { 0 };
    vImage_Buffer *shengyushijian = NULL, *output = NULL;
    
    vImage_CGImageFormat reates = {
        .bitsPerComponent = 8,
        .bitsPerPixel = 32,
        .colorSpace = NULL,
        .bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little, 
        .version = 0,
        .decode = NULL,
        .renderingIntent = kCGRenderingIntentDefault
    };
    
    if (xieyi) {
        vImage_Error observer;
        observer = vImageBuffer_InitWithCGImage(&separator, &reates, NULL, doneQ, kvImagePrintDiagnosticsToConsole);
        if (observer != kvImageNoError) {
            NSLog(@"UIImage+YYAdd error: vImageBuffer_InitWithCGImage returned error code %zi for inputImage: %@", observer, self);
            return nil;
        }
        observer = vImageBuffer_Init(&scratch, separator.height, separator.width, reates.bitsPerPixel, kvImageNoFlags);
        if (observer != kvImageNoError) {
            NSLog(@"UIImage+YYAdd error: vImageBuffer_Init returned error code %zi for inputImage: %@", observer, self);
            return nil;
        }
    } else {
        UIGraphicsBeginImageContextWithOptions(size, display, ratep);
        CGContextRef score = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(score, 1.0, -1.0);
        CGContextTranslateCTM(score, 0, -size.height);
        CGContextDrawImage(score, cornerB, doneQ);
        separator.data     = CGBitmapContextGetData(score);
        separator.width    = CGBitmapContextGetWidth(score);
        separator.height   = CGBitmapContextGetHeight(score);
        separator.rowBytes = CGBitmapContextGetBytesPerRow(score);
        
        UIGraphicsBeginImageContextWithOptions(size, display, ratep);
        CGContextRef stop = UIGraphicsGetCurrentContext();
        scratch.data     = CGBitmapContextGetData(stop);
        scratch.width    = CGBitmapContextGetWidth(stop);
        scratch.height   = CGBitmapContextGetHeight(stop);
        scratch.rowBytes = CGBitmapContextGetBytesPerRow(stop);
    }
    
    shengyushijian = &separator;
    output = &scratch;
    
    if (city) {
        
        
        
        
        
        
        
        
        
        
        
        
        CGFloat abbar = blurRadius * ratep;
        if (abbar - 2.0 < __FLT_EPSILON__) abbar = 2.0;
        uint32_t area6 = floor((abbar * 3.0 * sqrt(2 * M_PI) / 4 + 0.5) / 2);
        area6 |= 1; 
        int xinyongkablock;
        if (blurRadius * ratep < 0.5) xinyongkablock = 1;
        else if (blurRadius * ratep < 1.5) xinyongkablock = 2;
        else xinyongkablock = 3;
        NSInteger xuanzedeqv = vImageBoxConvolve_ARGB8888(shengyushijian, output, NULL, 0, 0, area6, area6, NULL, kvImageGetTempBufferSize | kvImageEdgeExtend);
        void *collectionview = malloc(xuanzedeqv);
        for (int i = 0; i < xinyongkablock; i++) {
            vImageBoxConvolve_ARGB8888(shengyushijian, output, collectionview, 0, 0, area6, area6, NULL, kvImageEdgeExtend);
            YY_SWAP(shengyushijian, output);
        }
        free(collectionview);
    }
    
    
    if (modity) {
        
        
        CGFloat draging = saturation;
        CGFloat matrixFloat[] = {
            0.0722 + 0.9278 * draging,  0.0722 - 0.0722 * draging,  0.0722 - 0.0722 * draging,  0,
            0.7152 - 0.7152 * draging,  0.7152 + 0.2848 * draging,  0.7152 - 0.7152 * draging,  0,
            0.2126 - 0.2126 * draging,  0.2126 - 0.2126 * draging,  0.2126 + 0.7873 * draging,  0,
            0,                    0,                    0,                    1,
        };
        const int32_t huankuanyewu = 256;
        NSUInteger cell = sizeof(matrixFloat) / sizeof(matrixFloat[0]);
        int16_t matrix[cell];
        for (NSUInteger i = 0; i < cell; ++i) {
            matrix[i] = (int16_t)roundf(matrixFloat[i] * huankuanyewu);
        }
        vImageMatrixMultiply_ARGB8888(shengyushijian, output, matrix, huankuanyewu, NULL, NULL, kvImageNoFlags);
        YY_SWAP(shengyushijian, output);
    }
    
    UIImage *imvImage = nil;
    if (xieyi) {
        CGImageRef allImage = NULL;
        allImage = vImageCreateCGImageFromBuffer(shengyushijian, &reates, &_yy_cleanupBuffer, NULL, kvImageNoAllocate, NULL);
        if (allImage == NULL) {
            allImage = vImageCreateCGImageFromBuffer(shengyushijian, &reates, NULL, NULL, kvImageNoFlags, NULL);
            free(shengyushijian->data);
        }
        free(output->data);
        imvImage = [self _yy_mergeImageRef:allImage tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:display];
        CGImageRelease(allImage);
    } else {
        CGImageRef allImage;
        UIImage *limitImage;
        if (shengyushijian != &separator) limitImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (shengyushijian == &separator) limitImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        allImage = limitImage.CGImage;
        imvImage = [self _yy_mergeImageRef:allImage tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:display];
    }
    return imvImage;
}

static void _yy_cleanupBuffer(void *userData, void *buf_data) {
    free(buf_data);
}
- (UIImage *)_yy_mergeImageRef:(CGImageRef)effectCGImage
                     tintColor:(UIColor *)tintColor
                 tintBlendMode:(CGBlendMode)tintBlendMode
                     maskImage:(UIImage *)maskImage
                        opaque:(BOOL)opaque {
    BOOL price = tintColor != nil && CGColorGetAlpha(tintColor.CGColor) > __FLT_EPSILON__;
    BOOL touch = maskImage != nil;
    CGSize size = self.size;
    CGRect cornerN = { CGPointZero, size };
    CGFloat ratee = self.scale;
    
    if (!price && !touch) {
        return [UIImage imageWithCGImage:effectCGImage];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, ratee);
    CGContextRef area7 = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(area7, 1.0, -1.0);
    CGContextTranslateCTM(area7, 0, -size.height);
    if (touch) {
        CGContextDrawImage(area7, cornerN, self.CGImage);
        CGContextSaveGState(area7);
        CGContextClipToMask(area7, cornerN, maskImage.CGImage);
    }
    CGContextDrawImage(area7, cornerN, effectCGImage);
    if (price) {
        CGContextSaveGState(area7);
        CGContextSetBlendMode(area7, tintBlendMode);
        CGContextSetFillColorWithColor(area7, tintColor.CGColor);
        CGContextFillRect(area7, cornerN);
        CGContextRestoreGState(area7);
    }
    if (touch) {
        CGContextRestoreGState(area7);
    }
    UIImage *imvImageH = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imvImageH;
}


- (UIImage *) boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath {
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    
    UIImage *unblurredImage = nil;
    if (exclusionPath != nil) {
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = (CGRect){CGPointZero, self.size};
        maskLayer.backgroundColor = [UIColor blackColor].CGColor;
        maskLayer.fillColor = [UIColor whiteColor].CGColor;
        maskLayer.path = exclusionPath.CGPath;
        
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
        CGContextRef context = CGBitmapContextCreate(nil, maskLayer.bounds.size.width, maskLayer.bounds.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
        CGContextTranslateCTM(context, 0, maskLayer.bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        [maskLayer renderInContext:context];
        CGImageRef imageRef = CGBitmapContextCreateImage(context);
        UIImage *maskImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        CGColorSpaceRelease(colorSpace);
        CGContextRelease(context);
        
        UIGraphicsBeginImageContext(self.size);
        context = UIGraphicsGetCurrentContext();
        CGContextTranslateCTM(context, 0, maskLayer.bounds.size.height);
        CGContextScaleCTM(context, 1.f, -1.f);
        CGContextClipToMask(context, maskLayer.bounds, maskImage.CGImage);
        CGContextDrawImage(context, maskLayer.bounds, self.CGImage);
        unblurredImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
    }
    
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    
    if (unblurredImage != nil) {
        UIGraphicsBeginImageContext(returnImage.size);
        [returnImage drawAtPoint:CGPointZero];
        [unblurredImage drawAtPoint:CGPointZero];
        
        returnImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    CGImageRelease(imageRef);
    
    return returnImage;
    
}

@end


@implementation UIImage (ResizableImage)

- (UIImage*) resizableImage:(UIEdgeInsets)insets {
    
    
    
    
    return [self stretchableImageWithLeftCapWidth:insets.left topCapHeight:insets.top];
}
@end



@implementation UIImage (ImageEffects)

- (UIImage *)applyLightEffect {
    UIColor* shop = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self applyBlurWithRadius:30 tintColor:shop saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyExtraLightEffect {
    UIColor* shopU = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self applyBlurWithRadius:20 tintColor:shopU saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyDarkEffect {
    UIColor* shopw = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self applyBlurWithRadius:30 tintColor:shopw saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)applyBlurEffect {
    UIColor* shopL = [UIColor colorWithWhite:0.4f alpha:0.3f];
    return [self applyBlurWithRadius:8.0f tintColor:shopL saturationDeltaFactor:1.8f maskImage:nil];
}

- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor {
    const CGFloat styleR = 0.6;
    UIColor* type_qpY = tintColor;
    NSUInteger screen9 = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (screen9 == 2) {
        CGFloat fistx;
        if ([tintColor getWhite:&fistx alpha:nil]) {
            type_qpY = [UIColor colorWithWhite:fistx alpha:styleR];
        }
    } else {
        CGFloat r, g, fistx;
        if ([tintColor getRed:&r green:&g blue:&fistx alpha:nil]) {
            type_qpY = [UIColor colorWithRed:r green:g blue:fistx alpha:styleR];
        }
    }
    return [self applyBlurWithRadius:10 tintColor:type_qpY saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage {
    
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect footern = { CGPointZero, self.size };
    UIImage *limitImageg = self;
    
    BOOL cityb = blurRadius > __FLT_EPSILON__;
    BOOL guanfangkefu = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (cityb || guanfangkefu) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef acc = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(acc, 1.0, -1.0);
        CGContextTranslateCTM(acc, 0, -self.size.height);
        CGContextDrawImage(acc, footern, self.CGImage);
        
        vImage_Buffer header;
        header.data     = CGBitmapContextGetData(acc);
        header.width    = CGBitmapContextGetWidth(acc);
        header.height   = CGBitmapContextGetHeight(acc);
        header.rowBytes = CGBitmapContextGetBytesPerRow(acc);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef script = UIGraphicsGetCurrentContext();
        vImage_Buffer nicku;
        nicku.data     = CGBitmapContextGetData(script);
        nicku.width    = CGBitmapContextGetWidth(script);
        nicku.height   = CGBitmapContextGetHeight(script);
        nicku.rowBytes = CGBitmapContextGetBytesPerRow(script);
        
        if (cityb) {
            
            
            
            
            
            
            
            
            
            
            
            
            CGFloat abbarP = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger area68 = floor(abbarP * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (area68 % 2 != 1) {
                area68 += 1; 
            }
            vImageBoxConvolve_ARGB8888(&header, &nicku, NULL, 0, 0, (uint32_t)area68, (uint32_t)area68, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&nicku, &header, NULL, 0, 0, (uint32_t)area68, (uint32_t)area68, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&header, &nicku, NULL, 0, 0, (uint32_t)area68, (uint32_t)area68, 0, kvImageEdgeExtend);
        }
        BOOL daozhangjine = NO;
        if (guanfangkefu) {
            CGFloat dragingO = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * dragingO,  0.0722 - 0.0722 * dragingO,  0.0722 - 0.0722 * dragingO,  0,
                0.7152 - 0.7152 * dragingO,  0.7152 + 0.2848 * dragingO,  0.7152 - 0.7152 * dragingO,  0,
                0.2126 - 0.2126 * dragingO,  0.2126 - 0.2126 * dragingO,  0.2126 + 0.7873 * dragingO,  0,
                0,                    0,                    0,  1,
            };
            const int32_t huankuanyewuv = 256;
            NSUInteger cell9 = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[cell9];
            for (NSUInteger i = 0; i < cell9; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * huankuanyewuv);
            }
            if (cityb) {
                vImageMatrixMultiply_ARGB8888(&nicku, &header, saturationMatrix, huankuanyewuv, NULL, NULL, kvImageNoFlags);
                daozhangjine = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&header, &nicku, saturationMatrix, huankuanyewuv, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!daozhangjine)
            limitImageg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (daozhangjine)
            limitImageg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef xinyongkablockH = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(xinyongkablockH, 1.0, -1.0);
    CGContextTranslateCTM(xinyongkablockH, 0, -self.size.height);
    
    
    CGContextDrawImage(xinyongkablockH, footern, self.CGImage);
    
    
    if (cityb) {
        CGContextSaveGState(xinyongkablockH);
        if (maskImage) {
            CGContextClipToMask(xinyongkablockH, footern, maskImage.CGImage);
        }
        CGContextDrawImage(xinyongkablockH, footern, limitImageg.CGImage);
        CGContextRestoreGState(xinyongkablockH);
    }
    
    
    if (tintColor) {
        CGContextSaveGState(xinyongkablockH);
        CGContextSetFillColorWithColor(xinyongkablockH, tintColor.CGColor);
        CGContextFillRect(xinyongkablockH, footern);
        CGContextRestoreGState(xinyongkablockH);
    }
    
    
    UIImage *imvImagei = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imvImagei;
    
}

@end



