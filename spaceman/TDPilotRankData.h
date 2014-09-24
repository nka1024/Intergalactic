//
//  TDPilotRank.h
//  spaceman
//
//  Created by Admin on 9/10/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDPilotRankData : NSObject

@property (strong, nonatomic) NSString *title;
@property (nonatomic) NSInteger score;

+(TDPilotRankData *) rankWithScore:(NSInteger)score
                         title:(NSString *)title;
@end
