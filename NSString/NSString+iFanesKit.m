//
//  NSString+iFanesKit.h
//  iFanesKit
//
//  Created by thousandcrane@qq.com on 2017/2/4.
//  Copyright © 2017年 www.ifanes.com. All rights reserved.
//


#import "NSString+iFanesKit.h"

@implementation  NSString (iFanesKit)

+ (NSString *)toString:(id)str
{
    NSString *reStr =@"";
    if(str == nil )
    {
        return @"";
    }
    if([str isKindOfClass: [NSNull class]])
    {
        return @"";
    }
    if([str isKindOfClass:[NSNumber class]])
    {
        NSNumber *number = (NSNumber *)str;
        
        NSArray *floatTypeArray = @[@"f", @"d"];
        NSString *floatType = [NSString stringWithFormat:@"%s", number.objCType];
        if ([NSStringFromClass(number.class) isEqualToString:@"__NSCFNumber"] && [floatTypeArray containsObject:floatType]) {
            NSNumberFormatter *format =[[NSNumberFormatter alloc] init];
            format.numberStyle = NSNumberFormatterDecimalStyle;
            str = [format stringFromNumber:number];
            return  str;
            
        }
        else
        {
            NSNumberFormatter *format =[[NSNumberFormatter alloc] init];
            str = [format stringFromNumber:number];
            return  str;
            
        }
        
        
        
    }
    if (![str isKindOfClass:[NSString class]]) {
        str = [NSString stringWithFormat:@"%@",str];
    }
    reStr = [NSString stringWithFormat:@"%@",str];
    
    return reStr;

}

- (NSInteger)toInteger
{
    NSString *str = self;
    CGFloat strFloat = 0;
    
    if (str == nil) {
        str = @"0";
    }
    if (str.length == 0) {
        str = @"0";
    }
    
    if([str rangeOfString:@"."].location != NSNotFound)
    {
        strFloat  = [str toFloat];
        NSInteger strInt = strFloat;
        return strInt;
    }
    
    return  [str integerValue];
}

