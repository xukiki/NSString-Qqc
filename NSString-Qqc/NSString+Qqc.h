//
//  NSString+Qqc.h
//  QqcFramework
//
//  Created by mahailin on 15/8/7.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  不可变字符串类别
 */
@interface NSString (Qqc)

/**
 *  创建uuid
 *
 *  @return 返回uuid
 */
+ (NSString *)createUUID;

/**
 *  判断字符串是否只包含空白字符和换行符
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 *  判断是否包含汉字
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isContainChinese;

/**
 *  去除字符串中前面、后面的空白字符跟换行符
 *
 *  @return 返回去除前后空白后的字符串
 */
- (NSString *)trim;

/**
 *  去除字符串中所有的空白
 *
 *  @return 返回去除所有空白后的字符串
 */
- (NSString *)removeWhiteSpace;

/**
 *  将字符串以url格式编码
 *
 *  @return 返回编码后的字符串
 */
- (NSString *)stringByUrlEncoding;

/**
 *  将字符串进行url解码
 *
 *  @return 返回解码后的字符串
 */
- (NSString *)stringByUrlDecoding;

/**
 *  将字符串首字母处理为大写字母
 *
 *  @return 返回处理后的字符串
 */
- (NSString *)capitalize;

/**
 *  将字符串首字母处理为小写字母
 *
 *  @return 返回处理后的字符串
 */
- (NSString *)lowercaseFirstString;

/**
 *  判断字符串是否匹配
 *
 *  @param pattern 要匹配的字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)matches:(NSString *)pattern;

/**
 *  判断字符串是否匹配，不区分大小写
 *
 *  @param pattern 要匹配的字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)matchesWithCaseInsensitive:(NSString *)pattern;

/**
 *  判断是否为电话号码
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isMobileNumber;

/**
 *  判断是否为有效的Web链接
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isValidWebLink;

/**
 *  判断是否为汉字
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isValidChinese;

/**
 *  判断是否为半角
 *
 *  @return 是-yes，否-no
 */
- (BOOL)isAllHalfWidthCharacter;

/**
 *  以给定字符串开始,忽略大小写
 *
 *  @param str 给定字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)startsWith:(NSString *)str;

/**
 *  以指定条件判断字符串是否以给定字符串开始
 *
 *  @param str            给定字符串
 *  @param compareOptions 指定条件
 *
 *  @return 是-yes，否-no
 */
- (BOOL)startsWith:(NSString *)str Options:(NSStringCompareOptions) compareOptions;

/**
 *  以给定字符串结束，忽略大小写
 *
 *  @param str 给定字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)endsWith:(NSString *)str;

/**
 *  以指定条件判断字符串是否以给定字符串结尾
 *
 *  @param str            给定字符串
 *  @param compareOptions 指定条件
 *
 *  @return 是-yes，否-no
 */
- (BOOL)endsWith:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

/**
 *  包含给定的字符串, 忽略大小写
 *
 *  @param str 给定字符串
 *
 *  @return 是-yes，否-no
 */
- (BOOL)containsString:(NSString *)str;

/**
 *  以指定条件判断是否包含给定的字符串
 *
 *  @param str            给定字符串
 *  @param compareOptions 指定条件
 *
 *  @return 是-yes，否-no
 */
- (BOOL)containsString:(NSString *)str Options:(NSStringCompareOptions)compareOptions;

/**
 *  电话号码处理，比如18612341234 -> 186****1234
 *
 *  @return 返回处理后的电话号码
 */
- (NSString *)mobileMask;

/**
 *  过滤掉字符串中指定的字符
 *
 *  @param charArray 要过滤掉的字符数组
 *
 *  @return 返回过滤后的字符串
 */
- (NSString *)filterString:(NSArray *)charArray;

/**
 *  转换为NSDate类型
 *
 *  @param format 日期格式
 *
 *  @return 返回NSDate实例
 */
- (NSDate *)convertToDateWithFormat:(NSString *)format;

/**
 *  将base64字符串转换为一般的字符串
 *
 *  @param base64 base64字符串
 *
 *  @return 返回转化后的字符串
 */
+ (NSString *)textFromBase64String:(NSString *)base64;

/**
 *  将一般的字符串转化为base64字符串
 *
 *  @param text 一般的字符串
 *
 *  @return 转化后的base64字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text;

/**
 *  获取字符串对应的md5
 *
 *  @return 字符串对应的md5
 */
- (NSString *)md5HexDigest;

/**
 *  根据字体及限制的最大显示区域，计算当前字符串显示的区域
 *
 *  @param font    字体
 *  @param maxSize 最大显示范围
 *
 *  @return 当前字符串显示的区域
 */
- (CGRect)constrainedWithFont:(UIFont*)font maxSize:(CGSize)maxSize;

/**
 *  获取手机加密格式的字符串（137****7625）
 *
 *  @return 加密格式的手机号码
 */
- (NSString*)encryptionMobile;

@end
