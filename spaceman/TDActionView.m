//
//  TDActionView.m
//  spaceman
//
//  Created by Admin on 9/5/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDActionView.h"

@implementation TDActionView

@synthesize backgroundAlpha = _backgroundAlpha;

- (id)initWithText:(NSString *)text
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    if (self) {
        // Initialization code
        
        self.opaque = NO;
        self.backgroundAlpha = 0;
        
        UIView *contentView = [[UIView alloc] init];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = text;
        label.font = [TDUtils largeFont];
        label.textColor = [TDUtils whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        
        self.label = label;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.tintColor = [TDUtils whiteColor];
        progressView.trackTintColor = [UIColor clearColor];
        progressView.progressViewStyle = UIProgressViewStyleBar;

        self.progressView = progressView;
        
        NSDictionary *contentSubviews = NSDictionaryOfVariableBindings(label, progressView);
        NSDictionary *subviews = NSDictionaryOfVariableBindings(contentView);
        
        
        for (UIView *view in [contentSubviews allValues]){
            [contentView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        for (UIView *view in [subviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [self addConstraint: [NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f constant:0.f]];
        
        [self addConstraint: [NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f constant:0.f]];

        
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"V:[contentView(60)]"];
        [TDUtils addVFLConstraintToView:self subviews:subviews format:@"H:|[contentView]|"];
        
        [TDUtils addVFLConstraintToView:contentView subviews:contentSubviews format:@"V:|[label]-[progressView]"];
        [TDUtils addVFLConstraintToView:contentView subviews:contentSubviews format:@"H:|-[label]-|"];
        [TDUtils addVFLConstraintToView:contentView subviews:contentSubviews format:@"H:|-[progressView]-|"];
        
        label.alpha = 0.0f;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundAlpha = 0.7;
            label.alpha = 1;
        }];

        
        }
    return self;
}

-(void) setBackgroundAlpha:(CGFloat)backgroundAlpha {
    
    _backgroundAlpha = backgroundAlpha;
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:_backgroundAlpha];
}

-(CGFloat) backgroundAlpha {
    return _backgroundAlpha;
}


@end