- (CGFloat)toFloat
{
    NSString *str = self;
    if (str == nil) {
        str = @"0";
    }
    if (str.length == 0) {
        str = @"0";
    }
    
    NSString *firstStr =str;
    NSString *scendStr =@"";
    
    NSRange range = [firstStr rangeOfString:@"."];
    if(range.location != NSNotFound && range.location +1 < firstStr.length)
    {
        
        firstStr  = [firstStr substringToIndex:range.location+1];
        scendStr = [str substringFromIndex:range.location+1];
        scendStr = [scendStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    str = [NSString stringWithFormat:@"%@%@",firstStr,scendStr];
    
    return  [str floatValue];
}


-(NSString *)unixDateToDateString
{
    return [self unixDateToDateStringWithFormat:nil];
}

-(NSString *)unixDateToDateStringWithFormat:(NSString *)format
{
    if([NSString toString:format].length == 0)
    {
        format = @"YYYY-MM-dd HH:mm:ss";
    }
    NSString *str = self;
    if(str.length >10)
    {
        //时间戳为12位时
        NSInteger time = [str integerValue] / 1000;
        str = [NSString stringWithFormat:@"%ld",time ];
    }
    
    NSDateFormatter *formatter = [ [NSDateFormatter alloc] init]   ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


-(NSString *)unixDateToWeChatToDayStringWith
{
    
    //获取系统是24小时制或者12小时制
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA =[formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM =containsA.location != NSNotFound;
    //hasAMPM==TURE为12小时制，否则为24小时制
    
    NSString *str = self;
    
    if(str.length >10)
    {
        str = [str substringToIndex:10];
        str = [NSString stringWithFormat:@"%ld",[str integerValue]/1];
    }
    
    NSDateFormatter *formatter = [ [NSDateFormatter alloc] init]   ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str integerValue]];
    
    
    NSDate *date = [NSDate date];
    
    
    NSString *yearInt =@"0" ;
    NSString *monthInt =@"0";
    NSString *dayInt =@"0";
    NSString *houseInt =@"0";
    NSString *minInt =@"0";
    
    NSString *toDayYearInt =@"0";
    NSString *toDayMonthInt =@"0";
    NSString *toDayDayInt =@"0";
    NSString *toDayHouseInt =@"0";
    NSString *toDayMinInt =@"0";
    
    
    
    [formatter setDateFormat:@"yyyy"];
    toDayYearInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    [formatter setDateFormat:@"MM"];
    toDayMonthInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"dd"];
    toDayDayInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"HH"];
    toDayHouseInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    [formatter setDateFormat:@"mm"];
    toDayMinInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    
    
    
    [formatter setDateFormat:@"yyyy"];
    yearInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:confromTimesp]];
    
    [formatter setDateFormat:@"MM"];
    monthInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:confromTimesp]];
    
    [formatter setDateFormat:@"dd"];
    dayInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:confromTimesp]];
    
    [formatter setDateFormat:@"HH"];
    houseInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:confromTimesp]];
    
    [formatter setDateFormat:@"mm"];
    minInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:confromTimesp]];
    //edit by 林金彬 2016-09-29 获取时间差距添加昨天返回
    // 获得nowDate和selfDate的差距
    
    NSInteger Ye = [[NSDate date] timeIntervalSince1970] - 24 * 3600;
    NSDate *YeDate = [NSDate dateWithTimeIntervalSince1970:Ye];
    
    NSString *yeDayYearInt =@"0";
    NSString *yeDayMonthInt =@"0";
    NSString *yeDayDayInt =@"0";
    NSString *yeDayHouseInt =@"0";
    NSString *yeDayMinInt =@"0";
    
    [formatter setDateFormat:@"yyyy"];
    yeDayYearInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:YeDate]];
    
    [formatter setDateFormat:@"MM"];
    yeDayMonthInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:YeDate]];
    
    [formatter setDateFormat:@"dd"];
    yeDayDayInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:YeDate]];
    
    [formatter setDateFormat:@"HH"];
    yeDayHouseInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:YeDate]];
    
    [formatter setDateFormat:@"mm"];
    yeDayMinInt = [NSString stringWithFormat:@"%@",[formatter stringFromDate:YeDate]];
    
    
    NSString *houseInt2=houseInt;
    if(hasAMPM)
    {
        if([houseInt toInteger ]>12)
        {
            houseInt2 = [NSString stringWithFormat:@"%ld",[houseInt toInteger ] -12 ];
            
        }
    }
    
    if ([yeDayYearInt toInteger] == [yearInt toInteger]) {
        if ([yeDayMonthInt toInteger]  == [monthInt toInteger] &&  [yeDayDayInt toInteger]  == [dayInt toInteger]) {
            return  [NSString stringWithFormat:@"昨天 %@%@:%@",[houseInt toWeChatTips],houseInt2,minInt];
        }
    }
    
    if([toDayYearInt toInteger] == [yearInt toInteger])
    {
        if ([toDayMonthInt toInteger]  == [monthInt toInteger] &&  [toDayDayInt toInteger]  == [dayInt toInteger]) {
            return  [NSString stringWithFormat:@"%@%@:%@",[houseInt toWeChatTips],houseInt2,minInt];
            
        }
    }
    return  [NSString stringWithFormat:@"%@年%@月%@日 %@%@:%@",yearInt,monthInt,dayInt,[houseInt toWeChatTips],houseInt2,minInt];
}
-(NSString *)toWeChatTips
{
    //获取系统是24小时制或者12小时制
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    NSRange containsA =[formatStringForHours rangeOfString:@"a"];
    BOOL hasAMPM =containsA.location != NSNotFound;
    //hasAMPM==TURE为12小时制，否则为24小时制
    if( hasAMPM ==  NO)
    {
        return @"";
    }
    
    if(self.length == 0)
    {
        return @"";
    }
    
    if ([self toInteger] <6 ) {
        return  @"凌晨";
    }
    
    if ([self toInteger] <=12 ) {
        return  @"上午";
    }
    
    if ([self toInteger] <=18 ) {
        return  @"下午";
    }
    
    return  @"晚上";
}

