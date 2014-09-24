//
//  TDGame.h
//  spaceman
//
//  Created by Admin on 9/8/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDUtils.h"
#import "TDData.h"
#import "TDContractData.h"
#import "TDDataStorage.h"

@interface TDGame : NSObject

@property (nonatomic) BOOL firstDay;
@property (nonatomic) BOOL won;

@property (nonatomic) NSTimer *gameLoopTimer;
@property (nonatomic) NSTimeInterval timestamp;

@property (nonatomic, strong) NSString *pilotName;
@property (nonatomic) long long playerMoney;
@property (nonatomic) NSInteger playerJobIdx;

@property (nonatomic) NSNumber *lastUnlockedCharacter;

@property (nonatomic) NSInteger lifeExplorationIdx;

@property (strong, nonatomic) NSMutableDictionary *playerUpgrades;

@property (nonatomic) long long score;

-(instancetype)initLoadedGame;
-(instancetype)initNewGameWithPilotName:(NSString *)pilotName;

-(void)suspendGameLoop;
-(void)resumeGameLoop;
-(void)endGame;

-(TDInformationData *)randomInformationData;

-(TDExplorationResult*)nextLifeExploration;
-(TDExplorationResult*)nextResourceExploration;

-(NSInteger)pilotRankIdx;
-(TDPilotRankData *)pilotRank;
-(TDPilotRankData *)nextPilotRank;
    
-(NSInteger)charge;
-(void)resetCharge;

-(NSInteger)health;
-(void)decreaseHealthByPercent:(double)percent;
-(void)restoreHealth;
-(void)restoreHalfHealth;
-(long long)repairPrice;

-(TDJobData *) playerJob;
-(TDJobData *) getAvailableJob;
-(void) applyNextJob;

-(TDUpgradeData *) getUpgrade:(NSNumber *)system;
-(TDUpgradeData *) getAvailableUpgrade:(NSNumber *)system;
-(NSInteger) getUpgradeTier:(NSNumber *)system;
-(BOOL) canBuyUpgrade:(NSNumber *)system;
-(void) applyNextUpgrade:(NSNumber *)system;

-(TDContractData *)randomContract;
-(long long)searchFee;

-(BOOL) isCharacterUnlocked:(NSNumber *)characterIdx;

@end
