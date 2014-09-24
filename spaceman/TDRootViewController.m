//
//  TDRootViewController.m
//  spaceman
//
//  Created by Admin on 8/18/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDRootViewController.h"

@interface TDRootViewController ()

@property (nonatomic, strong) TDRootView *rootView;
@property (nonatomic, strong) NSArray* itemTitles;
@property (nonatomic, strong) NSMutableArray* itemDetails;

@end

@implementation TDRootViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        
        self.rootView = [[TDRootView alloc] initWithDelegate:self];
        self.view = self.rootView;
        
        self.itemTitles = [NSArray arrayWithObjects:
                           NSLocalizedString(@"rootVC_menuItemTitle1", nil),
                           NSLocalizedString(@"rootVC_menuItemTitle2", nil),
                           NSLocalizedString(@"rootVC_menuItemTitle3", nil),
                           NSLocalizedString(@"rootVC_menuItemTitle4", nil),
                           NSLocalizedString(@"rootVC_menuItemTitle5", nil),
                           NSLocalizedString(@"rootVC_menuItemTitle6", nil), nil];
        self.itemDetails = [NSMutableArray arrayWithObjects:
                            NSLocalizedString(@"rootVC_menuItemSubtitle1", nil),
                            NSLocalizedString(@"rootVC_menuItemSubtitle2", nil),
                            NSLocalizedString(@"rootVC_menuItemSubtitle3", nil),
                            NSLocalizedString(@"rootVC_menuItemSubtitle4", nil),
                            NSLocalizedString(@"rootVC_menuItemSubtitle5", nil),
                            NSLocalizedString(@"rootVC_menuItemSubtitle6", nil), nil];
        
    }
    return self;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Handlers

-(void)handleGameUpdate:(id)notification {

    [super handleDayChange:notification];
    
    if (self.game.won) {
        [self.rootView setGameWon];
    } else{
        [self.rootView setDateTime:self.game.timestamp];
    }
    [self.rootView.statsView populate:self.game];
    
    [self.itemDetails replaceObjectAtIndex:1 withObject:self.game.playerJob.title];
    
    if (![self isLockedRow:5]) {
        [self.itemDetails replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:NSLocalizedString(@"rootVC_menuItemSubtitle2", nil), (long)self.game.health]];
    }
    
    if (self.game.score >= 999) {
        if (!self.game.won) {
            self.game.won = true;
            [TDUtils showStandartAlertTitle:NSLocalizedString(@"rootVC_finalPopupTitle", nil)
                                    message:NSLocalizedString(@"rootVC_finalPopupMessafe", nil)
                                   delegate:nil];
            
        }
    }
}

-(void)handleDayChange:(id)notification {
    [super handleDayChange:notification];
    [self.rootView.tableView reloadData];
}

-(void)handleGameover:(id)notification {
    
    [self.game endGame];
    
    [TDUtils showStandartAlertTitle:NSLocalizedString(@"rootVC_gameoverPopupTitle", nil)
                            message:NSLocalizedString(@"rootVC_gameoverPopupMessage", nil)
                           delegate:nil];
    
    TDMenuScreenViewController *menuViewController = [[TDMenuScreenViewController alloc] init];
    
    [self.navigationController pushViewController:menuViewController animated:NO];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TableView delegate

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
    return 48;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *cvc;
    
    BOOL qualified = ![self isLockedRow:indexPath.row];
    
    if (indexPath.row == 0) {
        cvc = [[TDEquipmentViewController alloc] initWithGame:self.game];
    }
    else if (indexPath.row == 2) {
      
        if (qualified) {
            cvc = [[TDExploreViewController alloc] initWithGame:self.game];
        } else {
            [TDUtils showStandartAlertTitle:NSLocalizedString(@"rootVC_denyExplorePopupTitle", nil)
                                    message:NSLocalizedString(@"rootVC_denyExplorePopupMessage", nil)
                                   delegate:nil];
        }
    }
    else if (indexPath.row == 3) {
        
        
        if (qualified) {
            cvc = [[TDContractsViewController alloc] initWithGame:self.game];
        } else {
            if (self.game.health > 15) {
                [TDUtils showStandartAlertTitle:NSLocalizedString(@"rootVC_denyContractPopupTitle1", nil)
                                        message:NSLocalizedString(@"rootVC_denyContractPopupMessage1", nil)
                                       delegate:nil];
            } else {
                [TDUtils showStandartAlertTitle:NSLocalizedString(@"rootVC_denyContractPopupTitle2", nil)
                                        message:NSLocalizedString(@"rootVC_denyContractPopupMessage2", nil)
                                       delegate:nil];
            }
        }
    }
    else if (indexPath.row == 4) {
        cvc = [[TDInformationViewController alloc]  initWithGame:self.game];
    }
    else if (indexPath.row == 1) {
        cvc = [[TDJobsViewController alloc]  initWithGame:self.game];
    }
    else if (indexPath.row == 5) {
        if (qualified) {
            cvc = [[TDHangarViewController alloc] initWithGame:self.game];
        } else {
            [TDUtils showStandartAlertTitle:NSLocalizedString(@"rootVC_denyHangarPopupTitle", nil)
                                    message:NSLocalizedString(@"rootVC_denyHangarPopupMessage", nil)
                                   delegate:nil];
        }
    }
    
    if (cvc) {
        [self.navigationController pushViewController:cvc animated:YES];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TDRootCell *cell = [[TDRootCell alloc] initWithReuseIdentifier:@"itemCell"];
    
    if ([self isLockedRow:indexPath.row]) {
        cell.itemTitle.textColor = [TDUtils darkGreyColor];
        cell.itemDescription.textColor = [TDUtils darkBlueColor];
    }
    
    cell.itemTitle.text = [self.itemTitles objectAtIndex:indexPath.row];
    cell.itemDescription.text = [self.itemDetails objectAtIndex:indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers

-(BOOL)isLockedRow:(NSInteger)idx {
    
    BOOL locked;
    
    switch (idx) {
        case 2:
            locked = TD_DEBUG ? NO : [self.game getUpgradeTier:UPGRADE_ENGINE_IDX] < 1;
            break;
        case 3:
            locked = TD_DEBUG ? NO : ((self.game.score < 10) || (self.game.health <= 15));  // TODO: pilot status
            break;
        case 5:
            locked = TD_DEBUG ? NO : [self.game getUpgradeTier:UPGRADE_HULL_IDX] < 1;
            break;
        default:
            locked = false;
            break;
    }
        
    return locked;
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [self.rootView.statsView populate:self.game];
    [self.rootView populate:self.game];
    
    [self.game resumeGameLoop];
    [self.rootView.tableView reloadData];
    
    if (self.game.firstDay) {
        self.game.firstDay = NO;
        TDStoryViewController *cvc = [[TDStoryViewController alloc]  initWithGame:self.game
                                                                            story:[TDData sharedInstance].introStory
                                                                             page:0];
        [self.navigationController pushViewController:cvc animated:NO];
    }
}

@end
