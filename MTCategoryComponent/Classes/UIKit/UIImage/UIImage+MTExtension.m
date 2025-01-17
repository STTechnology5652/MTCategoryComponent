///**
/**
Categoties
Created by: Tom.Liu on 2021/1/8
Github : https://github.com/lyleLH

 	 * ⣿⣿⣿⣿⣿⣿⢟⣡⣴⣶⣶⣦⣌⡛⠟⣋⣩⣬⣭⣭⡛⢿⣿⣿⣿⣿
	 * ⣿⣿⣿⣿⠋⢰⣿⣿⠿⣛⣛⣙⣛⠻⢆⢻⣿⠿⠿⠿⣿⡄⠻⣿⣿⣿ 
	 * ⣿⣿⣿⠃⢠⣿⣿⣶⣿⣿⡿⠿⢟⣛⣒⠐⠲⣶⡶⠿⠶⠶⠦⠄⠙⢿ 
	 * ⣿⠋⣠⠄⣿⣿⣿⠟⡛⢅⣠⡵⡐⠲⣶⣶⣥⡠⣤⣵⠆⠄⠰⣦⣤⡀ 
	 * ⠇⣰⣿⣼⣿⣿⣧⣤⡸⢿⣿⡀⠂⠁⣸⣿⣿⣿⣿⣇⠄⠈⢀⣿⣿⠿ 
	 * ⣰⣿⣿⣿⣿⣿⣿⣿⣷⣤⣈⣙⠶⢾⠭⢉⣁⣴⢯⣭⣵⣶⠾⠓⢀⣴
	 * ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣉⣤⣴⣾⣿⣿⣦⣄⣤⣤⣄⠄⢿⣿
	 * ⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⠈⢿
	 * ⣿⣿⣿⣿⣿⣿⡟⣰⣞⣛⡒⢒⠤⠦⢬⣉⣉⣉⣉⣉⣉⣉⡥⠴⠂⢸
	 * ⠻⣿⣿⣿⣿⣏⠻⢌⣉⣉⣩⣉⡛⣛⠒⠶⠶⠶⠶⠶⠶⠶⠶⠂⣸⣿
	 * ⣥⣈⠙⡻⠿⠿⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣿⠿⠛⢉⣠⣶⣶⣿⣿
	 * ⣿⣿⣿⣶⣬⣅⣒⣒⡂⠈⠭⠭⠭⠭⠭⢉⣁⣄⡀⢾⣿⣿⣿⣿⣿⣿

*/

#import "UIImage+MTExtension.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (MTExtension)

/// 把图片转换成base64编码的字符串
- (NSString *)mt_toBase64 {
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    NSString *encodedImageStr = nil;
  #if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
      [data base64EncodedStringWithOptions:0];
  #else
      [data base64Encoding];
  #endif
    
    return encodedImageStr;
}

/// 生成一个指定尺寸的渐变色的图片对象
/// @param size 指定尺寸
/// @param leftColor 渐变色开始颜色
/// @param rightColor 渐变色结束颜色
+ (UIImage *)mt_imageWithSize:(CGSize)size leftColor:(UIColor *)leftColor rightColor:(UIColor *)rightColor {
    //创建CGContextRef
    UIGraphicsBeginImageContext(size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    //绘制Path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)];
    //绘制渐变
    [self mt_drawLinearGradient:gc path:path.CGPath startColor:leftColor.CGColor endColor:rightColor.CGColor];
    // 从 Context 中获取图像
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/// 绘制线性的渐变色路径
/// @param context 上下文
/// @param path 渐变路径
/// @param startColor 开始颜色
/// @param endColor 结束颜色
+ (void)mt_drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor {
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    //具体方向可根据需求修改
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}




/// 指定颜色和尺寸生成 Image
/// @param color 指定颜色
/// @param size 指定尺寸
+ (UIImage *)mt_colorImageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/// 将某个图片对象 缩放到某个指定的尺寸 （需要对大小进行压缩时候可能用到）
/// @param img 图片对象
/// @param size 指定的尺寸
+(UIImage *)mt_scaleImage:(UIImage *)img toSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

/**
 *  压缩图片质量，返回值为可直接转化成UIImage对象的NSData对象
 *  aimLength: 目标大小，单位：字节（b）
 *  accuracyOfLength: 压缩控制误差范围(+ / -)，本方法虽然给出了误差范围，但实际上很难确定一张图片是否能压缩到误差范围内，无法实现精确压缩。
 */
+ (NSData *)mt_compressImageWithImage:(UIImage *)image aimWidth:(CGFloat)width aimLength:(NSInteger)length accuracyOfLength:(NSInteger)accuracy {
    UIImage * newImage = [self mt_scaleImage:image toSize:CGSizeMake(width, width * image.size.height / image.size.width)];
    NSData  * data = UIImageJPEGRepresentation(newImage, 1);
    NSInteger imageDataLen = [data length];
    
    if (imageDataLen <= length + accuracy) {
        return data;
    }else{
        NSData * imageData = UIImageJPEGRepresentation( newImage, 0.99);
        if (imageData.length < length + accuracy) {
            return imageData;
        }
        
        CGFloat maxQuality = 1.0;
        CGFloat minQuality = 0.0;
        int flag = 0;
        
        while (1) {
            CGFloat midQuality = (maxQuality + minQuality)/2;
            
            if (flag == 6) {
                NSLog(@"************* %ld ******** %f *************",UIImageJPEGRepresentation(newImage, minQuality).length,minQuality);
                return UIImageJPEGRepresentation(newImage, minQuality);
            }
            flag ++;
            
            NSData * imageData = UIImageJPEGRepresentation(newImage, midQuality);
            NSInteger len = imageData.length;
            
            if (len > length+accuracy) {
                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
                maxQuality = midQuality;
                continue;
            }else if (len < length-accuracy){
                NSLog(@"-----%d------%f------%ld-----",flag,midQuality,len);
                minQuality = midQuality;
                continue;
            }else{
                NSLog(@"-----%d------%f------%ld--end",flag,midQuality,len);
                return imageData;
                break;
            }
        }
    }
}

/*
 * 裁剪图片
 */
- (UIImage *)mt_cropImageWithX:(CGFloat)x
                          y:(CGFloat)y
                      width:(CGFloat)width
                     height:(CGFloat)height
{
    CGRect rect = CGRectMake(x, y, width, height);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    return image;
}


/// 图片尺比例不变的情况下，缩放其尺寸，按宽或者高来充满屏幕显示，
/// @param image 需要缩放的图片
+ (UIImage *)mt_fitScreenWithImage:(UIImage *)image
{
    CGSize newSize;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    BOOL min = image.size.height>image.size.width;
    if (min && image.size.width<screenWidth) {
        CGFloat scale = screenWidth/image.size.width;
        newSize = CGSizeMake(screenWidth, image.size.height*scale);
    }else if (min && image.size.width >= screenWidth){
        CGFloat scale = screenWidth/image.size.width;
        newSize = CGSizeMake(screenWidth, image.size.height*scale);
    }else{
        CGFloat scale = screenWidth/image.size.height;
        newSize = CGSizeMake(image.size.width * scale, screenWidth);
    }
     image = [self mt_scaleImage:image toSize:newSize];
    return image;
}


- (UIImage *)stBlurNumber:(CGFloat)blur { // 添加通用模糊效果
    UIImage *image = self;
    //模糊度,
    if (blur < 0.025f) {
        blur = 0.025f;
    } else if (blur > 1.0f) {
        blur = 1.0f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    //CGColorSpaceRelease(colorSpace);   //多余的释放
    CGImageRelease(imageRef);
    return returnImage;
}

@end
