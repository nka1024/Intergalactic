//
//  TDExploreView.m
//  spaceman
//
//  Created by Admin on 9/10/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDExploreView.h"

@interface TDExploreView ()

@property (strong, nonatomic) UILabel *droidHeaderLabel;
@property (strong, nonatomic) UILabel *droidInfoLabel;
@property (strong, nonatomic) UILabel *subscriptLabel;

@property (strong, nonatomic) UIImageView *hr;
@property (strong, nonatomic) UIImageView *bg;

@property (nonatomic) BOOL charged;

@end


@implementation TDExploreView

-(id) initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.text = @"Исследование";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        //  TOP VIEW
        
        UIView *topView = [[UIView alloc] init];
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        self.backButton = backButton;
        
        //  STATS VIEW
        
        TDStatsView *statsView = [[TDStatsView alloc] init];
        self.statsView = statsView;
        
        //  HR LINE
        
        UIImageView *hrImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalLine.png"]];
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"exploration.png"]];
        [background setContentMode:UIViewContentModeCenter];
        
        [self addSubview:background];
        self.hr = hrImage;
        self.bg = background;

        
        
        // CHARGE VIEW
        
        self.charged = NO;
        
        UIView *chargeView = [[UIView alloc] init];
        self.chargeView = chargeView;
        
        UILabel *chargeLeftLabel = [[UILabel alloc] init];
        chargeLeftLabel.font = [TDUtils giantFont];
        chargeLeftLabel.textColor = [TDUtils whiteColor];
        chargeLeftLabel.textAlignment = NSTextAlignmentLeft;
        self.chargeLabel = chargeLeftLabel;
        
        UILabel *chargeRightLabel = [[UILabel alloc] init];
        chargeRightLabel.font = [TDUtils smallFont];
        chargeRightLabel.textColor = [TDUtils whiteColor];
        chargeRightLabel.text = @"%";
        chargeRightLabel.textAlignment = NSTextAlignmentLeft;
        
        NSDictionary *chargeSubviews = NSDictionaryOfVariableBindings(chargeLeftLabel, chargeRightLabel);
        
        for (UIView *view in [chargeSubviews allValues]){
            [chargeView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
        [TDUtils addVFLConstraintToView:chargeView subviews:chargeSubviews format:@"V:|[chargeLeftLabel]|"];
        [TDUtils addVFLConstraintToView:chargeView subviews:chargeSubviews format:@"V:|[chargeRightLabel]"];
        [TDUtils addVFLConstraintToView:chargeView subviews:chargeSubviews format:@"H:|[chargeLeftLabel][chargeRightLabel]|"];
        
        
        // DROID VIEW
        
        UIView *droidView = [[UIView alloc] init];
        UILabel *droidHeaderLabel = [[UILabel alloc] init];
        
        droidHeaderLabel.font = [TDUtils mediumFont];
        droidHeaderLabel.textColor = [TDUtils blueColor];
        droidHeaderLabel.text = @"Готовность гипердвигателя";
        droidHeaderLabel.textAlignment = NSTextAlignmentCenter;
        droidHeaderLabel.numberOfLines = 4;

        UILabel *droidInfoLabel = [[UILabel alloc] init];
        droidInfoLabel.font = [TDUtils tinyFont];
        droidInfoLabel.textColor = [TDUtils blueColor];
        droidInfoLabel.text = @"Вы сможете отправиться на поиск новых миров как только гипердвигатель будет готов к прыжку";
        droidInfoLabel.textAlignment = NSTextAlignmentCenter;
        droidInfoLabel.numberOfLines = 20;
        self.droidHeaderLabel = droidHeaderLabel;
        self.droidInfoLabel = droidInfoLabel;
        
        
        // TableView
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView = tableView;
        
        [tableView setHidden:YES];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.alwaysBounceVertical = NO;
        
        
        NSDictionary *topSubviews = NSDictionaryOfVariableBindings(backButton, statsView);
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(titleLabel, topView, hrImage, droidView, tableView);
        NSDictionary *droidSubviews= NSDictionaryOfVariableBindings(droidHeaderLabel, droidInfoLabel, chargeView);
        
        
        for (UIView *view in [topSubviews allValues]){
            [topView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [droidSubviews allValues]){
            [droidView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[titleLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[topView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[hrImage]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[droidView]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[tableView]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-24-[titleLabel]-14-[topView]-14-[hrImage]-26-[droidView]-[tableView]|"];
        
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:|-8-[backButton]"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[backButton]|"];
        
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"V:|[droidHeaderLabel]-10-[chargeView(42)]-10-[droidInfoLabel]|"];
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"H:|[droidHeaderLabel]|"];
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"H:|[droidInfoLabel]|"];
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"H:[chargeView]"];
        
        [droidView addConstraint: [NSLayoutConstraint constraintWithItem:chargeView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:droidView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f constant:0.f]];
    }
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];

    // Reposition background
    
    // TODO: rewrite with constraints
    
    CGRect frame = self.bg.frame;
    
    frame.origin.y = self.hr.frame.origin.y + self.hr.frame.size.height /2;
    self.bg.frame = frame;
    
}


-(void)populate:(TDGame *)game {
    
    if (game.charge == 100) {
        if (!self.charged) {
            
            self.charged = YES;
            
            self.droidHeaderLabel.font = [TDUtils smallFont];
            self.droidHeaderLabel.text = @"Корабль готов к гиперпрыжку";
            
            [self.droidInfoLabel setHidden:YES];
            [self.chargeView setHidden:YES];
            [self.tableView setHidden:NO];
            
            [self layoutSubviews];
        }
    } else {
        if (self.charged) {
            
            self.charged = NO;
            
            self.droidHeaderLabel.font = [TDUtils mediumFont];
            self.droidHeaderLabel.text = @"Готовность гипердвигателя";
            
            [self.droidInfoLabel setHidden:NO];
            [self.chargeView setHidden:NO];
            [self.tableView setHidden:YES];

            [self layoutSubviews];
        }
    }
    
    self.chargeLabel.text = [NSString stringWithFormat:@"%ld", (long)game.charge];
}

@end
