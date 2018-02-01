//
//  UIImage+Quart2D.m
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/23.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//https://github.com/penghero/PGG_OC_Image.git

#import "UIImage+Quart2D.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Quart2D)
/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
+ (UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size{
    
        //被切图片宽比例比高比例小 或者相等，以图片宽进行放大
    if (image.size.width*size.height <= image.size.height*size.width) {
        
            //以被剪裁图片的宽度为基准，得到剪切范围的大小
        CGFloat width  = image.size.width;
        CGFloat height = image.size.width * size.height / size.width;
        
            // 调用剪切方法
            // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [UIImage imageFromImage:image inRect:CGRectMake(0, (image.size.height -height)/2, width, height)];
        
    }else{ //被切图片宽比例比高比例大，以图片高进行剪裁
        
            // 以被剪切图片的高度为基准，得到剪切范围的大小
        CGFloat width  = image.size.height * size.width / size.height;
        CGFloat height = image.size.height;
        
            // 调用剪切方法
            // 这里是以中心位置剪切，也可以通过改变rect的x、y值调整剪切位置
        return [UIImage imageFromImage:image inRect:CGRectMake((image.size.width -width)/2, 0, width, height)];
    }
    return nil;
}


/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
        //将UIImage转换成CGImageRef
    CGImageRef sourceImageRef = [image CGImage];
    
        //按照给定的矩形区域进行剪裁
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    
        //将CGImageRef转换成UIImage
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
        //返回剪裁后的图片
    return newImage;
}


+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return resultImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)drawImageWithImageNamed:(NSString *)name{
        //1.获取图片
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]];
        //2.开启图形上下文
    UIGraphicsBeginImageContext(image.size);
        //3.绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //4.从上下文中获取图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //5.关闭图形上下文
    UIGraphicsEndImageContext();
        //返回图片
    return newImage;
}

+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed{
        //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
        //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //5.关闭图形上下文
    UIGraphicsEndImageContext();
        //返回图片
    return newImage;
    
}

+ (UIImage *)waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect{
        //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        //3.绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
        //4.从上下文中获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //5.关闭图形上下文
    UIGraphicsEndImageContext();
        //返回图片
    return newImage;
}

+ (UIImage *)clipCircleImageWithImage:( UIImage *)image circleRect:(CGRect)rect{
        //1、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        //2、设置裁剪区域
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
        //3、绘制图片
    [image drawAtPoint:CGPointZero];
        //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //5、关闭上下文
    UIGraphicsEndImageContext();
        //6、返回新图片
    return newImage;
}

+ (UIImage *)clipCircleImageWithImage:( UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:( UIColor *)borderColor{
        //1、开启上下文
    UIGraphicsBeginImageContext(image.size);
        //2、设置边框
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
        //3、设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2)];
    [clipPath addClip];
        //4、绘制图片
    [image drawAtPoint:CGPointZero];
        //5、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //6、关闭上下文
    UIGraphicsEndImageContext();
        //7、返回新图片
    return newImage;
}

+ (void)cutScreenWithView:( UIView *)view successBlock:( void(^)(UIImage *  image,NSData *  imagedata))block{
        //1、开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
        //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
        //3.截屏
    [view.layer renderInContext:ctx];
        //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //5.转化成为Data
        //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
        //6、关闭上下文
    UIGraphicsEndImageContext();
        //7.回调
    block(newImage,data);
}

+ (UIImage *)wipeImageWithView:(UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size{
        //计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
        //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1);
        //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
        //把图片绘制上去
    [view.layer renderInContext:ctx];
        //把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
        //获取新的图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
    UIGraphicsEndImageContext();
        //重新赋值图片
    return newImage;
}


+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
        //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
        //设置从CGImage获取对象的属性
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
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

    // 保存图片
+ (void)saveImageToPhotosAlbum:(UIImage*)image{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if(error != NULL){
            // 保存图片失败
        
    }else{
            // 保存图片成功
        
    }
}

@end
