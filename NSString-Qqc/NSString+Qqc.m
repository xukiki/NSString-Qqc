//
//  NSString+Qqc.m
//  QqcFramework
//
//  Created by mahailin on 15/8/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "NSString+Qqc.h"

@implementation NSString (Qqc)

/**
 *  创建uuid
 *
 *  @return 返回uuid
 */
+ (NSString *)createUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge_transfer NSString *)string;
}

/**
 *  判断字符串是否只包含空白字符和换行符
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isWhitespaceAndNewlines
{
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    for (NSInteger i = 0; i < self.length; ++i)
    {
        unichar c = [self characterAtIndex:i];
        
        if (![whitespace characterIsMember:c])
        {
            return NO;
        }
    }
    
    return YES;
}

/**
 *  判断是否包含汉字
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isContainChinese
{
    if (!self || self.length == 0)
    {
        return NO;
    }
    
    for (NSUInteger i = 0, j = self.length; i < j; i++)
    {
        unichar c = [self characterAtIndex:i];
        
        if (c >= 19968 && c <= 40869)
        {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  去除字符串中前面、后面的空白字符跟换行符
 *
 *  @return 返回去除前后空白后的字符串
 */
- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  去除字符串中所有的空白
 *
 *  @return 返回去除所有空白后的字符串
 */
- (NSString *)removeWhiteSpace
{
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
            componentsJoinedByString:@""];
}

/**
 *  将字符串以url格式编码
 *
 *  @return 返回编码后的字符串
 */
- (NSString *)stringByUrlEncoding
{
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8);
}

/**
 *  将字符串进行url解码
 *
 *  @return 返回解码后的字符串
 */
- (NSString *)stringByUrlDecoding
{
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

/**
 *  将字符串首字母处理为大写字母
 *
 *  @return 返回处理后的字符串
 */
- (NSString *)capitalize
{
    if (!self || [self length] == 0 || islower([self characterAtIndex:0]) == 0)
    {
        return self;
    }
    
    return [[self substringToIndex:1].uppercaseString stringByAppendingString:[self substringFromIndex:1]];
}

/**
 *  将字符串首字母处理为小写字母
 *
 *  @return 返回处理后的字符串
 */
- (NSString *)lowercaseFirstString
{
    if (!self || [self length] == 0 || isupper([self characterAtIndex:0]) == 0)
    {
        return self;
    }
    
    return [[self substringToIndex:1].lowercaseString stringByAppendingString:[self substringFromIndex:1]];
}

/**
 *  判断字符串是否匹配
 *
 *  @param pattern 要匹配的字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)matches:(NSString *)pattern
{
    return [self rangeOfString:pattern options:NSRegularExpressionSearch].location != NSNotFound;
}

/**
 *  判断字符串是否匹配，不区分大小写
 *
 *  @param pattern 要匹配的字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)matchesWithCaseInsensitive:(NSString *)pattern
{
    return [self rangeOfString:pattern
                       options:NSRegularExpressionSearch | NSCaseInsensitiveSearch].location != NSNotFound;
}

/**
 *  判断是否为电话号码
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isMobileNumber
{
    return [self matches:@"^1[0-9]{10}$"];
}

- (BOOL)isValidWebLink
{
    BOOL bIsWebLink = NO;
    NSError *error;
    NSTextCheckingResult *firstMatch;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^http[s]?:\\/\\/([\\w-]+\\.)+[\\w-]+([\\w-./?%&=]*)?" options:0 error:&error];
    if (regex != nil)
    {
        firstMatch = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        
        if (firstMatch)
        {
            bIsWebLink = YES;
        }
    }
    return bIsWebLink;
}

/**
 *  判断是否为汉字
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isValidChinese
{
    return [self matches:@"^[\\u4e00-\\u9fa5]{1,6}$"];
}

/**
 *  判断是否为半角
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isAllHalfWidthCharacter
{
    NSUInteger nsStringlen = [self length];
    const char *utf8 = [self UTF8String];
    size_t cStringlen = strlen(utf8);
    
    BOOL isHalf = NO;
    
    if (nsStringlen == cStringlen)
    {
        isHalf = YES;
    }
    
    return isHalf;
}

/**
 *  以给定字符串开始,忽略大小写
 *
 *  @param str 给定字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)startsWith:(NSString *)str
{
    return [self startsWith:str Options:NSCaseInsensitiveSearch];
}

/**
 *  以指定条件判断字符串是否以给定字符串开始
 *
 *  @param str            给定字符串
 *  @param compareOptions 制定条件
 *
 *  @return 是-yes，否-no
 */
- (BOOL)startsWith:(NSString *)str Options:(NSStringCompareOptions) compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:compareOptions].location == 0);
}

