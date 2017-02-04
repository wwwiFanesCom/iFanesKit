//
//  UIColor.m
//  iFanesKit
//
//  Created by 317744017@qq.com on 2017/2/4.
//  Copyright © 2017年 thousandcrane@qq.com. All rights reserved.
//

#import "UIColor+iFanesKit.h"
#define GetRGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor  (iFanesKit)
+ (UIColor *) colorWithRGB:(NSInteger)rgb
{
    return GetRGBColor(rgb);
}
@end
