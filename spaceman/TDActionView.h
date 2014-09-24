//
//  TDActionView.h
//  spaceman
//
//  Created by Admin on 9/5/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"

@interface TDActionView : UIView

@property (nonatomic) CGFloat backgroundAlpha;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIProgressView *progressView;

- (id)initWithText:(NSString *)text;

@end
