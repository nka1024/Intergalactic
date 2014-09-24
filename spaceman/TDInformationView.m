//
//  TDInformationView.m
//  Интергалактик
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDInformationView.h"

@interface TDInformationView ()

@property (strong, nonatomic) UILabel *contentHeaderLabel;
@property (strong, nonatomic) UILabel *contentBodyLabel;

@end

@implementation TDInformationView


-(id) init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.text = @"Информация";
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
        
        
        /* CONTRACT VIEW */
        
        UILabel *jobHeaderLabel = [[UILabel alloc] init];
        UILabel *jobBodyLabel = [[UILabel alloc] init];
        jobBodyLabel.numberOfLines = 20;
        self.contentHeaderLabel = jobHeaderLabel;
        self.contentBodyLabel = jobBodyLabel;
        
        
        
        /* SUBMIT BUTTON */
        
        TDStringWithMarks *submitButtonText = [TDStringWithMarks stringWithText:@"Новый запрос" marks: @"Новый запрос", nil];
        TDButton *submitButton = [[TDButton alloc] initWithType:TDButtonTypeDefault text:submitButtonText];
        self.submitButton = submitButton;
        
        NSDictionary *topSubviews = NSDictionaryOfVariableBindings(backButton, statsView);
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(titleLabel, topView, hrImage, jobHeaderLabel, jobBodyLabel, submitButton);
        
        for (UIView *view in [topSubviews allValues]){
            [topView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [self addConstraint: [NSLayoutConstraint constraintWithItem:submitButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f constant:0.f]];
        
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[titleLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[topView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[hrImage]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[jobHeaderLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[jobBodyLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:[submitButton]"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-24-[titleLabel]-14-[topView]-14-[hrImage]-10-[jobHeaderLabel]-10-[jobBodyLabel]-30-[submitButton]"];
        
        
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:|-8-[backButton]"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[backButton]|"];
        
    }
    return self;
}

-(void)populate:(TDGame *)game {
    TDInformationData *informationData = game.randomInformationData;

    [self setJobBody:informationData.content];
    [self setJobTitle:informationData.title];
}


-(void)setJobBody:(TDStringWithMarks *)content {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:content.text
                                                              attributes:attributes];
    
    for (NSString *mark in content.marks) {
        NSRange range = [content.text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils whiteColor]
                                 range:range];
    }
    
    self.contentBodyLabel.attributedText = attributedString;
    
}


-(void)setJobTitle:(NSString *)text {
    
//    NSString *contractText = [NSString stringWithFormat:@"Работа: %@", text];
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils mediumFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text
                                                              attributes:attributes];
    
    
    NSRange range = [text rangeOfString:text];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[TDUtils whiteColor]
                             range:range];
    
    
    self.contentHeaderLabel.attributedText = attributedString;
    
}

-(void)setNoJobsAvailable {
    
    self.contentHeaderLabel.text = @"";
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:@"Подходящих вакансий не найдено"
                                                              attributes:attributes];
    
    self.contentHeaderLabel.attributedText = attributedString;
    
}

@end
