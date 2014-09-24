//
//  TDDataStorage.h
//  spaceman
//
//  Created by Admin on 9/14/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDDataStorage : NSObject <NSCoding>

@property (assign, nonatomic) long long timestamp;
@property (assign, nonatomic) long long playerMoney;
@property (assign, nonatomic) long long score;
@property (assign, nonatomic) double health;
@property (assign, nonatomic) double charge;

@property (readwrite, retain) NSString *pilotName;

@property (assign, nonatomic) NSInteger playerJobIdx;
@property (assign, nonatomic) NSInteger lastUnlockedCharacter;
@property (assign, nonatomic) NSInteger lifeExplorationIdx;

@property (assign, nonatomic) NSInteger hullUpgradeIdx;
@property (assign, nonatomic) NSInteger engineUpgradeIdx;
@property (assign, nonatomic) NSInteger reactorUpgradeIdx;
@property (assign, nonatomic) NSInteger radarUpgradeIdx;
@property (assign, nonatomic) NSInteger shieldUpgradeIdx;
@property (assign, nonatomic) NSInteger weaponUpgradeIdx;

+(instancetype)sharedInstance;
-(void)reset;
-(void)save;

+(BOOL)gameDataFileExists;

@end
