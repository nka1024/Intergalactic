//
//  TDContractsView.h
//  spaceman
//
//  Created by Admin on 9/5/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStatsView.h"
#import "TDButton.h"

@interface TDContractsView : UIView

@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) TDButton *refreshButton;
@property (strong, nonatomic) TDButton *submitButton;

@property (strong, nonatomic) TDStatsView *statsView;

-(void)popuplateWithContractTitle:(NSString *)title
                             info:(TDStringWithMarks *)info
                           reward:(long long)reward;

-(void)popuplateWithNoContractText:(TDStringWithMarks *)text;

@end
