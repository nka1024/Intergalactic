//
//  TDEquipmentViewController.m
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDContractsViewController.h"

@interface TDContractsViewController ()
@property (strong, nonatomic) TDContractsView *contractsView;
@property (strong, nonatomic) TDContractData *contract;
@end

@implementation TDContractsViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithGame:game];
    if (self) {
        // Custom initialization
        
        self.contractsView = [[TDContractsView alloc] init];
        self.view = self.contractsView;
        
        [self.contractsView.backButton addTarget:self
                                          action:@selector(handleBackButton:)
                                forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contractsView.refreshButton addTarget:self
                                             action:@selector(handleRefreshButton:)
                                   forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.contractsView.submitButton addTarget:self
                                            action:@selector(handleSubmitButton:)
                                  forControlEvents:UIControlEventTouchUpInside];
        
        [self.contractsView.statsView populate:self.game];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    NSString *price = [NSString stringWithFormat:NSLocalizedString(@"contractsVC_price", nil), [TDUtils formatedNumber:self.game.searchFee]];
    TDStringWithMarks *label = [TDStringWithMarks stringWithText:[NSString stringWithFormat:NSLocalizedString(@"contractsVC_message", nil), price] marks:price, nil];
    
    [self.contractsView popuplateWithNoContractText:label];

}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Handlers

-(void)handleGameUpdate:(id)notification {
    [self.contractsView.statsView populate:self.game];
}

-(void)handleBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleRefreshButton:(id)sender {

    if (self.game.playerMoney >= self.game.searchFee) {
        [self startSearchAction];
        self.game.playerMoney -= self.game.searchFee;
    } else {
        [TDUtils showStandartAlertTitle:NSLocalizedString(@"contractsVC_denyTitle", nil)
                                message:NSLocalizedString(@"contractsVC_denyMessage", nil)
                               delegate:nil];
    }
}

-(void)handleSubmitButton:(id)sender {

    UIViewController *cvc;
    if (self.contract.type == TDContractTypeMining) {
        cvc = [[TDMiningMissionViewController alloc] initWithGame:self.game contract:self.contract];
    } else {
        cvc = [[TDMissionViewController alloc] initWithGame:self.game contract:self.contract];
    }
    [self.navigationController pushViewController:cvc animated:YES];
    
}

-(void)handleSearchComplete {
    
    self.contract = nil;
    
    if ([TDUtils trueWithChance:0.1]) {
        [self.contractsView popuplateWithNoContractText:[TDStringWithMarks stringWithText:NSLocalizedString(@"contractsVC_failedSearch", nil) marks:nil]];
    }
    else {
        TDStringWithMarks *text;
        NSString *title;
        
        self.contract = [self.game randomContract];
        long level = self.contract.level + 1;
        
        if (self.contract.type == TDContractTypeMining) {
            title = [NSString stringWithFormat:NSLocalizedString(@"contractsVC_searchResultOreTitle", nil), self.contract.subject];
            
            text = [TDStringWithMarks stringWithText:[NSString stringWithFormat:NSLocalizedString(@"contractsVC_searchResultOreMessage", nil), self.contract.subject, level]
                                              marks:[NSString stringWithFormat:NSLocalizedString(@"contractsVC_searchResultOreMark", nil), level],self.contract.subject, nil];
        } else {
            title = NSLocalizedString(@"contractsVC_searchResultTradeTitle", nil);
            
            text = [TDStringWithMarks stringWithText:[NSString stringWithFormat:NSLocalizedString(@"contractsVC_searchResultTradeMessage", nil),self.contract.subject, level]
                                               marks:[NSString stringWithFormat:NSLocalizedString(@"contractsVC_searchResultTradeMark", nil), level], self.contract.subject,nil];
        }
        
        [self.contractsView popuplateWithContractTitle:title info:text reward:self.contract.reward];
    }
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers
    

-(void)startSearchAction {
    
    [[TDPopupManager sharedInstance] showModalPopup:self
                                         text:NSLocalizedString(@"contractsVC_searching", nil)
                                         time:7
                                     selector:@selector(handleSearchComplete)];
    
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
