//
//  NSString+iFanesKit.h
//  iFanesKit
//
//  Created by thousandcrane@qq.com on 2017/2/4.
//  Copyright © 2017年 www.ifanes.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface  NSString (iFanesKit)

#pragma mark 常用字符串转换
/**
 * 将任意类型转换为字符串
 * str              : 任意类型
 */
+ (NSString *)toString:(id)str;


/**
 * 将字符串转换为整数，默认为0
 */
- (NSInteger)toInteger;

/**
 * 将字符串转换为浮点，默认为0
 */
- (CGFloat)toFloat;


/**
 * Unix时间戳转换可以把Unix时间转成北京时间 
 * 比如：1486176435  可以转换为：2017-02-04 10:47:15
 */
-(NSString *)unixDateToDateString;


/**
 * Unix时间戳转换可以把Unix时间转成北京时间
 * 比如：1486176435  可以转换为：2017-02-04 10:47:15
 *  @param format 要转换的日期格式  比如传递字符串  yyyy-MM-dd hh:mm:ss  就会转换成为：2017-02-04 10:47:15
 */
-(NSString *)unixDateToDateStringWithFormat:(NSString *)format;


/**
 * 返回微信聊天记录里面那样的时间提示， 比如 早上10点30分，可以根据手机设置的24小时制 或者12小时制，自动的来显示
 */
-(NSString *)unixDateToWeChatToDayStringWith;

/**
 * 根据当前self 的时间 返回返回上午，下午 还是晚上
 */
-(NSString *)toWeChatTips;

/**
 *   字符串里面删除超过指定长度的文字或者包括表情
 *
 *  @param maxLenght 字符串最大的长度
 *  @param string       要被删除的字符串
 *
 *  @return 满足要求的字符串
 */
+(NSString *)deleteStr:(NSInteger )maxLenght String:(NSString *)string;

#pragma mark 字符串核对相关
//该字符串是否是电话号码
-(BOOL)isTelePhoneNumber;

/**
 *  判断是否emoji表情
 *
 *  @param string 被判断的是非常
 
 */
+ (BOOL)isContainsEmoji:(NSString *)string ;


@end
