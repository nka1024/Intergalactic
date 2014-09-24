//
//  TDMenuCell.h
//  Интергалактик
//
//  Created by Admin on 9/15/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStringWithMarks.h"

@interface TDMenuCell : UITableViewCell

@property (strong, nonatomic) UILabel *itemTitle;

@property (strong, nonatomic) UIImageView *hrImage;

@property ( nonatomic) BOOL isNewGame;
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier;
-(void)setCaptionText:(TDStringWithMarks *)text;
@end
