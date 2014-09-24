//
//  TDExploreView.h
//  spaceman
//
//  Created by Admin on 9/10/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDButton.h"
#import "TDStatsView.h"

@interface TDExploreView : UIView

@property (strong, nonatomic) UIButton *backButton;


@property (strong, nonatomic) TDStatsView *statsView;
@property (strong, nonatomic) UIView *chargeView;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UILabel *chargeLabel;

-(id) initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate;
-(void)populate:(TDGame *)game;


@end
