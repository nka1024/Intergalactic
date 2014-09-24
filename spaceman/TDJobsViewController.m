//
//  TDJobsViewController.m
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDJobsViewController.h"

@interface TDJobsViewController ()

@property (strong, nonatomic) TDJobsView *jobsView;
@property (nonatomic) BOOL qualified;

@end

@implementation TDJobsViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        
        TDJobsView *jobsView = [[TDJobsView alloc] init];
        
        self.view = self.jobsView = jobsView;
        
        self.jobsView.submitButton.hidden = YES;
        
        [jobsView.backButton addTarget:self
                                action:@selector(handleBackButton:)
                      forControlEvents:UIControlEventTouchUpInside];
        
        [jobsView.submitButton addTarget:self
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
    [self.jobsView.statsView populate:self.game];
}

-(void)handleSearchComplete{
    
    TDJobData *availableJob = self.game.getAvailableJob;
    if (availableJob) {
        
        [self.jobsView setJobTitle:availableJob.title];
        [self.jobsView setJobBody:availableJob.info salary:availableJob.salary];
        
        self.jobsView.submitButton.hidden = NO;
        
    } else {
        [self.jobsView setNoJobsAvailable];
        
        self.jobsView.submitButton.hidden = YES;
    }
}

-(void)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleSubmitButton:(id)sender {
    
    BOOL qualified;
    
    switch (self.game.playerJobIdx) {
        case 0:
            qualified = [self.game getUpgradeTier:UPGRADE_HULL_IDX] >= 1;
            break;
        case 1:
            qualified = [self.game getUpgradeTier:UPGRADE_ENGINE_IDX] >= 2;
            break;
        case 2:
            qualified = [self.game getUpgradeTier:UPGRADE_SHIELD_IDX] >= 3;
            break;
            
        case 3:
            qualified = [self.game getUpgradeTier:UPGRADE_WEAPON_IDX] >= 4;
            break;
            
        case 4:
            qualified = [self.game getUpgradeTier:UPGRADE_HULL_IDX] >= 5;
            break;
            
        case 5:
            qualified = [self.game getUpgradeTier:UPGRADE_WEAPON_IDX] >= 6;
            break;
        case 6:
            qualified = [self.game getUpgradeTier:UPGRADE_HULL_IDX] >= 7;
            break;
        
            
        default:
            qualified = true;
    }
    
    self.qualified = qualified;
    UIAlertView *alertView;
    
    if (qualified) {
        [self.game applyNextJob];
        
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"jobsVC_newJobPopupTitle", nil)
                                               message:self.game.playerJob.greeting
                                              delegate:self
                                     cancelButtonTitle:NSLocalizedString(@"jobsVC_newJobPopupButton", nil)
                                     otherButtonTitles:nil];
    } else {
        NSString *message;
        
        if (self.game.playerJobIdx == 0) {
            message = NSLocalizedString(@"jobsVC_denyPopupMessage1", nil);
        } else {
            message = NSLocalizedString(@"jobsVC_denyPopupMessage2", nil);
        }
        alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"jobsVC_denyPopupTitle", nil)
                                               message:message
                                              delegate:self
                                     cancelButtonTitle:NSLocalizedString(@"jobsVC_denyPopupButton", nil)
                                     otherButtonTitles:nil];
    }
    
    [alertView show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (self.qualified){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers

-(void)startSearchAction {
    [[TDPopupManager sharedInstance] showModalPopup:self
                                         text:NSLocalizedString(@"jobsVC_searching", nil)
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
