//
//  TDPilotRank.m
//  spaceman
//
//  Created by Admin on 9/10/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDPilotRankData.h"

@implementation TDPilotRankData


+(TDPilotRankData *)rankWithScore:(NSInteger)score
                        title:(NSString *)title {
    
    TDPilotRankData *pilotRank = [[TDPilotRankData alloc] init];
    
    pilotRank.title = title;
    pilotRank.score = score;
    
    return pilotRank;
}
@end
