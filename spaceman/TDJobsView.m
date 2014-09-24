//
//  TDJobsView.m
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDJobsView.h"

@interface TDJobsView ()

@property (strong, nonatomic) UILabel *jobHeaderLabel;
@property (strong, nonatomic) UILabel *jobBodyLabel;

@end

@implementation TDJobsView


-(id) init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.text = @"Поиск работы";
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
        self.jobHeaderLabel = jobHeaderLabel;
        self.jobBodyLabel = jobBodyLabel;
        

        
        /* SUBMIT BUTTON */
        
        TDStringWithMarks *submitButtonText = [TDStringWithMarks stringWithText:@"Принять" marks: @"Принять", nil];
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

-(void)setJobBody:(TDStringWithMarks *)body salary:(long long)salary {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    NSString *salaryString = [NSString stringWithFormat:@"\n\nОплата: ¥ %@ в день.", [TDUtils formatedNumber:salary]];
    NSString *text = [NSString stringWithFormat:@"%@ %@", body.text, salaryString];
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text
                                                              attributes:attributes];
    

    NSArray *marks = [NSArray arrayWithObjects:salaryString, nil];
    for (NSString *mark in marks) {
        NSRange range = [text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils whiteColor]
                                 range:range];
    }
    
    for (NSString *mark in body.marks) {
        NSRange range = [text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils whiteColor]
                                 range:range];
    }
    
    self.jobBodyLabel.attributedText = attributedString;
    
}


-(void)setJobTitle:(NSString *)text {
    
    NSString *contractText = [NSString stringWithFormat:@"Работа: %@", text];
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils mediumFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:contractText
                                                              attributes:attributes];
    
    
    NSRange range = [contractText rangeOfString:text];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[TDUtils whiteColor]
                             range:range];
    
    
    self.jobHeaderLabel.attributedText = attributedString;
    
}

-(void)setNoJobsAvailable {
    
    self.jobHeaderLabel.text = @"";
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    

    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:@"Подходящих вакансий не найдено"
                                                              attributes:attributes];
    
    self.jobBodyLabel.attributedText = attributedString;

}

@end
