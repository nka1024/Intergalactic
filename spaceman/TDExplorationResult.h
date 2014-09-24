//
//  TDExplorationResult.h
//  Интергалактик
//
//  Created by Admin on 9/17/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDStroyData.h"

@interface TDExplorationResult : NSObject

@property (strong, nonatomic) NSString *annotationTitle;
@property (strong, nonatomic) NSString *annotationText;
@property (nonatomic) long long reward;
@property (nonatomic) NSInteger requirement;
@property (nonatomic) TDStroyData *storyData;
@property (nonatomic) NSNumber *unlockCharacter;

+(instancetype) explorationResultWithTitle:(NSString *)annotationTitle
                                      text:(NSString *)annotationText
                               requirement:(NSInteger)requirement
                                    reward:(long long)reward
                           unlockCharacter:(NSNumber *)unlockCharacter
                                     story:(TDStroyData *) storyData;
@end
