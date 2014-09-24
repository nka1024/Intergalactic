//
//  TDExploreViewController.m
//  spaceman
//
//  Created by Admin on 9/9/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDExploreViewController.h"

@interface TDExploreViewController ()

@property (nonatomic, strong) NSArray* itemTitles;
@property (nonatomic, strong) NSArray* itemDetails;

@property (nonatomic) NSInteger lastSelection;

@end

@implementation TDExploreViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        
        self.exploreView = [[TDExploreView alloc] initWithDelegate:self];
        self.view = self.exploreView;
        
        [self.exploreView.backButton addTarget:self
                                       action:@selector(handleBackButton:)
                             forControlEvents:UIControlEventTouchUpInside];
        
        self.itemTitles = [NSArray arrayWithObjects:
                           NSLocalizedString(@"exploreVC_lifeFormsTitle", nil),
                           NSLocalizedString(@"exploreVC_lifeFormSubtitle", nil), nil];
        self.itemDetails = [NSArray arrayWithObjects:
                            NSLocalizedString(@"exploreVC_lifeResourcesTitle", nil),
                            NSLocalizedString(@"exploreVC_lifeResourcesSubtitle", nil),nil];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Handlers

-(void)handleGameUpdate:(id)notification {
    [self.exploreView populate:self.game];
    [self.exploreView.statsView populate:self.game];
}

-(void) handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleActionComplete {

    [self.game resetCharge];
    
    TDExplorationResult *result;
    NSString *message;
    
    if (self.lastSelection == 0) {
        result = [self.game nextLifeExploration];
        
        self.game.score += result.reward;
        
        if (result.reward % 10 == 2 ||
            result.reward % 10 == 4 ) {
             message = [NSString stringWithFormat:NSLocalizedString(@"exploreVC_actionCompletePopupSingular", nil), result.annotationText, result.reward];
        } else {
             message = [NSString stringWithFormat:NSLocalizedString(@"exploreVC_actionCompletePopupPlural", nil), result.annotationText, result.reward];
        }

    } else {
        result = [self.game nextResourceExploration];
        self.game.playerMoney += result.reward;
        message = result.annotationText;
    }
    
    if (result.storyData) {
        TDStoryViewController *cvc = [[TDStoryViewController alloc] initWithGame:self.game
                                                                           story:result.storyData
                                                                            page:0];
        [self.navigationController pushViewController:cvc animated:NO];
    }
    
    
    [TDUtils showStandartAlertTitle:result.annotationTitle message:message delegate:self];
    
}

-(void)launchHyperjumpAction {
    [[TDPopupManager sharedInstance] showModalPopup:self
                                               text:NSLocalizedString(@"exploreVC_hyperjump", nil)
                                               time:5
                                           selector:@selector(handleActionComplete)];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.lastSelection = indexPath.row;
    
    BOOL locked = NO;
    
    if (indexPath.row == 0) {
        locked = TD_DEBUG ? NO : [self.game getUpgradeTier:UPGRADE_RADAR_IDX] < 4;
    }
    
    if (!locked) {
        [self launchHyperjumpAction];
    } else {
        [TDUtils showStandartAlertTitle:NSLocalizedString(@"exploreVC_deniedPopupTitle", nil)
                                message:NSLocalizedString(@"exploreVC_deniedPopupMessage", nil)
                               delegate:nil];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.itemTitles count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TDMissionCell *cell = [[TDMissionCell alloc] initWithReuseIdentifier:@"missionCell"];
    
    cell.itemTitle.text = [self.itemTitles objectAtIndex:indexPath.row];
    cell.itemDescription.text = [self.itemDetails objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    if (indexPath.row == 0) {
        [cell.hrImage setHidden:YES];
        cell.itemDescription.textColor = [TDUtils blueColor];
    }
   
    return cell;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
