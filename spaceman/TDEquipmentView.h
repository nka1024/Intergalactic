//
//  TDEquipmentView.h
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStatsView.h"
@interface TDEquipmentView : UIView

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) TDStatsView *statsView;

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate;

@end
