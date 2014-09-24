//
//  TDUtils.m
//  spaceman
//
//  Created by Admin on 8/18/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDUtils.h"

@implementation TDUtils


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Constraints

+(void) addVFLConstraintToView:(UIView *)view
                      subviews:(NSDictionary *)subviews
                        format:(NSString *)format {
    
    [TDUtils addVFLConstraintToView:view subviews:subviews format:format metrics:nil];
}


+(void) addVFLConstraintToView:(UIView *)view
                      subviews:(NSDictionary *)subviews
                        format:(NSString *)format
                       metrics:(NSDictionary *)metrics{
    
    [view addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:format
                          options:0
                          metrics:metrics
                          views:subviews]];
}

+(BOOL)isSmallScreen {
    return [UIScreen mainScreen].bounds.size.height < 540.0;
}

+(BOOL)trueWithChance:(float)chance {
    return (arc4random()%100)/100.0f <= chance;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Fonts

+(UIFont *)giantFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:48];
}

+(UIFont *)largeFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:24];
}

+(UIFont *)mediumFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
}

+(UIFont *)smallFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
}

+(UIFont *)tinyFont {
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Colors

+(UIColor *)whiteColor {
    return UIColorFromRGB(0xffffff);
}

+(UIColor *)blueColor {
    return UIColorFromRGB(0x14abd1);
}

+(UIColor *)redColor {
    return UIColorFromRGB(0xff4638);
}

+(UIColor *)blackColor {
    return UIColorFromRGB(0x000000);
}

+(UIColor *)greyColor {
    return UIColorFromRGB(0xb4b4b4);
}

+(UIColor *)darkGreyColor {
    return UIColorFromRGB(0x787878);
}

+(UIColor *)darkBlueColor {
    return UIColorFromRGB(0x1b5e6f);
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Formatting

+(NSString *)formatedNumber:(long long)number {
    
    NSNumber *numberObj = [NSNumber numberWithLongLong:number];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
    
    return [numberFormatter stringFromNumber:numberObj];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Alerts

+(void) showStandartAlertTitle:(NSString *)title
                       message:(NSString *)message
                      delegate:(id)delegate {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
}

@end
