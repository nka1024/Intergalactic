//
//  TDUpgrade.h
//  spaceman
//
//  Created by Admin on 9/9/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDUpgradeData : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) long long price;
@property (nonatomic) NSInteger score;

+(TDUpgradeData *)upgradeWithName:(NSString *)name
                            price:(long long)price
                            score:(NSInteger)score;
@end
