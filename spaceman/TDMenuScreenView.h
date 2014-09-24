//
//  TDMenuScreenView.h
//  spaceman
//
//  Created by Admin on 9/14/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"

@interface TDMenuScreenView : UIView

@property (strong, nonatomic) UITableView *tableView;
@property (strong,nonatomic) UIImageView *image;

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate;

@end
