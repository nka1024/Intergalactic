//
//  TDStatsView.m
//  spaceman
//
//  Created by Admin on 9/6/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDStatsView.h"

@interface TDStatsView ()

@property (strong, nonatomic) UILabel *rightLabel;

@end

@implementation TDStatsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        /*  STATS VIEW  */
        
        UILabel *leftLabel = [[UILabel alloc] init];
        leftLabel.font = [TDUtils smallFont];
        leftLabel.textColor = [TDUtils blueColor];
        leftLabel.text = NSLocalizedString(@"statsVuew_leftText", nil);
        leftLabel.textAlignment = NSTextAlignmentRight;
        leftLabel.numberOfLines = 5;
        
        UILabel *rightLabel = [[UILabel alloc] init];
        rightLabel.font = [TDUtils smallFont];
        rightLabel.textColor = [TDUtils whiteColor];
        rightLabel.textAlignment = NSTextAlignmentLeft;
        rightLabel.numberOfLines = 5;
        self.rightLabel = rightLabel;
        
        NSDictionary *subviews = NSDictionaryOfVariableBindings(leftLabel, rightLabel);

     
        for (UIView *view in [subviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"V:|[leftLabel]|"];
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"V:|[rightLabel]|"];
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"H:[leftLabel]-3-[rightLabel]-8-|"];
        
    }
    return self;
}

-(void)populate:(TDGame *)game {
    
    NSString *playerMoney = [NSString stringWithFormat:@"¥ %@", [TDUtils formatedNumber:game.playerMoney]];
    NSString *jobSalary = [NSString stringWithFormat:@"¥ %@", [TDUtils formatedNumber:game.playerJob.salary]];
    NSString *score = [NSString stringWithFormat:@"%lld", [game score]];
    NSString *hull = [[game getUpgrade:UPGRADE_HULL_IDX].name lowercaseString];
    NSString *rank = [[game pilotRank].title lowercaseString];
    
    self.rightLabel.text = [NSString stringWithFormat:NSLocalizedString(@"statsVuew_salaryText", nil), playerMoney,  jobSalary, hull, rank, score];
}

@end
