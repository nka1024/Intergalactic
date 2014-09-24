//
//  TDButtonView.m
//  spaceman
//
//  Created by Admin on 9/8/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDButton.h"

@interface TDButton()

@property (strong, nonatomic) UILabel *label;

@end

@implementation TDButton

- (id)initWithType:(TDButtonType) type
              text:(TDStringWithMarks *)text
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        
        UILabel *label = [[UILabel alloc] init];
        self.label = label;
        [self setLabelText:text];
        
        NSString *imageName = type == TDButtonTypeDefault ? @"button.png" : @"refresh.png";
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [image setContentMode:UIViewContentModeCenter];
        

        NSDictionary *subviews = NSDictionaryOfVariableBindings(label, image);
        
        for (UIView *view in [subviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"H:|-14-[label]|"];
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"H:|[image]"];
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"V:|-17-[label]"];
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"V:|[image]|"];
        
    }
    return self;
}


-(void)setLabelText:(TDStringWithMarks*)text {
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = NSTextAlignmentLeft;
    
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
                                 value:[TDUtils mediumFont]
                                 range:range];
    }
    
    self.label.attributedText = attributedString;
}


@end
