//
//  UIImage+Quart2D.h
//  PGG_OC_Image
//
//  Created by 陈鹏 on 2018/1/23.
//  Copyright © 2018年 penggege.CP. All rights reserved.
//https://github.com/penghero/PGG_OC_Image.git

#import <UIKit/UIKit.h>

/**
 图片工具整理类
 
 */
@interface UIImage (Quart2D)


/**
 压缩成指定大小的图片

 @param image <#image description#>
 @param maxLength <#maxLength description#>
 @return <#return value description#>
 */
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
/**
 生成纯色图片
 @param color 颜色
 @param rect 大小
 @return 返回生成好的图片
 */

+ (UIImage *)createImageWithColor:(UIColor *)color frame:(CGRect)rect;

/**
 按原图片名生成图片

 @param name <#name description#>
 @return <#return value description#>
 */
+ (UIImage *)drawImageWithImageNamed:(NSString *)name;
/**
 添加文字水印的图片

 @param image <#image description#>
 @param text <#text description#>
 @param point <#point description#>
 @param attributed <#attributed description#>
 @return <#return value description#>
 */
+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed;

/**
 添加图片水印的图片

 @param image <#image description#>
 @param waterImage <#waterImage description#>
 @param rect <#rect description#>
 @return <#return value description#>
 */
+ (UIImage *)waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

/**
 裁剪圆形图片

 @param image <#image description#>
 @param rect <#rect description#>
 @return <#return value description#>
 */
+ (UIImage *)clipCircleImageWithImage:( UIImage *)image circleRect:(CGRect)rect;


/**
 裁剪带边框的圆形图片

 @param image <#image description#>
 @param rect <#rect description#>
 @param borderW <#borderW description#>
 @param borderColor <#borderColor description#>
 @return <#return value description#>
 */
+ (UIImage *)clipCircleImageWithImage:( UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:( UIColor *)borderColor;

/**
 截屏

 @param view <#view description#>
 @param block <#block description#>
 */
+ (void)cutScreenWithView:( UIView *)view successBlock:( void(^)(UIImage *  image,NSData *  imagedata))block;

/**
 图片擦除 类似于刮奖

 @param view <#view description#>
 @param nowPoint <#nowPoint description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+ (UIImage *)wipeImageWithView:(UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size;
/**
 高斯毛玻璃

 @param image 原图片
 @param blur 模糊程度 0-1
 @return 生成带有毛玻璃效果的图片
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
/**
 *从图片中按指定的位置大小截取图片的一部分
 * UIImage image 原始的图片
 * CGRect rect 要截取的区域
 */
+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

/**
 *根据给定的size的宽高比自动缩放原图片、自动判断截取位置,进行图片截取
 * UIImage image 原始的图片
 * CGSize size 截取图片的size
 */
+ (UIImage *)clipImage:(UIImage *)image toRect:(CGSize)size;
/*
 保存图片
 */
+ (void)saveImageToPhotosAlbum:(UIImage*)image;
@end
