//
//  TDHangarView.m
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDHangarView.h"


@interface TDHangarView ()

@property (strong, nonatomic) UILabel *droidHeaderLabel;
@property (strong, nonatomic) UILabel *droidInfoLabel;
@property (strong, nonatomic) UILabel *subscriptLabel;

@property (strong, nonatomic) UIView *topView;

@end


@implementation TDHangarView

-(id) init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.text = @"Ремонтный док";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        /*  TOP VIEW  */
        
        UIView *topView = [[UIView alloc] init];
        self.topView = topView;
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        self.backButton = backButton;
        
        /*  STATS VIEW  */
        
        TDStatsView *statsView = [[TDStatsView alloc] init];
        self.statsView = statsView;
        

        // Droids button
        TDStringWithMarks *droidsButtonText = [TDStringWithMarks stringWithText:@"Дроиды: 4" marks:@"4", nil];
        TDButton *droidsButton = [[TDButton alloc] initWithType:TDButtonTypeDefault text:droidsButtonText];
        
        self.droidsButton = droidsButton;
        [droidsButton setHidden:YES];
        
        /* DROID VIEW */
        
        UIView *droidView = [[UIView alloc] init];
        UILabel *droidHeaderLabel = [[UILabel alloc] init];
        UILabel *droidInfoLabel = [[UILabel alloc] init];
        droidInfoLabel.numberOfLines = 20;
        self.droidHeaderLabel = droidHeaderLabel;
        self.droidInfoLabel = droidInfoLabel;

        UIImageView *droidImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalLine.png"]];
        [droidImage setHidden:YES];
        [droidImage setContentMode:UIViewContentModeCenter];
        self.image = droidImage;
        
        
        // Repair view
        TDStringWithMarks *repairButtonText = [TDStringWithMarks stringWithText:@"Ремонт" marks: nil];
        TDButton *repairView = [[TDButton alloc] initWithType:TDButtonTypeDefault text:repairButtonText];
        self.repairButton = repairView;
        
        // SCORE VIEW
        
        UIView *scoreView = [[UIView alloc] init];
        UIView *scoreBottomView = [[UIView alloc] init];
     
        UILabel *scoreTopLabel = [[UILabel alloc] init];
        scoreTopLabel.font = [TDUtils tinyFont];
        scoreTopLabel.textColor = [TDUtils blueColor];
        scoreTopLabel.text = @"Очки пилотирования:";
        scoreTopLabel.textAlignment = NSTextAlignmentRight;
        scoreTopLabel.numberOfLines = 2;
        
        UILabel *scoreBottomLeftLabel = [[UILabel alloc] init];
        scoreBottomLeftLabel.font = [TDUtils giantFont];
        scoreBottomLeftLabel.textColor = [TDUtils whiteColor];
        scoreBottomLeftLabel.textAlignment = NSTextAlignmentLeft;
        self.scoreLabel = scoreBottomLeftLabel;
        
        UILabel *scoreBottomRightLabel = [[UILabel alloc] init];
        scoreBottomRightLabel.font = [TDUtils smallFont];
        scoreBottomRightLabel.textColor = [TDUtils whiteColor];
        scoreBottomRightLabel.textAlignment = NSTextAlignmentLeft;
        self.nextScoreLabel = scoreBottomRightLabel;

        
        NSDictionary *scoreSubviews = NSDictionaryOfVariableBindings(scoreTopLabel, scoreBottomView);
        NSDictionary *scoreBottomSubviews = NSDictionaryOfVariableBindings(scoreBottomLeftLabel, scoreBottomRightLabel);
        
        
        for (UIView *view in [scoreSubviews allValues]){
            [scoreView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        for (UIView *view in [scoreBottomSubviews allValues]){
            [scoreBottomView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:scoreView subviews:scoreSubviews format:@"V:|[scoreTopLabel][scoreBottomView(42)]|"];
        [TDUtils addVFLConstraintToView:scoreView subviews:scoreSubviews format:@"H:|[scoreTopLabel]|"];
        [TDUtils addVFLConstraintToView:scoreView subviews:scoreSubviews format:@"H:|[scoreBottomView]|"];
    
        [TDUtils addVFLConstraintToView:scoreBottomView subviews:scoreBottomSubviews format:@"V:|[scoreBottomLeftLabel]|"];
        [TDUtils addVFLConstraintToView:scoreBottomView subviews:scoreBottomSubviews format:@"V:[scoreBottomRightLabel]|"];
        [TDUtils addVFLConstraintToView:scoreBottomView subviews:scoreBottomSubviews format:@"H:|[scoreBottomLeftLabel]-[scoreBottomRightLabel]"];
        
        
        // HP VIEW
        
        
        UIView *hpView = [[UIView alloc] init];
        UIView *hpBottomView = [[UIView alloc] init];
        
        UILabel *hpTopLabel = [[UILabel alloc] init];
        hpTopLabel.font = [TDUtils tinyFont];
        hpTopLabel.textColor = [TDUtils blueColor];
        hpTopLabel.text = @"Состояние обшивки:";
        hpTopLabel.textAlignment = NSTextAlignmentRight;
        hpTopLabel.numberOfLines = 4;
        
        UILabel *hpBottomLeftLabel = [[UILabel alloc] init];
        hpBottomLeftLabel.font = [TDUtils giantFont];
        hpBottomLeftLabel.textColor = [TDUtils whiteColor];
        hpBottomLeftLabel.textAlignment = NSTextAlignmentLeft;
        hpBottomLeftLabel.numberOfLines = 4;
        self.hpLabel = hpBottomLeftLabel;
        
        UILabel *hpBottomRightLabel = [[UILabel alloc] init];
        hpBottomRightLabel.font = [TDUtils smallFont];
        hpBottomRightLabel.textColor = [TDUtils whiteColor];
        hpBottomRightLabel.text = @"%";
        hpBottomRightLabel.textAlignment = NSTextAlignmentLeft;
        hpBottomRightLabel.numberOfLines = 4;
        
        
        NSDictionary *hpSubviews = NSDictionaryOfVariableBindings(hpTopLabel, hpBottomView);
        NSDictionary *hpBottomSubviews = NSDictionaryOfVariableBindings(hpBottomLeftLabel, hpBottomRightLabel);
        
        
        for (UIView *view in [hpSubviews allValues]){
            [hpView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        for (UIView *view in [hpBottomSubviews allValues]){
            [hpBottomView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
        [TDUtils addVFLConstraintToView:hpView subviews:hpSubviews format:@"V:|[hpTopLabel][hpBottomView(42)]|"];
        [TDUtils addVFLConstraintToView:hpView subviews:hpSubviews format:@"H:|[hpTopLabel]|"];
        [TDUtils addVFLConstraintToView:hpView subviews:hpSubviews format:@"H:|[hpBottomView]|"];
        
        [TDUtils addVFLConstraintToView:hpBottomView subviews:hpBottomSubviews format:@"V:|[hpBottomLeftLabel]|"];
        [TDUtils addVFLConstraintToView:hpBottomView subviews:hpBottomSubviews format:@"V:|[hpBottomRightLabel]"];
        [TDUtils addVFLConstraintToView:hpBottomView subviews:hpBottomSubviews format:@"H:[hpBottomLeftLabel][hpBottomRightLabel]|"];
        
        
        // HP PANEL 
        
        
        UIView *hpPanelView = [[UIView alloc] init];
        
        NSDictionary *hpPanelSubviews = NSDictionaryOfVariableBindings(scoreView, hpView);
        
        
        for (UIView *view in [hpPanelSubviews allValues]){
            [hpPanelView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:hpPanelView subviews:hpPanelSubviews format:@"V:|[scoreView]|"];
        [TDUtils addVFLConstraintToView:hpPanelView subviews:hpPanelSubviews format:@"V:|[hpView]|"];
        [TDUtils addVFLConstraintToView:hpPanelView subviews:hpPanelSubviews format:@"H:|[scoreView]"];
        [TDUtils addVFLConstraintToView:hpPanelView subviews:hpPanelSubviews format:@"H:[hpView]|"];
        
        
        NSDictionary *topSubviews = NSDictionaryOfVariableBindings(backButton, statsView);
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(titleLabel, topView, droidsButton, droidView, hpPanelView,repairView);
        NSDictionary *droidSubviews= NSDictionaryOfVariableBindings(droidHeaderLabel, droidInfoLabel, droidImage);

        
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
        
        
        [self addConstraint: [NSLayoutConstraint constraintWithItem:repairView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f constant:0.f]];
        
        CGFloat spacing = [TDUtils isSmallScreen] ? 4 : 20;
        NSDictionary *metrics = @{@"spacing":[NSNumber numberWithDouble:spacing]};
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[titleLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[topView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[droidView]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:[repairView]"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-24-[hpPanelView]-24-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:[droidsButton]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-24-[titleLabel]-14-[topView]-spacing-[droidView]-spacing-[hpPanelView]-[repairView]" metrics:metrics];
        
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:|-8-[backButton]"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[backButton]|"];
    
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"V:|[droidImage]-spacing-[droidHeaderLabel][droidInfoLabel]|" metrics:metrics];
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"H:|[droidHeaderLabel]|"];
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"H:|[droidInfoLabel]|"];
        [TDUtils addVFLConstraintToView:droidView subviews:droidSubviews format:@"H:|[droidImage]|"];
        
    }
    return self;
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    // Reposition background
    
    // TODO: rewrite with constraints
    
//    CGRect frame = self.droidsButton.frame;
//    
//    frame.origin.y = self.topView.frame.origin.y + self.topView.frame.size.height + 10;
//    self.droidsButton.frame = frame;
//    
//    NSLog(@"%f", frame.size.height);
    
}



-(void) setDroidInfo:(NSString *)text {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils tinyFont],
                                  NSForegroundColorAttributeName: [TDUtils whiteColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text
                                                              attributes:attributes];
    
    NSArray *marks = [NSArray arrayWithObjects:@"технологический уровень", nil];
    for (NSString *mark in marks) {
        NSRange range = [text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils blueColor]
                                 range:range];
    }
    
    self.droidInfoLabel.attributedText = attributedString;
}


-(void) setDroidHeader:(NSString *)text {
    
    NSString *contractText = text;
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils mediumFont],
                                  NSForegroundColorAttributeName: [TDUtils whiteColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:contractText
                                                              attributes:attributes];
    
    NSRange range = [contractText rangeOfString:@"класса"];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[TDUtils blueColor]
                             range:range];
    
    
    self.droidHeaderLabel.attributedText = attributedString;
    
}


