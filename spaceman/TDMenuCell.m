//
//  TDMissionCell.m
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDMenuCell.h"

@implementation TDMenuCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *itemTitle = [[UILabel alloc] init];
        itemTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:24];
        self.itemTitle = itemTitle;
        
        
        UIImageView *hrImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalLineBlue.png"]];
        self.hrImage = hrImage;
        [hrImage setHidden:YES];
        
        NSDictionary *subviews = NSDictionaryOfVariableBindings(itemTitle, hrImage);
        
        
        for (UIView *view in [subviews allValues]){
            [self.contentView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"V:|[hrImage]-8-[itemTitle]"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|-[itemTitle]-|"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|-45-[hrImage]-45-|"];
    }
    return self;
    
}


-(void) setCaptionText:(TDStringWithMarks *)text {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:self.isNewGame? 36:24],
                                  NSForegroundColorAttributeName: [TDUtils blackColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text.text
                                                              attributes:attributes];
    
    for (NSString *mark in text.marks) {
        NSRange range = [text.text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils greyColor]
                                 range:range];
    }
    
    self.textLabel.attributedText = attributedString;
}

@end
