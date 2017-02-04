//
//  UIColor.h
//  iFanesKit
//
//  Created by 317744017@qq.com on 2017/2/4.
//  Copyright © 2017年 thousandcrane@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor  (iFanesKit)


/**
 * 根据RGB颜色返回UIColor
 * 用法：[UIColor colorWithRGB:0xff0011];
 *  @param rgb  RGB颜色值  ， 比如 ： 0xffffff   这里0x一定要传递，这个代表16进制数
 */
+ (UIColor *) colorWithRGB:(NSInteger)rgb;
@end
