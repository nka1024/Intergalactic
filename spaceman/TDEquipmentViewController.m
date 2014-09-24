//
//  TDEquipmentViewController.m
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDEquipmentViewController.h"

@interface TDEquipmentViewController ()

@property (nonatomic) NSInteger lastSelection;
@property (nonatomic, strong) NSArray * itemTitles;
@property (nonatomic, strong) TDActionView *modalView;
@property (nonatomic, strong) TDEquipmentView *equipmentView;
@property (nonatomic, strong)  NSTimer *timer;

@end

@implementation TDEquipmentViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        
        self.equipmentView = [[TDEquipmentView alloc] initWithDelegate:self];
        self.view = self.equipmentView;
        
        [self.equipmentView.backButton addTarget:self action:@selector(handleBackButton:) forControlEvents:UIControlEventTouchUpInside];
        
        self.itemTitles = [NSArray arrayWithObjects:
                           NSLocalizedString(@"equipmentVC_menuItemTitle1", nil),
                           NSLocalizedString(@"equipmentVC_menuItemTitle2", nil),
                           NSLocalizedString(@"equipmentVC_menuItemTitle3", nil),
                           NSLocalizedString(@"equipmentVC_menuItemTitle4", nil),
                           NSLocalizedString(@"equipmentVC_menuItemTitle5", nil),
                           NSLocalizedString(@"equipmentVC_menuItemTitle6", nil),nil];
        
       [self.equipmentView.statsView populate:self.game];
    }
    return self;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Handlers

-(void)handleGameUpdate:(id)notification {
    
    [self.equipmentView.statsView populate:self.game];
    
}

-(void)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleActionComplete {
    
    NSNumber *system = [NSNumber numberWithInteger:self.lastSelection];
    BOOL firstTier = [self.game getUpgradeTier:system] == 0;
    BOOL isHullUpgrade = [system isEqualToNumber:UPGRADE_HULL_IDX];
    
    [self.game applyNextUpgrade:system];
    
    NSString *systemName = [[self.itemTitles objectAtIndex:self.lastSelection] lowercaseString];
    NSString *upgrade = [self.game getUpgrade:system].name;
    NSString *message = [NSString stringWithFormat:@"%@ %@", upgrade, isHullUpgrade ? @"" : systemName];
    NSString *title;
    
    if (([self.game getUpgradeTier:system]*2)%10 == 2 ||
        ([self.game getUpgradeTier:system]*2)%10 == 4 ) {
        message = [NSString stringWithFormat:NSLocalizedString(@"exploreVC_actionCompletePopupSingular", nil), message, (long)[self.game getUpgradeTier:system]*2];
    } else {
        message = [NSString stringWithFormat:NSLocalizedString(@"exploreVC_actionCompletePopupPlural", nil), message, (long)[self.game getUpgradeTier:system]*2];
    }
    
    if (isHullUpgrade) {
        title = NSLocalizedString(@"equipmentVC_donePopupNewShipTitle", nil);
    } else {
        title = firstTier ? NSLocalizedString(@"equipmentVC_donePopupNewDeviceTitle", nil) : NSLocalizedString(@"equipmentVC_donePopupUpgradeDeviceTitle", nil);
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    
    [self.equipmentView.tableView reloadData];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.lastSelection = indexPath.row;
    
    NSNumber *system = [NSNumber numberWithInteger:indexPath.row];
    
    if (![system isEqualToNumber:UPGRADE_HULL_IDX] && [self.game getUpgradeTier:UPGRADE_HULL_IDX] == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"equipmentVC_denyPopupNoShipTitle", nil)
                                                            message:NSLocalizedString(@"equipmentVC_denyPopupNoShipMessage", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"equipmentVC_denyPopupNoShipButton", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else if ([self.game canBuyUpgrade:system]) {
        
        BOOL firstTier = [self.game getUpgradeTier:system] == 0;
        NSString *text;
        
        
        if ([system isEqualToNumber:UPGRADE_HULL_IDX]) {
            text = NSLocalizedString(@"equipmentVC_actionBuyingShip", nil);
            [self.game restoreHalfHealth];
        } else {
            text = firstTier ? NSLocalizedString(@"equipmentVC_actionBuyingDevice", nil) : NSLocalizedString(@"equipmentVC_actionUpgradingDevice", nil);
        }
        
        
        [[TDPopupManager sharedInstance] showModalPopup:self
                                             text:text
                                             time:2
                                         selector:@selector(handleActionComplete)];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"equipmentVC_denyPopupNoMoneyTitle", nil)
                                                            message:NSLocalizedString(@"equipmentVC_denyPopupNoMoneyMessage", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"equipmentVC_denyPopupNoMoneyButton", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
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
    return 48;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TDEquipmentCell *cell = [[TDEquipmentCell alloc] initWithReuseIdentifier:@"equipmentCell"];
    
    NSNumber *system = [NSNumber numberWithInteger:indexPath.row];
    
    cell.itemTitle.text = [self.itemTitles objectAtIndex:indexPath.row];
    cell.itemDescription.text = [self.game getUpgrade:system].name;
    
    TDUpgradeData *availableUpgrade = [self.game getAvailableUpgrade:system];

    if (availableUpgrade) {
        NSString *upgradePrice =[TDUtils formatedNumber:availableUpgrade.price];
        cell.itemPrice.text = [NSString stringWithFormat:@"¥ %@", upgradePrice];

        NSInteger upgradeLvl = [self.game getUpgradeTier:system];
        
        if (upgradeLvl > 0) {
            cell.itemUpgrade.text = [NSString stringWithFormat:NSLocalizedString(@"equipmentVC_cellModernization", nil), upgradeLvl];
        } else {
            cell.itemUpgrade.text = NSLocalizedString(@"equipmentVC_cellBuy", nil);
        }
    } else {
        cell.itemPrice.text = @"";
        cell.itemUpgrade.text = NSLocalizedString(@"equipmentVC_cellPerfect", nil);
    }

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.equipmentView.tableView setContentInset:UIEdgeInsetsZero];
}

@end
