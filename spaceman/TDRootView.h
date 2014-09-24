//
//  TDRootView.h
//  spaceman
//
//  Created by Admin on 8/18/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDStatsView.h"
#import "TDUtils.h"

@interface TDRootView : UIView

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TDStatsView *statsView;

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate;
-(void)setDateTime:(NSTimeInterval) timestamp;
-(void)populate:(TDGame *)game;
-(void)setGameWon;
@end
