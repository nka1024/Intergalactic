//
//  TDPopupManager.m
//  spaceman
//
//  Created by Admin on 9/6/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDPopupManager.h"

@interface TDPopupManager()

@property (strong, nonatomic) TDActionView *currentPopup;
@property (strong, nonatomic) id currentTarget;
@property (nonatomic) SEL currentSelector;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) NSInteger timeout;

@end


@implementation TDPopupManager

+(instancetype) sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

-(void)showModalPopup:(UIViewController *) target
                 text:(NSString *) text
                 time:(NSInteger) time
             selector:(SEL) selector {
    
    TDActionView *popup = [[TDActionView alloc] initWithText:text];
    
    self.currentTarget = target;
    self.currentSelector = selector;
    self.currentPopup = popup;
    self.timeout = time;
    
    [target.view addSubview:popup];
    
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.01f
                                                  target: self
                                                selector: @selector(updateActionProgress)
                                                userInfo: nil
                                                repeats: YES];
}


- (void)updateActionProgress {
    if (self.currentPopup.progressView.progress >= 1.0) {
        [self.timer invalidate];
        
        [self.currentPopup removeFromSuperview];
        [self.currentTarget performSelector:self.currentSelector];
        
        self.currentPopup = nil;
        self.currentSelector = nil;
        self.currentTarget = nil;
        
    }
    self.currentPopup.progressView.progress += 0.01f/self.timeout;
}


@end
