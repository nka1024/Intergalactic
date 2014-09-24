//
//  TDEquipmentView.m
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDContractsView.h"


@interface TDContractsView ()

@property (strong, nonatomic) UILabel *contractHeaderLabel;
@property (strong, nonatomic) UILabel *contractBodyLabel;

@property (strong, nonatomic) UILabel *detailsRightLabel;
@property (strong, nonatomic) UILabel *detailsLeftLabel;

@end


@implementation TDContractsView

-(id) init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [TDUtils largeFont];
        titleLabel.textColor = [TDUtils whiteColor];
        titleLabel.text = @"Поиск контракта";
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
        
        UILabel *contractHeaderLabel = [[UILabel alloc] init];
        UILabel *contractBodyLabel = [[UILabel alloc] init];
        contractBodyLabel.numberOfLines = 20;
        self.contractHeaderLabel = contractHeaderLabel;
        self.contractBodyLabel = contractBodyLabel;


//        UILabel *demandsHeaderLabel = [[UILabel alloc] init];
//        demandsHeaderLabel.font = [TDUtils smallFont];
//        demandsHeaderLabel.textColor = [TDUtils whiteColor];
//        demandsHeaderLabel.text = @"Требования:";
        
        /* DEMANDS VIEW */
        
        UIView *demandsView = [[UIView alloc] init];
        
        UILabel *demandsLeftLabel = [[UILabel alloc] init];
        demandsLeftLabel.font = [TDUtils smallFont];
        demandsLeftLabel.textColor = [TDUtils blueColor];
        demandsLeftLabel.textAlignment = NSTextAlignmentLeft;
        demandsLeftLabel.numberOfLines = 5;
        
        UILabel *demandsRightLabel = [[UILabel alloc] init];
        demandsRightLabel.font = [TDUtils smallFont];
        demandsRightLabel.textColor = [TDUtils whiteColor];
        demandsRightLabel.textAlignment = NSTextAlignmentLeft;
        demandsRightLabel.numberOfLines = 5;

        self.detailsLeftLabel = demandsLeftLabel;
        self.detailsRightLabel = demandsRightLabel;
       
        /* SUBMIT VIEW */
        
        UIView *buttonsView = [[UIView alloc] init];
        
        TDStringWithMarks *submitButtonText = [TDStringWithMarks stringWithText:@"Принять" marks: @"Принять", nil];
        TDButton *submitButton = [[TDButton alloc] initWithType:TDButtonTypeDefault text:submitButtonText];
        
        TDStringWithMarks *refreshButtonText = [TDStringWithMarks stringWithText:@"Новый запрос" marks: @"Новый запрос", nil];
        TDButton *refreshButton = [[TDButton alloc] initWithType:TDButtonTypeDefault text:refreshButtonText];
        
        self.refreshButton = refreshButton;
        self.submitButton = submitButton;
        
        NSDictionary *buttonsSubviews = NSDictionaryOfVariableBindings(submitButton, refreshButton);
        
        for (UIView *view in [buttonsSubviews allValues]){
            [buttonsView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:buttonsView subviews:buttonsSubviews format:@"V:|[submitButton]|"];
        [TDUtils addVFLConstraintToView:buttonsView subviews:buttonsSubviews format:@"V:|[refreshButton]|"];
        [TDUtils addVFLConstraintToView:buttonsView subviews:buttonsSubviews format:@"H:|[submitButton]"];
        [TDUtils addVFLConstraintToView:buttonsView subviews:buttonsSubviews format:@"H:[refreshButton]-10-|"];
        
        
        NSDictionary *topSubviews = NSDictionaryOfVariableBindings(backButton, statsView);
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(titleLabel, topView, hrImage, contractHeaderLabel, contractBodyLabel, demandsView, buttonsView);
        NSDictionary *demandsSubviews = NSDictionaryOfVariableBindings(demandsLeftLabel, demandsRightLabel);
        
        for (UIView *view in [topSubviews allValues]){
            [topView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [demandsSubviews allValues]){
            [demandsView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[titleLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[topView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[hrImage]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[demandsView]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[contractHeaderLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[contractBodyLabel]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[buttonsView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-24-[titleLabel]-14-[topView]-12-[hrImage][contractHeaderLabel]-10-[contractBodyLabel]-30-[demandsView]-18-[buttonsView]"];
        
        
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:|-8-[backButton]"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[statsView]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[backButton]|"];
        
        [TDUtils addVFLConstraintToView:demandsView subviews:demandsSubviews format:@"V:|[demandsRightLabel]|"];
        [TDUtils addVFLConstraintToView:demandsView subviews:demandsSubviews format:@"V:|[demandsLeftLabel]|"];
        [TDUtils addVFLConstraintToView:demandsView subviews:demandsSubviews format:@"H:|[demandsLeftLabel]-[demandsRightLabel]"];

    }
    return self;
}



-(void)popuplateWithNoContractText:(TDStringWithMarks *)text {
    
    [self.contractHeaderLabel setHidden:YES];
    [self.detailsLeftLabel setHidden:YES];
    [self.detailsRightLabel setHidden:YES];
    [self.submitButton setHidden:YES];
    
    [self fillNoContractInfo:text];

}

-(void)popuplateWithContractTitle:(NSString *)title
                             info:(TDStringWithMarks *)info
                           reward:(long long)reward{
    
    [self.contractHeaderLabel setHidden:NO];
    [self.detailsLeftLabel setHidden:NO];
    [self.detailsRightLabel setHidden:NO];
    [self.submitButton setHidden:NO];

    [self fillContractTitle:title];
    [self fillContractInfo:info];
    self.detailsLeftLabel.text = @"Оплата";
    self.detailsRightLabel.text = [NSString stringWithFormat:@"¥ %@", [TDUtils formatedNumber:reward]];
}


-(void) fillContractInfo:(TDStringWithMarks *)text {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text.text
                                                              attributes:attributes];
    
    for (NSString *mark in text.marks) {
        NSRange range = [text.text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils whiteColor]
                                 range:range];
    }
    
    self.contractBodyLabel.attributedText = attributedString;
}


-(void) fillNoContractInfo:(TDStringWithMarks *)text {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: [TDUtils blueColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text.text
                                                              attributes:attributes];
    
    for (NSString *mark in text.marks) {
        NSRange range = [text.text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils whiteColor]
                                 range:range];
        [attributedString addAttribute:NSFontAttributeName
                                 value:[TDUtils largeFont]
                                 range:range];
    }

    
    self.contractBodyLabel.attributedText = attributedString;
}


-(void) fillContractTitle:(NSString *)text {
    
    NSString *contractText = [NSString stringWithFormat:@"Контракт: %@", text];
    
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
   
    
    self.contractHeaderLabel.attributedText = attributedString;

}

@end
