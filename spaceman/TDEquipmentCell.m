//
//  TDEquipmentCell.m
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDEquipmentCell.h"

@implementation TDEquipmentCell

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
        itemDescription.textAlignment = NSTextAlignmentLeft;
        
        UILabel *itemPrice = [[UILabel alloc] init];
        itemPrice.font = [TDUtils mediumFont];
        itemPrice.textColor = [TDUtils whiteColor];
        itemPrice.textAlignment = NSTextAlignmentRight;
        
        UILabel *itemUpgrade = [[UILabel alloc] init];
        itemUpgrade.font = [TDUtils smallFont];
        itemUpgrade.textColor = [TDUtils blueColor];
        itemUpgrade.textAlignment = NSTextAlignmentLeft;
        
        
        self.itemDescription = itemDescription;
        self.itemTitle = itemTitle;
        self.itemPrice = itemPrice;
        self.itemUpgrade = itemUpgrade;
        
        UIView *bottomView = [[UIView alloc] init];
        UIView *topView = [[UIView alloc] init];
        
//        bottomView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
//        topView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5];
        
        NSDictionary *subviews = NSDictionaryOfVariableBindings(topView, bottomView);
        NSDictionary *topSubviews = NSDictionaryOfVariableBindings(itemTitle, itemPrice);
        NSDictionary *bottomSubviews = NSDictionaryOfVariableBindings(itemDescription, itemUpgrade);
        
        
        for (UIView *view in [topSubviews allValues]){
            [topView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        for (UIView *view in [bottomSubviews allValues]){
            [bottomView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        for (UIView *view in [subviews allValues]){
            [self.contentView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"V:|[topView][bottomView]"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|[topView]|"];
        [TDUtils addVFLConstraintToView:self.contentView subviews:subviews format:@"H:|[bottomView]|"];
        
        [TDUtils addVFLConstraintToView:bottomView subviews:bottomSubviews format:@"V:|[itemDescription]|"];
        [TDUtils addVFLConstraintToView:bottomView subviews:bottomSubviews format:@"V:|[itemUpgrade]|"];
        [TDUtils addVFLConstraintToView:bottomView subviews:bottomSubviews format:@"H:|[itemDescription]"];
        [TDUtils addVFLConstraintToView:bottomView subviews:bottomSubviews format:@"H:[itemUpgrade]|"];
        
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:|[itemTitle]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"V:[itemPrice]|"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:|[itemTitle]"];
        [TDUtils addVFLConstraintToView:topView subviews:topSubviews format:@"H:[itemPrice]|"];
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
