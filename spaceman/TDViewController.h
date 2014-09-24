//
//  TDViewController.h
//  spaceman
//
//  Created by Admin on 9/9/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TDGame.h"

@interface TDViewController : UITableViewController

@property (strong, nonatomic) TDGame *game;

-(id)initWithGame:(TDGame *) game;

-(void)handleGameUpdate:(id)notification;
-(void)handleDayChange:(id)notification;
-(void)handleGameover:(id)notification;

@end
