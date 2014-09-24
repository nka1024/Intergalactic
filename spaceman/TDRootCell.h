//
//  TDRootCell.h
//  spaceman
//
//  Created by Admin on 8/27/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"

@interface TDRootCell : UITableViewCell

@property (strong, nonatomic) UILabel *itemTitle;
@property (strong, nonatomic) UILabel *itemDescription;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
