//
//  UIImage+SQExtension.m
//
//  Created by Doubles_Z on 15/9/5.
//  Copyright (c) 2015年 Doubles_Z. All rights reserved.
//

#import "UIImage+SQExtension.h"

@implementation UIImage (SQExtension)

+ (UIImage *)imageResizableNamed:(NSString *)name {
    
    UIImage * image = [UIImage imageNamed:name];
    CGFloat width = image.size.width * 0.5f;
    CGFloat height = image.size.height * 0.5f;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width)];
}

+ (UIImage *)imageWatermarkNamed:(NSString *)watermarkName named:(NSString *)name scale:(CGFloat)scale {

    UIImage * background = [UIImage imageNamed:name];
    UIGraphicsBeginImageContextWithOptions(background.size, NO, 0.0f);
    [background drawInRect:CGRectMake(0, 0, background.size.width, background.size.height)];
    
    UIImage * watermark = [UIImage imageNamed:watermarkName];
    CGFloat watermarkW = watermark.size.width * scale;
    CGFloat watermarkH = watermark.size.height * scale;
    CGFloat watermarkX = background.size.width - watermarkW - 8;
    CGFloat watermarkY = background.size.height - watermarkH - 8;
    [watermark drawInRect:CGRectMake(watermarkX, watermarkY, watermarkW, watermarkH)];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageRoundNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    UIImage * original = [UIImage imageNamed:name];
    CGFloat originalW = original.size.width + 2 * borderWidth;
    CGFloat originalH = original.size.height + 2 * borderWidth;
    CGSize originalSize = CGSizeMake(originalW, originalH);
    UIGraphicsBeginImageContextWithOptions(originalSize, NO, 0.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext(); [borderColor set];
    CGFloat ex_radius = originalW * 0.5f;
    CGFloat centerX = ex_radius;
    CGFloat centerY = ex_radius;
    CGContextAddArc(context, centerX, centerY, ex_radius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    CGFloat in_radius = ex_radius - borderWidth;
    CGContextAddArc(context, centerX, centerY, in_radius, 0, M_PI * 2, 0);

    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageCaptureWithView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0f);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIColor *)pixelColorAtLocation:(CGPoint)point {
    
    UIColor *color         = nil;
    CGImageRef inImage     = self.CGImage;
    CGContextRef contexRef = [self ARGBBitmapContextFromImage:inImage];
    if (contexRef == NULL) return nil;
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    CGContextDrawImage(contexRef, rect, inImage);
    
    unsigned char * data = CGBitmapContextGetData (contexRef);
    if (data != NULL) {
        
        int offset = 4 * ((w * round(point.y))+round(point.x));
        int alpha  = data[offset];
        int red    = data[offset+1];
        int green  = data[offset+2];
        int blue   = data[offset+3];
        color      = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
    }
    CGContextRelease(contexRef);
    if (data) { free(data); }
    
    return color;
}

- (CGContextRef)ARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    size_t          bitmapByteCount;
    size_t          bitmapBytesPerRow;
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL) {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL) {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    if (context == NULL) {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

@end