+(NSString *)deleteStr:(NSInteger )maxLenght String:(NSString *)string
{
    if (!string) {
        return @"";
    }
    if (string.length <= maxLenght) {
        return string;
    }
    
    NSLog(@"\n 文字长度为：%ld",string.length);
    NSLog(@"\n 需要删除的文字：%@",string);
    NSString *newStr = [NSString stringWithFormat:@"%@",string] ;
    NSString *text = [NSString stringWithFormat:@"%@",string] ;
    
    if (text.length >3) {
        if ([self isContainsEmoji:[text substringFromIndex:text.length-1]]) {
            newStr=[text substringToIndex:text.length-1];
        }else if ([self isContainsEmoji:[text substringFromIndex:text.length-2]]) {
            newStr=[text substringToIndex:text.length-2];
        }else if ([self isContainsEmoji:[text substringFromIndex:text.length-3]]) {
            newStr=[text substringToIndex:text.length-3];
        }else   if ([self isContainsEmoji:[text substringFromIndex:text.length-4]]) {
            newStr=[text substringToIndex:text.length-4];
        }else{
            newStr=[text substringToIndex:text.length-1];
        }
        
    }else if (text.length >2) {
        
        if ([self isContainsEmoji:[text substringFromIndex:text.length-1]]) {
            newStr=[text substringToIndex:text.length-1];
        }else if ([self isContainsEmoji:[text substringFromIndex:text.length-2]]) {
            newStr=[text substringToIndex:text.length-2];
        }else if ([self isContainsEmoji:[text substringFromIndex:text.length-3]]) {
            newStr=[text substringToIndex:text.length-3];
        }else{
            newStr=[text substringToIndex:text.length-1];
        }
    }else   if (text.length >1) {
        if ([self isContainsEmoji:[text substringFromIndex:text.length-1]]) {
            newStr=[text substringToIndex:text.length-1];
        }else if ([self isContainsEmoji:[text substringFromIndex:text.length-2]]) {
            newStr=[text substringToIndex:text.length-2];
        }else{
            newStr=[text substringToIndex:text.length-1];
        }
        
    }else {
        
        if([self isValidateChineseWord:text])
        {
            newStr=[text substringToIndex:text.length-2];
            
        }else
        {
            newStr=[text substringToIndex:text.length-1];
        }
        
    }
    
    if (newStr.length > maxLenght) {
    
        newStr = [self deleteStr:maxLenght String:newStr];
    }
    return newStr;
}

+(BOOL)isValidateChineseWord:(NSString *)str
{
    NSString *word = str;
    // 只需要不是中文即可
    NSString *regex = @".{0,}[\u4E00-\u9FA5].{0,}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self matches %@",regex];
    BOOL res = [predicate evaluateWithObject:word];
    if (res == TRUE) {
        //NSLog(@"\n 是中文");
        return FALSE;
    }
    else
    {
        return TRUE;
    }
}
+ (BOOL)isContainsEmoji:(NSString *)string {
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    isEomji = YES;
                }
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                isEomji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                isEomji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                isEomji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                isEomji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                isEomji = YES;
            }
            if (!isEomji && substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                if (ls == 0x20e3) {
                    isEomji = YES;
                }
            }
        }
    }];
    return isEomji;
}

-(BOOL)isTelePhoneNumber
{
    //正则表达式匹配
    //手机的格式以13、15、18 开头，后面9位数字
    NSString *patternTel = @"^1[3,5,8,7][0-9]{9}$";
    NSError *err = nil;
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:patternTel options:NSRegularExpressionCaseInsensitive error:&err];
    
    NSTextCheckingResult * isMatchTel = [TelExp firstMatchInString:self options:0 range:NSMakeRange(0, [self  length])];
    //二者匹配成功一个即可
    if ( isMatchTel) {
        NSLog(@"格式正确");
        return YES;
    }
    //    NSLog(@"格式不正确");
    return NO;
}

@end
