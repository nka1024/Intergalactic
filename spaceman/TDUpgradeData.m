//
//  TDUpgrade.m
//  spaceman
//
//  Created by Admin on 9/9/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDUpgradeData.h"

@implementation TDUpgradeData

+(TDUpgradeData *)upgradeWithName:(NSString *)name
                            price:(long long)price
                            score:(NSInteger)score {
    
    TDUpgradeData *upgrade = [[TDUpgradeData alloc] init];
    
    upgrade.name = name;
    upgrade.price = price;
    upgrade.score = score;
    
    return upgrade;
}
@end
