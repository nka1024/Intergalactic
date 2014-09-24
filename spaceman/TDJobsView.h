//
//  TDJobsView.h
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStatsView.h"
#import "TDButton.h"

@interface TDJobsView : UIView

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) TDButton *submitButton;
@property (strong, nonatomic) TDStatsView *statsView;

-(void)setJobBody:(TDStringWithMarks *)text salary:(long long)salary;
-(void)setJobTitle:(NSString *)text;

-(void)setNoJobsAvailable;

@end
