//
//  TDDataStorage.m
//  spaceman
//
//  Created by Admin on 9/14/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDDataStorage.h"

@implementation TDDataStorage

static NSString* const KEY_PLAYER_MONEY = @"playerMoney";
static NSString* const KEY_TIMESTAMP = @"timestamp";
static NSString* const KEY_PILOT_NAME = @"pilotName";

static NSString* const KEY_HEALTH = @"health";
static NSString* const KEY_CHARGE = @"charge";
static NSString* const KEY_SCORE = @"score";
static NSString* const KEY_PLAYER_JOB_IDX = @"playerJobIdx";
static NSString* const KEY_LAST_UNLOCKED_CHARACTER = @"lastUnlockedCharacter";
static NSString* const KEY_LIFE_EXPLORATION_IDX = @"lifeExplorationIdx";
static NSString* const KEY_HULL_UPGRADE_IDX = @"hullUpgradeIdx";
static NSString* const KEY_ENGINE_UPGRADE_IDX = @"engineUpgradeIdx";
static NSString* const KEY_REACTOR_UPGRADE_IDX = @"reactorUpgradeIdx";
static NSString* const KEY_RADAR_UPGRADE_IDX = @"radarUpgradeIdx";
static NSString* const KEY_SHIELD_UPGRADE_IDX = @"shieldUpgradeIdx";
static NSString* const KEY_WEAPON_UPGRADE_IDX = @"weaponUpgradeIdx";

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self reset];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

-(void)reset {
    self.timestamp = 0;
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSCoding protocol

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt64:self.playerMoney forKey: KEY_PLAYER_MONEY];
    [encoder encodeInt64:self.timestamp forKey: KEY_TIMESTAMP];
    [encoder encodeObject:self.pilotName forKey:KEY_PILOT_NAME];
    
    [encoder encodeDouble:self.health forKey: KEY_HEALTH];
    [encoder encodeDouble:self.charge forKey: KEY_CHARGE];
    [encoder encodeInt64:self.score forKey: KEY_SCORE];
    [encoder encodeInteger:self.playerJobIdx forKey: KEY_PLAYER_JOB_IDX];
    [encoder encodeInteger:self.lastUnlockedCharacter forKey: KEY_LAST_UNLOCKED_CHARACTER];
    [encoder encodeInteger:self.lifeExplorationIdx forKey: KEY_LIFE_EXPLORATION_IDX];
    [encoder encodeInteger:self.hullUpgradeIdx forKey: KEY_HULL_UPGRADE_IDX];
    [encoder encodeInteger:self.engineUpgradeIdx forKey: KEY_ENGINE_UPGRADE_IDX];
    [encoder encodeInteger:self.reactorUpgradeIdx forKey: KEY_REACTOR_UPGRADE_IDX];
    [encoder encodeInteger:self.radarUpgradeIdx forKey: KEY_RADAR_UPGRADE_IDX];
    [encoder encodeInteger:self.shieldUpgradeIdx forKey: KEY_SHIELD_UPGRADE_IDX];
    [encoder encodeInteger:self.weaponUpgradeIdx forKey: KEY_WEAPON_UPGRADE_IDX];
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (self) {
        self.playerMoney = [decoder decodeInt64ForKey: KEY_PLAYER_MONEY];
        self.timestamp = [decoder decodeInt64ForKey: KEY_TIMESTAMP];
        self.pilotName = [decoder decodeObjectForKey: KEY_PILOT_NAME];
        
        self.health = [decoder decodeDoubleForKey:KEY_HEALTH];
        self.charge= [decoder decodeDoubleForKey: KEY_CHARGE];
        self.score = [decoder decodeInt64ForKey: KEY_SCORE];
        self.playerJobIdx = [decoder decodeIntegerForKey: KEY_PLAYER_JOB_IDX];
        self.lastUnlockedCharacter = [decoder decodeIntegerForKey:  KEY_LAST_UNLOCKED_CHARACTER];
        self.lifeExplorationIdx = [decoder decodeIntegerForKey: KEY_LIFE_EXPLORATION_IDX];
        self.hullUpgradeIdx = [decoder decodeIntegerForKey: KEY_HULL_UPGRADE_IDX];
        self.engineUpgradeIdx = [decoder decodeIntegerForKey: KEY_ENGINE_UPGRADE_IDX];
        self.reactorUpgradeIdx = [decoder decodeIntegerForKey: KEY_REACTOR_UPGRADE_IDX];
        self.radarUpgradeIdx = [decoder decodeIntegerForKey: KEY_RADAR_UPGRADE_IDX];
        self.shieldUpgradeIdx = [decoder decodeIntegerForKey: KEY_SHIELD_UPGRADE_IDX];
        self.weaponUpgradeIdx = [decoder decodeIntegerForKey: KEY_WEAPON_UPGRADE_IDX];
    }
    return self;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Filesystem

+(instancetype)loadInstance {
    NSData* decodedData = [NSData dataWithContentsOfFile: [TDDataStorage filePath]];
    if (decodedData) {
        TDDataStorage* dataStorage = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        
        if (dataStorage) {
            return dataStorage;
        }
    }
    return [[TDDataStorage alloc] init];
}

-(void)save {
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[TDDataStorage filePath] atomically:YES];
}

+(NSString*)filePath {
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:@"gamedata"];
    }
    return filePath;
}

+(BOOL)gameDataFileExists {
    return [NSData dataWithContentsOfFile: [TDDataStorage filePath]] ? YES : NO;
}
@end
