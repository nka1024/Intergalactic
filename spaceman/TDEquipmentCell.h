//
//  TDEquipmentCell.h
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"

@interface TDEquipmentCell : UITableViewCell

@property (strong, nonatomic) UILabel *itemTitle;
@property (strong, nonatomic) UILabel *itemDescription;
@property (strong, nonatomic) UILabel *itemPrice;
@property (strong, nonatomic) UILabel *itemUpgrade;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
