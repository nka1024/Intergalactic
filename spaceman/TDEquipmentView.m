//
//  TDEquipmentView.m
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDEquipmentView.h"

@implementation TDEquipmentView

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.text = @"Оборудование";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        UIView *topView = [[UIView alloc] init];
        
        
        /*  BACK BUTTON  */
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        self.backButton = backButton;
        
        /*  STATS VIEW  */
        
        TDStatsView *statsView = [[TDStatsView alloc] init];
        self.statsView = statsView;
        
        /*  HR LINE  */
        
        UIImageView *hrImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalLine.png"]];
        
        /*  TABLE VIEW  */
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView = tableView;
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.alwaysBounceVertical = NO;
        
        NSDictionary *topSubviews = NSDictionaryOfVariableBindings(backButton, statsView);
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(titleLabel, topView, hrImage, tableView);
        
        for (UIView *view in [topSubviews allValues]){
            [topView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
                
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[titleLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[topView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[hrImage]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[tableView]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-24-[titleLabel]-14-[topView]-8-[hrImage]-[tableView]|"];
        
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:|-8-[backButton]-[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[backButton]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[statsView]|"];
       
        
    }
    return self;
}

-(void)layoutSubviews {
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [super layoutSubviews];
}

@end
