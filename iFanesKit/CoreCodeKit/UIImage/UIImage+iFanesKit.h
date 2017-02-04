//
//  UIImage+iFanesKit.h
//  iFanesKit
//
//  Created by 317744017@qq.com on 2017/2/4.
//  Copyright © 2017年 thousandcrane@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface  UIImage (iFanesKit)
/**
 * 处理一些特殊的图片，因为这些特殊的图片再压缩的时候，下面会多一条白色的线
 */
-(UIImage*) toFormatImage;


/**
 * 压缩 UIImage 图片
 */
-(UIImage *)toCompressionImage;

/**
 * 压缩 UIImage 图片
 */
-(UIImage *)toCompressionImage :(float )maxWidth;



/**
 * 压缩成指定大小的图片
 */
+ (UIImage *)toScaleAndCropingForSize:(CGSize)newSize oldImage:(UIImage *)image;

/**
 * 等比例压缩
 */
+ (UIImage *) toCompressForSizeImage:(UIImage *)image targetSize:(CGSize)size;


/**
 * 根据颜色创建图片
 * 比如你要创建纯蓝色的背景图片等待
 */
+(UIImage*) toImageWithColor: (UIColor*) color;


-(NSData *)toData;
-(NSData *)toData:(float )maxWidth;

@end
