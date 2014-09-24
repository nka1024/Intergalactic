//
//  TDStatsView.h
//  spaceman
//
//  Created by Admin on 9/6/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDGame.h"

@interface TDStatsView : UIView

-(void)populate:(TDGame *)game;

@end
