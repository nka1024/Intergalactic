//
//  TDMissionCell.m
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDMissionCell.h"

@implementation TDMissionCell

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
        itemDescription.textAlignment = NSTextAlignmentCenter;
        itemDescription.textColor = [TDUtils redColor];
        
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
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|-[itemTitle]-|"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|-[itemDescription]-|"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|-45-[hrImage]-45-|"];
    }
    return self;
    
}

@end
