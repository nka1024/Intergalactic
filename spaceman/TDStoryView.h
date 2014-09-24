//
//  TDStoryView.h
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStatsView.h"
@interface TDStoryView : UIView

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *backButton;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) UIProgressView *progressView;

@property (strong,nonatomic) UIImageView *image;

@property (strong, nonatomic) UILabel *statusLeftLabel;
@property (strong, nonatomic) UILabel *statusRightLabel;
@property (strong, nonatomic) UILabel *textLabel;

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate;
-(void)populate:(TDStroyData *)story page:(NSInteger)page;

@end