-(void)populate:(TDGame *)game {

    self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)game.score];
    self.nextScoreLabel.text = [NSString stringWithFormat:@"/ %ld", (long)game.nextPilotRank.score];
    self.hpLabel.text = [NSString stringWithFormat:@"%ld", (long)game.health];
    
    if (game.health == 100) {
        [self.repairButton setHidden:YES];
    } else {
        [self.repairButton setHidden:NO];
        
        NSString *repairPriceText = [TDUtils formatedNumber:game.repairPrice];
        TDStringWithMarks *repairButtonString =
        [TDStringWithMarks stringWithText:[NSString stringWithFormat:@"Ремонт (¥ %@)", repairPriceText]
                                    marks:@"Ремонт", nil];
        [self.repairButton setLabelText:repairButtonString];
    }
    
    TDUpgradeData *hull = [game getUpgrade:UPGRADE_HULL_IDX];
    NSString *hullName = [[TDData sharedInstance].hullNames objectAtIndex:[game getUpgradeTier:UPGRADE_HULL_IDX]];
    long hullTier = [game getUpgradeTier:UPGRADE_HULL_IDX];
    
    [self setDroidHeader:[NSString stringWithFormat:@"%@ класса %@", hull.name, hullName]];
    [self setDroidInfo:[NSString stringWithFormat:@"%ld технологический уровень", hullTier]];
    
}

@end
