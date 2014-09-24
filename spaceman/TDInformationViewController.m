//
//  TDInformationViewController.m
//  Интергалактик
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDInformationViewController.h"

@interface TDInformationViewController ()

@property (strong, nonatomic) TDInformationView *informationView;

@end

@implementation TDInformationViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        
        TDInformationView *informationView = [[TDInformationView alloc] init];
        
        self.view = self.informationView = informationView;
        
        self.informationView.submitButton.hidden = YES;
        
        [informationView.backButton addTarget:self
                                action:@selector(handleBackButton:)
                      forControlEvents:UIControlEventTouchUpInside];
        
        [informationView.submitButton addTarget:self
                                  action:@selector(handleSubmitButton:)
                        forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self startSearchAction];
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Handlers

-(void)handleGameUpdate:(id)notification {
    [super handleGameUpdate:notification];
    [self.informationView.statsView populate:self.game];
}

-(void)handleSearchComplete{
    self.informationView.submitButton.hidden = NO;
    [self.informationView populate:self.game];
}

-(void)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleSubmitButton:(id)sender {
    [self startSearchAction];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers

-(void)startSearchAction {
    [[TDPopupManager sharedInstance] showModalPopup:self
                                               text:NSLocalizedString(@"information_requesting", nil)
                                               time:1
                                           selector:@selector(handleSearchComplete)];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
