//
//  TDCharacterData.m
//  spaceman
//
//  Created by Admin on 9/13/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDCharacterData.h"

@implementation TDCharacterData

+(TDCharacterData *)characterWithName:(NSString *)name {
    TDCharacterData *characterData = [[TDCharacterData alloc] init];
    
    characterData.name = name;
    
    return characterData;
}

@end
