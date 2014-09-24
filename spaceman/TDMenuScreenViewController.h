//
//  TDMenuScreenControllerViewController.h
//  spaceman
//
//  Created by Admin on 9/14/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//


#import "TDViewController.h"
#import "TDMenuScreenView.h"
#import "TDMenuCell.h"
#import "TDPopupManager.h"
#import "TDRootViewController.h"
#import "TDStringWithMarks.h"
#import "TDDataStorage.h"

@interface TDMenuScreenViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>

@property (strong, nonatomic) TDMenuScreenView *menuScreenView;

@end
