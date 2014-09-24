//
//  TDHangarView.h
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStatsView.h"
#import "TDButton.h"


@interface TDHangarView : UIView

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) TDButton *repairButton;
@property (strong, nonatomic) TDButton *droidsButton;
@property (strong, nonatomic) UILabel *repairLabel;
@property (strong, nonatomic) TDStatsView *statsView;

@property (strong, nonatomic) UILabel *scoreLabel;
@property (strong, nonatomic) UILabel *nextScoreLabel;
@property (strong, nonatomic) UILabel *hpLabel;
@property (strong, nonatomic) UIImageView *image;

-(void)populate:(TDGame *)game;
@end
