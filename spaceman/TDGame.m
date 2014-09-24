//
//  TDGame.m
//  spaceman
//
//  Created by Admin on 9/8/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDGame.h"
@interface TDGame ()

@property (strong, nonatomic) NSDateFormatter *dayFormatter;
@property (strong, nonatomic) NSDateFormatter *monthFormatter;

@property (strong, nonatomic) NSString *currentDay;
@property (strong, nonatomic) NSString *currentMonth;

@property (nonatomic) double _charge;
@property (nonatomic) double _health;

@property (nonatomic) BOOL _suspended;

@property (nonatomic) NSInteger lastInfoIdx;
@end

@implementation TDGame

-(instancetype)initLoadedGame {
    TDDataStorage *dataStorage = [TDDataStorage sharedInstance];
    
    self = [self initNewGameWithPilotName:dataStorage.pilotName];

    if (self) {
        
        self.firstDay = false;
        
        self.playerMoney = dataStorage.playerMoney;
        self.timestamp = dataStorage.timestamp;
        self.score = dataStorage.score;
        
        self.lastUnlockedCharacter = [NSNumber numberWithInteger:dataStorage.lastUnlockedCharacter];
        self.lifeExplorationIdx = dataStorage.lifeExplorationIdx;
        self.playerJobIdx = dataStorage.playerJobIdx;
        
        self._charge = dataStorage.charge;
        self._health = dataStorage.health;
    
        [self.playerUpgrades setObject:[NSNumber numberWithInteger:dataStorage.hullUpgradeIdx] forKey:UPGRADE_HULL_IDX];
        [self.playerUpgrades setObject:[NSNumber numberWithInteger:dataStorage.engineUpgradeIdx] forKey:UPGRADE_ENGINE_IDX];
        [self.playerUpgrades setObject:[NSNumber numberWithInteger:dataStorage.reactorUpgradeIdx] forKey:UPGRADE_REACTOR_IDX];
        [self.playerUpgrades setObject:[NSNumber numberWithInteger:dataStorage.radarUpgradeIdx] forKey:UPGRADE_RADAR_IDX];
        [self.playerUpgrades setObject:[NSNumber numberWithInteger:dataStorage.shieldUpgradeIdx] forKey:UPGRADE_SHIELD_IDX];
        [self.playerUpgrades setObject:[NSNumber numberWithInteger:dataStorage.weaponUpgradeIdx] forKey:UPGRADE_WEAPON_IDX];
        
        [self saveGameData];
    }
    return self;
}
-(instancetype)initNewGameWithPilotName:(NSString *)pilotName {
    self = [super init];
    if (self) {
        
        self.timestamp = 7731417600; // 00:00 2215 jan 1

        self.pilotName = pilotName;
        self.playerMoney = 2000 * JPY;
        self.playerJobIdx = 0;
        self.score = 0;
        self._charge = 1;
        self._health = 1;
        self.lastInfoIdx = 0;
        self.won = false;
        
        self.lastUnlockedCharacter = CHARACTER_MINING_DROID;
        
        self.lifeExplorationIdx = 0;
        
        self.firstDay = !TD_DEBUG; // TODO: debug purposes
        
        self.playerUpgrades = [[NSMutableDictionary alloc] initWithDictionary:@{UPGRADE_HULL_IDX:   @0,
                                                                               UPGRADE_ENGINE_IDX:  @0,
                                                                               UPGRADE_REACTOR_IDX: @0,
                                                                               UPGRADE_RADAR_IDX:   @0,
                                                                               UPGRADE_SHIELD_IDX:  @0,
                                                                               UPGRADE_WEAPON_IDX:  @0}];
        
        
        NSTimeInterval inteval = [[self.pilotName lowercaseString] isEqualToString:CHEATER_PILOTNAME] ? 0.1 : 0.82;
        
        self.gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval: inteval
                                                              target: self
                                                            selector: @selector(gameTick)
                                                            userInfo: nil
                                                             repeats: YES];

        self.dayFormatter = [[NSDateFormatter alloc] init];
        
        [self.dayFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
        [self.dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [self.dayFormatter setDateFormat:@"dd"];
        
        self.monthFormatter = [[NSDateFormatter alloc] init];
        
        [self.monthFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
        [self.monthFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        [self.monthFormatter setDateFormat:@"MM"];
        
        self.currentDay = [self getCurrentDayString];
        self.currentMonth = [self getCurrentDayString];
    
    }
    return self;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Information

-(TDInformationData *)randomInformationData {
    
    TDInformationData *result = nil;
    if (self.lastInfoIdx >= [TDData sharedInstance].information.count) {
        self.lastInfoIdx = 0;
    }
    result = [[TDData sharedInstance].information objectAtIndex:self.lastInfoIdx];
    
    self.lastInfoIdx++;
    return result;

}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark General game logic

-(void) gameTick {
    
    if(!self._suspended) {
        
        if (!self.won) {
            self.timestamp += 3600;
            
            if (self._charge < 100) {
                self._charge += 1;
            }
            
            if ([self getUpgradeTier:UPGRADE_HULL_IDX] > 0) {
                if ([TDUtils trueWithChance:0.05]) {
                    [self decreaseHealthByPercent:0.01];
                }
            }
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:GAME_UPDATE_NOTIFICATION object:self];
        
        NSString *day = [self getCurrentDayString];
        if (![day isEqualToString:self.currentDay]) {
            
            self.playerMoney += self.playerJob.salary;
            self.currentDay = day;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:GAME_DAY_CHANGED_NOTIFICATION object:self];
            
            [self saveGameData];
        }
    }
}

-(void)saveGameData {
    TDDataStorage *dataStorage = [TDDataStorage sharedInstance];
    
    dataStorage.playerMoney = self.playerMoney;
    dataStorage.timestamp = self.timestamp;
    dataStorage.pilotName = self.pilotName;
    
    dataStorage.score = self.score;
    
    dataStorage.lastUnlockedCharacter = self.lastUnlockedCharacter.integerValue;
    dataStorage.lifeExplorationIdx = self.lifeExplorationIdx;
    dataStorage.playerJobIdx = self.playerJobIdx;
    
    dataStorage.charge = self._charge;
    dataStorage.health = self._health;
    
    dataStorage.hullUpgradeIdx = ((NSNumber*)[self.playerUpgrades objectForKey:UPGRADE_HULL_IDX]).integerValue;
    dataStorage.engineUpgradeIdx = ((NSNumber*)[self.playerUpgrades objectForKey:UPGRADE_ENGINE_IDX]).integerValue;
    dataStorage.reactorUpgradeIdx = ((NSNumber*)[self.playerUpgrades objectForKey:UPGRADE_REACTOR_IDX]).integerValue;
    dataStorage.radarUpgradeIdx = ((NSNumber*)[self.playerUpgrades objectForKey:UPGRADE_RADAR_IDX]).integerValue;
    dataStorage.shieldUpgradeIdx = ((NSNumber*)[self.playerUpgrades objectForKey:UPGRADE_SHIELD_IDX]).integerValue;
    dataStorage.weaponUpgradeIdx = ((NSNumber*)[self.playerUpgrades objectForKey:UPGRADE_WEAPON_IDX]).integerValue;
    
    [dataStorage save];
}

-(void)suspendGameLoop {
    self._suspended = YES;
}

-(void)resumeGameLoop {
    self._suspended = NO;
}

-(void)endGame {
    [self suspendGameLoop];
    [[TDDataStorage sharedInstance] reset];
    [[TDDataStorage sharedInstance] save];
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Pilot ranks

-(NSInteger)pilotRankIdx {
    NSInteger idx = 0;
    
    for (TDPilotRankData *rank in [TDData sharedInstance].pilotRanks) {
        if (self.score < rank.score) {
            break;
        }
        idx++;
    }
    
    return idx;
}

-(TDPilotRankData *)pilotRank {
    TDPilotRankData *playerRank;
    
    for (TDPilotRankData *rank in [TDData sharedInstance].pilotRanks) {
        if (self.score < rank.score) {
            break;
        }
        playerRank = rank;
    }
    
    return playerRank;
}

-(TDPilotRankData *)nextPilotRank {
    TDPilotRankData *nextPilotRank;
    
    for (TDPilotRankData *rank in [TDData sharedInstance].pilotRanks) {
        nextPilotRank = rank;
        if (self.score < rank.score) {
            break;
        }
    }
    
    return nextPilotRank;
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Characters

-(BOOL)isCharacterUnlocked:(NSNumber *)characterIdx {
    return characterIdx.intValue <= self.lastUnlockedCharacter.intValue;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Charge

-(NSInteger)charge {
    
    NSInteger charge = self._charge;
    
    if (charge < 0)     charge = 0;
    if (charge > 100)   charge = 100;
    
    return charge;
}

-(void)resetCharge {
    self._charge = 0;
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Health

-(NSInteger)health {
    
    NSInteger health = self._health * 100;
    
    if (health < 0)     health = 0;
    if (health > 100)   health = 100;
    
    return health;
}

-(void)decreaseHealthByPercent:(double)percent {
    self._health -= percent;
    
    if (self._health <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GAME_GAMEOVER_NOTIFICATION object:self];
    }
}

-(void)restoreHealth {
    self._health = 1;
}

-(void)restoreHalfHealth {
    if (self._health < 0.5) {
        self._health = 0.5;
    }
}

-(long long)repairPrice {
    return (1 - self._health) * 100 * JPY * 150;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Jobs

-(TDJobData *) playerJob {
    return [[TDData sharedInstance].jobs objectAtIndex:self.playerJobIdx];
}

-(TDJobData *) getAvailableJob {
    
    TDJobData *availableJob = nil;
    
    if (self.playerJobIdx < [[TDData sharedInstance].jobs count] - 1) {
        availableJob = [[TDData sharedInstance].jobs objectAtIndex:self.playerJobIdx + 1];
        
        if (availableJob.rank > self.pilotRankIdx) {
            availableJob = nil;
        }
    }
    
    return availableJob;
}

-(void) applyNextJob {
    if ([self getAvailableJob]) {
        self.playerJobIdx++;
    }
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark System upgrades


-(TDUpgradeData *) getUpgrade:(NSNumber *)system {
    
    NSArray *upgrades = [[TDData sharedInstance].upgrades objectForKey:system];
    NSNumber *idx = [self.playerUpgrades objectForKey:system];
    
    if (upgrades.count <= idx.integerValue) {
        return nil;
    }
    return [upgrades objectAtIndex:idx.integerValue];
}

-(TDUpgradeData *) getAvailableUpgrade:(NSNumber *)system {
    
    NSArray *upgrades = [[TDData sharedInstance].upgrades objectForKey:system];
    NSNumber *idx = [self.playerUpgrades objectForKey:system];
    NSInteger nextIdx = (idx.integerValue + 1);
    
    if (upgrades.count <= nextIdx) {
        return nil;
    }
    return [upgrades objectAtIndex:nextIdx];
}

-(NSInteger) getUpgradeTier:(NSNumber *)system {
    return [[self.playerUpgrades objectForKey:system] integerValue];
}

-(BOOL)canBuyUpgrade:(NSNumber *)system {
    TDUpgradeData *availableUpgrade = [self getAvailableUpgrade:system];

    return availableUpgrade.price <= self.playerMoney;
}

-(void) applyNextUpgrade:(NSNumber *)system {
    TDUpgradeData *availableUpgrade = [self getAvailableUpgrade:system];

    if (availableUpgrade && [self canBuyUpgrade:system]) {
        
        NSNumber *idx = [self.playerUpgrades objectForKey:system];
        NSNumber *nextIdx = [NSNumber numberWithInteger:([idx integerValue] + 1)];
        
        self.playerMoney -= availableUpgrade.price;
        self.score += 2*(idx.integerValue + 1);
        
        [self.playerUpgrades setObject:nextIdx forKey:system];
    }
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Story

-(TDExplorationResult*)nextLifeExploration {
    
    NSArray *sequence = [TDData sharedInstance].lifeExplorationSequence;
    
    TDExplorationResult *result;
    if (self.lifeExplorationIdx < sequence.count) {
        result = [sequence objectAtIndex:self.lifeExplorationIdx];
        
        if ([self getUpgradeTier:UPGRADE_ENGINE_IDX] < result.requirement) {
            result = [TDData sharedInstance].resultUnreachable;
        } else {
            self.lifeExplorationIdx++;
            
            if (result.unlockCharacter) {
                self.lastUnlockedCharacter = [NSNumber numberWithInteger:result.unlockCharacter.integerValue];
            }
        }
    } else {
        result = [TDData sharedInstance].resultUnreachable;
    }
    
    return result;
}

-(TDExplorationResult*)nextResourceExploration {
    
    TDExplorationResult *result;
    
    long long reward;
    
    if ([TDUtils trueWithChance:0.8]) {
        NSNumber *priceTier = [[TDData sharedInstance].priceTiers objectAtIndex:self.pilotRankIdx];
        float k = (1 - 0.3 * ((arc4random()%100)/100.0)); // 0.8 - 1.0
        
        reward = priceTier.integerValue * k * JPY * 20/4;
        
        result = [TDExplorationResult explorationResultWithTitle:NSLocalizedString(@"game_exploreResultSuccessTitle", nil)
                                                            text:[NSString stringWithFormat:NSLocalizedString(@"game_exploreResultSuccessMessage", nil), [TDUtils formatedNumber:reward]]
                                                     requirement:0
                                                          reward:reward
                                                 unlockCharacter:nil
                                                           story:nil];
        
    } else {
        result = [TDExplorationResult explorationResultWithTitle:NSLocalizedString(@"game_exploreResultFailTitle", nil)
                                                            text:NSLocalizedString(@"game_exploreResultFailMessage", nil)
                                                     requirement:0
                                                          reward:0
                                                 unlockCharacter:nil
                                                           story:nil];
    }
    return result;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Contracts

-(TDContractData *)randomContract {
    
    TDContractType type;
    if (self.pilotRankIdx < 4) {
        type = TDContractTypeMining;
    } else {
        type = [TDUtils trueWithChance:0.3] ? TDContractTypeMining : TDContractTypeTrade;
    }
    
    TDContractData *contract = [[TDContractData alloc] init];
    
    contract.type = type;
    contract.level = self.pilotRankIdx + arc4random() % 4 - 1;
    
    NSInteger MIN_TIER = 0;
    NSInteger MAX_TIER = [[TDData sharedInstance].pilotRanks count] - 1;

    if (contract.level < MIN_TIER) contract.level = MIN_TIER;
    if (contract.level > MAX_TIER) contract.level = MAX_TIER;
    
    NSInteger overhead;
    if (type == TDContractTypeMining) {
        overhead = contract.level - [self getUpgradeTier:UPGRADE_SHIELD_IDX];
    } else {
        overhead = contract.level - [self getUpgradeTier:UPGRADE_WEAPON_IDX];
    }
    
    if (overhead > 0) {
 
        NSNumber *priceTier = [[TDData sharedInstance].priceTiers objectAtIndex:self.pilotRankIdx];
        float k = (1 + 0.3 * ((arc4random()%100)/100.0)) + overhead/6.0; // 0.8 - 1.0
        
        contract.reward = priceTier.integerValue * k * JPY * 22;
    } else {
        NSNumber *priceTier = [[TDData sharedInstance].priceTiers objectAtIndex:self.pilotRankIdx];
        float k = (1 + 0.1 * ((arc4random()%100)/100.0)); // 0.8 - 1.0
        
        contract.reward = priceTier.integerValue * k * JPY * 22;
    }
    
    
    
    if (type == TDContractTypeMining) {
        NSInteger itemIdx = arc4random()%[TDData sharedInstance].resources.count;
        contract.subject = [[TDData sharedInstance].resources objectAtIndex:itemIdx];
    } else {
        
        NSInteger itemIdx = arc4random()%[TDData sharedInstance].wares.count;
        contract.subject = [[TDData sharedInstance].wares objectAtIndex:itemIdx];
    }
    
    return contract;
}

-(long long)searchFee {
    NSNumber *price = [[TDData sharedInstance].priceTiers objectAtIndex:self.pilotRankIdx];
    return price.longLongValue * JPY * 20;
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(NSString *) getCurrentDayString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timestamp];
    return [self.dayFormatter stringFromDate:date];
}

-(NSString *) getCurrentMonthString {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.timestamp];
    return [self.dayFormatter stringFromDate:date];
}
@end
