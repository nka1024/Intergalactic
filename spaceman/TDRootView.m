//
//  TDRootView.m
//  spaceman
//
//  Created by Admin on 8/18/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDRootView.h"

@interface TDRootView ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDateFormatter *timeFormatter;

@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation TDRootView

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
     
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel = titleLabel;

        /*  STATS VIEW  */
        
        TDStatsView *statsView = [[TDStatsView alloc] init];
        self.statsView = statsView;

        /*  TIME VIEW  */
        
        UIView *timeView = [[UIView alloc] init];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [TDUtils giantFont];
        timeLabel.textColor = [TDUtils whiteColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.font = [TDUtils smallFont];
        dateLabel.textColor = [TDUtils blueColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;

        self.dateLabel = dateLabel;
        self.timeLabel = timeLabel;
        
        self.dateFormatter = [[NSDateFormatter alloc] init];

        [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [self.dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
        [self.dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        
        self.timeFormatter = [[NSDateFormatter alloc] init];
        [self.timeFormatter setDateStyle:NSDateFormatterMediumStyle];
        [self.timeFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"ru_RU"]];
        [self.timeFormatter setDateFormat:@"HH:mm"];
        [self.timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];

        
        
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
        
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(titleLabel, statsView, timeView, hrImage, tableView);
        NSDictionary *timeSubviews = NSDictionaryOfVariableBindings(timeLabel, dateLabel);


        for (UIView *view in [timeSubviews allValues]){
            [timeView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
     
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[titleLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:[statsView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[hrImage]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[tableView]-8-|"];
        
        if ([TDUtils isSmallScreen]) {
            
            // for iPhone 4s and ipod4 put time label at left top screen
            
            [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-76-[timeView]"];
            [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[timeView]"];
            [TDUtils addVFLConstraintToView:self
                                   subviews:rootSubviews
                                     format:@"V:|-24-[titleLabel]-[statsView]-20-[hrImage]-[tableView]|"];
        }
        else {
            [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[timeView]-|"];
            [TDUtils addVFLConstraintToView:self
                                   subviews:rootSubviews
                                     format:@"V:|-24-[titleLabel]-[statsView]-20-[timeView]-20-[hrImage]-[tableView]|"];
            
        }
        
        [TDUtils addVFLConstraintToView:timeView subviews:timeSubviews format:@"V:|[timeLabel(42)]-3-[dateLabel]|"];
        [TDUtils addVFLConstraintToView:timeView subviews:timeSubviews format:@"H:|[dateLabel]|"];
        [TDUtils addVFLConstraintToView:timeView subviews:timeSubviews format:@"H:|[timeLabel]|"];
        
    }
    return self;
}

-(void)setDateTime:(NSTimeInterval) timestamp {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    self.dateLabel.text = [self.dateFormatter stringFromDate:date];
    self.timeLabel.text = [self.timeFormatter stringFromDate:date];
}

-(void)setGameWon {
    
    
    self.dateLabel.text = @"Вы победили";
    self.timeLabel.text = @"НОВАЯ ЭРА";
}

-(void)layoutSubviews {
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [super layoutSubviews];
}

-(void)populate:(TDGame *)game {
    self.titleLabel.text = [NSString stringWithFormat:@"Пилот %@", game.pilotName.capitalizedString] ;
}

@end
