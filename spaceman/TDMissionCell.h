//
//  TDMissionCell.h
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"

@interface TDMissionCell : UITableViewCell

@property (strong, nonatomic) UILabel *itemTitle;
@property (strong, nonatomic) UILabel *itemDescription;

@property (strong, nonatomic) UIImageView *hrImage;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