/**
 *  以给定字符串结束，忽略大小写
 *
 *  @param str 给定字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)endsWith:(NSString *)str
{
    return [self endsWith:str Options:NSCaseInsensitiveSearch];
}

/**
 *  以指定条件判断字符串是否以给定字符串结尾
 *
 *  @param str            给定字符串
 *  @param compareOptions 指定条件
 *
 *  @return 是-yes，否-no
 */
- (BOOL)endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str
                    options:(compareOptions | NSBackwardsSearch)].location == ([self length] - [str length]));
}

/**
 *  包含给定的字符串, 忽略大小写
 *
 *  @param str 给定字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)containsString:(NSString *)str
{
    return [self containsString:str Options:NSCaseInsensitiveSearch];
}

/**
 *  以指定条件判断是否包含给定的字符串
 *
 *  @param str            给定字符串
 *  @param compareOptions 指定条件
 *
 *  @return 是-yes，否-no
 */
- (BOOL)containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions
{
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:compareOptions].location != NSNotFound);
}

/**
 *  电话号码处理，比如18612341234 -> 186****1234
 *
 *  @return 返回处理后的电话号码
 */
- (NSString *)mobileMask
{
    if (![self isMobileNumber])
    {
        return self;
    }
    
    return [NSString stringWithFormat:@"%@****%@", [self substringToIndex:3], [self substringFromIndex:7]];
}

/**
 *  过滤掉字符串中指定的字符
 *
 *  @param charArray 要过滤掉的字符数组
 *
 *  @return 返回过滤后的字符串
 */
- (NSString *)filterString:(NSArray *)charArray
{
    if (!self || self.length == 0)
    {
        return @"";
    }
    
    NSString *resString = self;
    
    for (int i=0; i<[charArray count]; i++)
    {
        NSString *tempString = [charArray objectAtIndex:i];
        resString = [resString stringByReplacingOccurrencesOfString:tempString withString:@""];
    }
    
    return resString;
}

/**
 *  转换为NSDate类型
 *
 *  @param format 日期格式
 *
 *  @return 返回NSDate实例
 */
- (NSDate *)convertToDateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale  = [NSLocale currentLocale];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:self];
    return date;
}

/**
 *  将base64字符串转换为一般的字符串
 *
 *  @param base64 base64字符串
 *
 *  @return 返回转化后的字符串
 */
+ (NSString *)textFromBase64String:(NSString *)base64
{
    return @"";
}

/**
 *  将一般的字符串转化为base64字符串
 *
 *  @param text 一般的字符串
 *
 *  @return 转化后的base64字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text
{
    return @"";
}

/**
 *  获取字符串对应的md5
 *
 *  @return 字符串对应的md5
 */
- (NSString*)md5HexDigest
{
    return @"";
}

- (CGRect)constrainedWithFont:(UIFont*)font maxSize:(CGSize)maxSize
{
    NSDictionary *textAttrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:textAttrs
                                            context:nil];
}

/**
 *  获取手机加密格式的字符串（137****7625）
 *
 *  @return 加密格式的手机号码
 */
- (NSString*)encryptionMobile
{
    NSRange rang = NSMakeRange(3, 4);
    return [self stringByReplacingCharactersInRange:rang withString:@"****"];
}

@end
