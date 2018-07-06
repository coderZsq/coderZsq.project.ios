//
//  ComponentCell.m
//  SQPerformance
//
//  Created by 朱双泉 on 2018/7/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import "ComponentCell.h"
#import "ComponentLayout.h"
#import "Element.h"
#import "ReusePool.h"

@interface ComponentCell ()

@property (nonatomic, strong) ReusePool * labelReusePool;
@property (nonatomic, strong) ReusePool * imageReusePool;

@end

@implementation ComponentCell

- (void)dealloc {
#if DEBUG
    NSLog(@"--------");
    NSLog(@"%@ - execute %s",NSStringFromClass([self class]),__func__);
    NSLog(@"--------");
#endif
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString * identifier = NSStringFromClass([ComponentCell class]);
    ComponentCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[ComponentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupConfig];
    }
    return cell;
}

- (void)setupConfig {
    _labelReusePool = [ReusePool new];
    _imageReusePool = [ReusePool new];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    for (UIView * view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
}

- (void)setupData:(ComponentLayout *)layout {

    for (Element * element in layout.textElements) {
        UILabel * label = (UILabel *)[_labelReusePool dequeueReusableObject];
        if (!label) {
            label = [UILabel new];
            [_labelReusePool addUsingObject:label];
        }
        label.text = element.value;
        label.frame = element.frame;
        label.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:label];
    }
    [_labelReusePool reset];
    
    for (Element * element in layout.imageElements) {
        UIImageView * imageView = (UIImageView *)[_imageReusePool dequeueReusableObject];
        if (!imageView) {
            imageView = [UIImageView new];
            [_imageReusePool addUsingObject:imageView];
        }
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            UIImage * image = [self preDecodeFrom:element.value];
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = image;
            });
        });
        imageView.frame = element.frame;
        [self.contentView addSubview:imageView];
    }
    [_imageReusePool reset];
}

- (UIImage *)preDecodeFrom:(NSString *)url {
    
    CGImageRef cgImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]].CGImage;
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(cgImage) & kCGBitmapAlphaInfoMask;
    
    BOOL hasAlpha = NO;
    if (alphaInfo == kCGImageAlphaPremultipliedLast ||
        alphaInfo == kCGImageAlphaPremultipliedFirst ||
        alphaInfo == kCGImageAlphaLast ||
        alphaInfo == kCGImageAlphaFirst) {
        hasAlpha = YES;
    }
    
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
    bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
    
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGColorSpaceCreateDeviceRGB(), bitmapInfo);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    cgImage = CGBitmapContextCreateImage(context);
    
    UIImage * image = [UIImage imageWithCGImage:cgImage];
    CGContextRelease(context);
    CGImageRelease(cgImage);
    return image;
}

@end
