//
//  TDStoryCell.h
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"

@interface TDStoryCell : UITableViewCell

@property (strong, nonatomic) UILabel *itemTitle;
@property (strong, nonatomic) UILabel *itemDescription;
@property (strong, nonatomic) NSNumber *itemExit;

@property (strong, nonatomic) UIImageView *hrImage;

-(void)popuplate;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
