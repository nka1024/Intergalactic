//
//  TDStoryCell.m
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDStoryCell.h"

@implementation TDStoryCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *itemTitle = [[UILabel alloc] init];
        itemTitle.font = [TDUtils mediumFont];
        itemTitle.textColor = [TDUtils whiteColor];
        itemTitle.textAlignment = NSTextAlignmentCenter;
        
        UILabel *itemDescription = [[UILabel alloc] init];
        itemDescription.font = [TDUtils tinyFont];
        itemDescription.textColor = [TDUtils redColor];
        itemDescription.textAlignment = NSTextAlignmentCenter;
        
        self.itemDescription = itemDescription;
        self.itemTitle = itemTitle;
        
        
        UIImageView *hrImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalLineBlue.png"]];
        self.hrImage = hrImage;
        
        NSDictionary *subviews = NSDictionaryOfVariableBindings(itemTitle, itemDescription, hrImage);
        
        
        for (UIView *view in [subviews allValues]){
            [self.contentView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"V:|[hrImage]-8-[itemTitle][itemDescription]"];
//        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"V:"];
        
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|[itemTitle]|"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|[itemDescription]|"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|-45-[hrImage]-45-|"];
        
    }
    return self;
    
}

-(void)popuplate {
    
    
    if ([self.itemExit isEqualToNumber:@0]) {
        self.itemDescription.textColor = [TDUtils blueColor];
        self.hrImage.alpha = 1.0f;
    } else {
        self.itemDescription.textColor = [TDUtils redColor];
        self.hrImage.alpha = 0.0f;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
