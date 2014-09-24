//
//  TDExploreViewController.h
//  spaceman
//
//  Created by Admin on 9/9/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDViewController.h"
#import "TDExploreView.h"
#import "TDMissionCell.h"
#import "TDPopupManager.h"
#import "TDStoryViewController.h"

@interface TDExploreViewController : TDViewController <UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>

@property (strong, nonatomic) TDExploreView *exploreView;

@end
