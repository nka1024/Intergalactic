//
//  TDExplorationResult.m
//  Интергалактик
//
//  Created by Admin on 9/17/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDExplorationResult.h"

@implementation TDExplorationResult

+(instancetype)explorationResultWithTitle:(NSString *)annotationTitle
                                     text:(NSString *)annotationText
                              requirement:(NSInteger)requirement
                                   reward:(long long)reward
                          unlockCharacter:(NSNumber *)unlockCharacter
                                    story:(TDStroyData *)storyData {
 
    TDExplorationResult *explorationResult = [[TDExplorationResult alloc] init];
    
    explorationResult.annotationTitle = annotationTitle;
    explorationResult.annotationText = annotationText;
    explorationResult.requirement = requirement;
    explorationResult.reward = reward;
    explorationResult.unlockCharacter = unlockCharacter;
    explorationResult.storyData = storyData;
    
    return explorationResult;
}
@end
