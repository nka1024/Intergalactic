//
//  TDRootCell.m
//  spaceman
//
//  Created by Admin on 8/27/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDRootCell.h"

@implementation TDRootCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *itemTitle = [[UILabel alloc] init];
        itemTitle.font = [TDUtils largeFont];
        itemTitle.textColor = [TDUtils whiteColor];
        itemTitle.textAlignment = NSTextAlignmentRight;
        
        UILabel *itemDescription = [[UILabel alloc] init];
        itemDescription.font = [TDUtils smallFont];
        itemDescription.textColor = [TDUtils blueColor];
        itemDescription.textAlignment = NSTextAlignmentRight;
        
        self.itemDescription = itemDescription;
        self.itemTitle = itemTitle;
        
        [self.contentView addSubview:itemTitle];
        [self.contentView addSubview:itemDescription];
        
        [itemTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [itemDescription setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSDictionary *subviews = NSDictionaryOfVariableBindings(itemTitle, itemDescription);
        
        [self.contentView addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|[itemTitle][itemDescription]"
                              options:0
                              metrics:nil
                              views:subviews]];

        [self.contentView addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[itemTitle]"
                              options:0
                              metrics:nil
                              views:subviews]];
        
        [self.contentView addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|[itemDescription]"
                              options:0
                              metrics:nil
                              views:subviews]];
    
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
