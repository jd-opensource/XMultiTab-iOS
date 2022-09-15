//
//  UIColor+SSS.m
//  XMultiTabModule-iOS
//
//  Created by lixianke1 on 2022/8/23.
//

#import "UIColor+SSS.h"

@implementation UIColor (SSS)

+ (UIColor *)colorWithHex:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@end
