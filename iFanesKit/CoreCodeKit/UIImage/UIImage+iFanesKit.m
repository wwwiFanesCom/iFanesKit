//
//  NSString+iFanesKit.h
//  iFanesKit
//
//  Created by thousandcrane@qq.com on 2017/2/4.
//  Copyright © 2017年 www.ifanes.com. All rights reserved.
//

#import "UIImage+iFanesKit.h"

@implementation UIImage (iFanesKit)

 
+ (UIImage *)toScaleAndCropingForSize:(CGSize)newSize oldImage:(UIImage *)image
{
    //创建一个bitmap 的context ，并把它设置成当前正在使用的context ，
    UIGraphicsBeginImageContext(newSize);
    //绘制改变大小的图片，
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    //从当前的context 中创建一个改变大小后的图片，
    UIImage * scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    //让当前的context出堆栈，
    UIGraphicsEndImageContext();
    //返回缩放后的图片
    return scaleImage;
    
}
+ (UIImage *)toCompressForSizeImage:(UIImage *)image targetSize:(CGSize)size
{
    UIImage * newImage = nil;
    CGSize iamgeSize = image.size;
    CGFloat width = iamgeSize.width;
    CGFloat height  = iamgeSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaleWidth = targetWidth;
    CGFloat scaleHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(iamgeSize, size)==NO)
    {
        CGFloat widthFactor = targetWidth/width;
        CGFloat heightFactor = targetHeight/height;
        if (widthFactor >heightFactor)
        {
            scaleFactor = widthFactor;
            
        }
        else
        {
            scaleFactor = heightFactor;
            
        }
        scaleWidth  =width * scaleFactor;
        scaleHeight = height * scaleFactor;
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight-scaleHeight)*0.5;
            
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth -scaleWidth)*0.5;
            
        }
        
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    [image drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage==nil)
    {
        NSLog(@"scale image file");
    }
    UIGraphicsEndImageContext();
    
    
    return newImage;
}

- (UIImage*) toFormatImage

{
    
    //create a context to do our clipping in
    
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    
    
    //create a rect with the size we want to crop the image to
    
    //the X and Y here are zero so we start at the beginning of our
    
    //newly created context
    
    CGRect clippedRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextClipToRect( currentContext, clippedRect);
    
    
    
    //create a rect equivalent to the full size of the image
    
    //offset the rect by the X and Y we want to start the crop
    
    //from in order to cut off anything before them
    
    CGRect drawRect = CGRectMake(0,
                                 
                                 0,
                                 
                                 self.size.width,
                                 
                                 self.size.height);
    
    
    
    //draw the image to our clipped context using our offset rect
    
    CGContextTranslateCTM(currentContext, 0.0, self.size.height);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    CGContextDrawImage(currentContext, drawRect, self.CGImage);
    
    
    
    //pull the image from our cropped context
    
    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    //pop the context to get back to the default
    
    UIGraphicsEndImageContext();
    
    
    
    //Note: this is autoreleased
    
    return cropped;
    
}
+(UIImage*) toImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}


-(NSData *)toData
{
    NSData *data  =nil  ;
    UIImage *tempImages = self;
    tempImages= [tempImages toCompressionImage];
    data = UIImagePNGRepresentation(tempImages);
    if ( data == nil) {
        tempImages=[tempImages toFormatImage];
        data = UIImagePNGRepresentation(tempImages  );
    }
    return data;

}
-(NSData *)toData:(float )maxWidth
{
    NSData *data  =nil  ;
    UIImage *tempImages = self;
    tempImages= [tempImages toCompressionImage:maxWidth];
    data = UIImagePNGRepresentation(tempImages);
    if ( data == nil) {
        tempImages=[tempImages toFormatImage];
        data = UIImagePNGRepresentation(tempImages  );
    }
    return data;

}
///压缩 UIImage 图片
-(UIImage *)toCompressionImage
{
    //    return self;
    //------判断为空
    
    UIImage *image = self;
    
    if(!image)
    {
        return  [[UIImage alloc] init];
        
    }
    if(image.size.width<= 1080    )
    {
        return self;
    }
    //------判断为空
    
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 1080;
    float height = image.size.height/(image.size.width/width);
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height),YES,1.0);
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        
        NSInteger tempHeight= (NSInteger )imageHeight /widthScale;
        
        [image drawInRect:CGRectMake(0, 0, width , (CGFloat)tempHeight-1)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
///压缩 UIImage 图片
-(UIImage *)toCompressionImage :(float )maxWidth
{
    //    return self;
    //------判断为空
    
    UIImage *image = self;
    
    if(!image)
    {
        return  [[UIImage alloc] init];
        
    }
    if(image.size.width<= maxWidth    )
    {
        return self;
    }
    //------判断为空
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = maxWidth;
    float height = image.size.height/(image.size.width/width);
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height),YES,1.0);
    
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }
    else {
        
        NSInteger tempHeight= (NSInteger )imageHeight /widthScale;
        
        [image drawInRect:CGRectMake(0, 0, width , (CGFloat)tempHeight-1)];
    }
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
