//
//  TDInformationView.h
//  Интергалактик
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDUtils.h"
#import "TDStatsView.h"
#import "TDButton.h"

@interface TDInformationView : UIView

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) TDButton *submitButton;
@property (strong, nonatomic) TDStatsView *statsView;

//-(void)setJobBody:(NSString *)text salary:(NSInteger)salary;
//-(void)setJobTitle:(NSString *)text;

//-(void)setNoJobsAvailable;

-(void)populate:(TDGame *)game;
@end