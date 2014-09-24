//
//  TDHangarViewController.m
//  spaceman
//
//  Created by Admin on 9/7/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDHangarViewController.h"

@implementation TDHangarViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        
        self.hangarView = [[TDHangarView alloc] init];
        self.view = self.hangarView;
        
        [self.hangarView.backButton addTarget:self
                                       action:@selector(handleBackButton:)
                             forControlEvents:UIControlEventTouchUpInside];
        
        [self.hangarView.repairButton addTarget:self
                                       action:@selector(handleRepairButton:)
                             forControlEvents:UIControlEventTouchUpInside];
        
        [self.hangarView.droidsButton addTarget:self
                                         action:@selector(handleDroidButton:)
                               forControlEvents:UIControlEventTouchUpInside];
        
        
        long hullTier = [game getUpgradeTier:UPGRADE_HULL_IDX];
        NSString *shipImageName = [NSString stringWithFormat:@"ship_model%ld.png", hullTier];
        [self.hangarView.image setImage:[UIImage imageNamed:shipImageName]];
        [self.hangarView.image setHidden:NO];

    }
    return self;
}

-(void)handleGameUpdate:(id)notification {
    [self.hangarView populate:self.game];
    [self.hangarView.statsView populate:self.game];
}

-(void) handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) handleDroidButton:(id)sender {
//    [self.navigationController pushViewController:droidsViewController animated:YES];
}

-(void) handleRepairButton:(id)sender  {
    
    if (self.game.playerMoney >= self.game.repairPrice) {
        
        self.game.playerMoney -= self.game.repairPrice;
        [self.game restoreHealth];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"hangarVC_repairPopupTitle", nil)
                                                            message:NSLocalizedString(@"hangarVC_repairPopupMessage", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"hangarVC_repairPopupButton", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"hangarVC_denyPopupTitle", nil)
                                                            message:NSLocalizedString(@"hangarVC_denyPopupMessage", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"hangarVC_denyPopupButton", nil)
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
