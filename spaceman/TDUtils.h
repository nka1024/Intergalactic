//
//  TDUtils.h
//  spaceman
//
//  Created by Admin on 8/18/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef __TDUTILS_H
#define __TDUTILS_H

#define TD_DEBUG false

#define GAME_UPDATE_NOTIFICATION        @"gameUpdateNotification"
#define GAME_DAY_CHANGED_NOTIFICATION   @"gameDayChangedNotification"
#define GAME_MONTH_CHANGED_NOTIFICATION @"gameMonthChangedNotification"
#define GAME_GAMEOVER_NOTIFICATION      @"gameGameOverNotification"

#define JPY 100

#define CHEATER_PILOTNAME @"iamveryspecial"


#define UPGRADE_HULL_IDX    @0
#define UPGRADE_ENGINE_IDX  @1
#define UPGRADE_REACTOR_IDX @2
#define UPGRADE_RADAR_IDX   @3
#define UPGRADE_SHIELD_IDX  @4
#define UPGRADE_WEAPON_IDX  @5

#define CHARACTER_MINING_DROID  @0
#define CHARACTER_REPAIR_DROID  @1
#define CHARACTER_ASSAULTER     @2
#define CHARACTER_HACKER        @3
#define CHARACTER_VIPER         @4
//#define CHARACTER_NAVIGATOR     @4
//#define CHARACTER_MEDIC         @6

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif
@interface TDUtils : NSObject

+(void) addVFLConstraintToView:(UIView*)view
                      subviews:(NSDictionary*)subviews
                        format:(NSString*)format;

+(void) addVFLConstraintToView:(UIView*)view
                      subviews:(NSDictionary*)subviews
                        format:(NSString*)format
                       metrics:(NSDictionary*)metrics;

+(BOOL)isSmallScreen;
+(BOOL)trueWithChance:(float)chance;

+(UIFont *) giantFont;
+(UIFont *) largeFont;
+(UIFont *) mediumFont;
+(UIFont *) smallFont;
+(UIFont *) tinyFont;

+(UIColor *) whiteColor;
+(UIColor *) blueColor;
+(UIColor *) redColor;
+(UIColor *) blackColor;
+(UIColor *) greyColor;
+(UIColor *) darkGreyColor;
+(UIColor *) darkBlueColor;

+(NSString *)formatedNumber:(long long) integer;

+(void) showStandartAlertTitle:(NSString *)title
                       message:(NSString *)message
                      delegate:(id)delegate;

@end
