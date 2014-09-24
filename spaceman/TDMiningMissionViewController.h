//
//  TDMiningMissionViewController.h
//  Интергалактик
//
//  Created by Admin on 9/17/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TDViewController.h"
#import "TDMissionView.h"
#import "TDMissionCell.h"
#import "TDPopupManager.h"

@interface TDMiningMissionViewController : TDViewController<UITableViewDelegate,UITableViewDataSource>

-(id)initWithGame:(TDGame *)game contract:(TDContractData *)contract;

@end
