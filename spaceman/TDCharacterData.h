//
//  TDCharacterData.h
//  spaceman
//
//  Created by Admin on 9/13/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDCharacterData : NSObject

@property (strong, nonatomic) NSString *name;

+(TDCharacterData *) characterWithName:(NSString *)name;

@end
