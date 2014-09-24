//
//  TDMiningMissionViewController.m
//  Интергалактик
//
//  Created by Admin on 9/17/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDMiningMissionViewController.h"

@interface TDMiningMissionViewController ()

@property (nonatomic, strong) NSArray* itemTitles;

@property (nonatomic, strong) TDContractData *contract;

@property (nonatomic, strong) TDMissionView *missionView;
@property (nonatomic) NSInteger currentTurnIdx;

@property (nonatomic, strong) NSString *text;
@end

typedef enum {
    TURN_FIND_ASTEROID = 0,
    
    TURN_START_MINING,
    
    TURN_REPAIR_DROID,
    TURN_REPAIR_SUCCESS,
    TURN_REPAIR_FAIL,
    
    TURN_COMPLETE_SUCCESS
    
} MINING_TURNS;



@implementation TDMiningMissionViewController

- (id)initWithGame:(TDGame *)game contract:(TDContractData *)contract {
    return [self initWithGame:game contract:contract turn:0];
}

- (id)initWithGame:(TDGame *) game contract:contract turn:(NSInteger)turnIdx
{
    self = [super initWithGame:game];
    if (self) {
        
        self.missionView = [[TDMissionView alloc] initWithDelegate:self];
        self.view = self.missionView;
        self.contract = contract;
        self.currentTurnIdx = turnIdx;
        
        if (turnIdx == TURN_FIND_ASTEROID) {
            [self processMeteorDamage];
        }
        
        
        
        NSMutableArray *actions = [[NSMutableArray alloc] init];
        
        switch (self.currentTurnIdx) {
                
            case TURN_FIND_ASTEROID:
                
                self.text = [NSString stringWithFormat:NSLocalizedString(@"minigLine1", nil), self.contract.subject];
                break;
                
            case TURN_START_MINING:
                self.text = NSLocalizedString(@"minigLine2", nil);
                break;
                
                
            case TURN_REPAIR_DROID:

                if ([game isCharacterUnlocked:CHARACTER_REPAIR_DROID]) {
                    [actions insertObject:NSLocalizedString(@"minigButton1", nil) atIndex:actions.count];
                     self.text = NSLocalizedString(@"minigLine3", nil);
                } else {
                    [actions insertObject:NSLocalizedString(@"minigButton2", nil) atIndex:actions.count];
                    self.text = NSLocalizedString(@"minigLine4", nil);
                }
                
                break;
                
            case TURN_REPAIR_SUCCESS:
                self.text = NSLocalizedString(@"minigLine5", nil);
                break;
                
            case TURN_COMPLETE_SUCCESS:
                self.text = NSLocalizedString(@"minigLine6", nil);
                
            default:
                break;
        }
        
        if (actions.count == 0) {
            [actions insertObject:NSLocalizedString(@"minigButton3", nil) atIndex:actions.count];
        }
        
        self.itemTitles = actions;
        
        [self.missionView populateWithText:self.text];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [self.game suspendGameLoop];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}



/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger nextTurn = 0;
    long long profit = 0;
//    NSInteger idx = indexPath.row;

    BOOL finalPage = NO;
    
    switch (self.currentTurnIdx) {
            
        case TURN_FIND_ASTEROID:
            nextTurn = TURN_START_MINING;
            
           
            break;
            
        case TURN_START_MINING:
            nextTurn = [TDUtils trueWithChance:0.5] ?TURN_COMPLETE_SUCCESS : TURN_REPAIR_DROID;
            break;
        case TURN_REPAIR_DROID:
            if ([self.game isCharacterUnlocked:CHARACTER_REPAIR_DROID]) {
                nextTurn = TURN_REPAIR_SUCCESS;
            } else {
                [TDUtils showStandartAlertTitle:NSLocalizedString(@"minig_popupFailTitle", nil)
                                        message:NSLocalizedString(@"minig_popupFailMessage", nil)                                                                  delegate:nil];
                finalPage = YES;
            }
            
            break;
            
        case TURN_REPAIR_SUCCESS:
            nextTurn = TURN_COMPLETE_SUCCESS;
            break;
         
        case TURN_COMPLETE_SUCCESS:
            
            profit = self.contract.reward;
            
            [TDUtils showStandartAlertTitle:NSLocalizedString(@"minig_popupSuccessTitle", nil)
                                    message:[NSString stringWithFormat:NSLocalizedString(@"minig_popupSuccessMessage",nil), [TDUtils formatedNumber:profit]]
                                   delegate:nil];
            
            self.game.playerMoney += profit;

            finalPage = YES;
            break;
            
        default:
            
            break;
    }
    
    if (finalPage) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        TDMiningMissionViewController *missionViewController = [[TDMiningMissionViewController alloc] initWithGame:self.game
                                                                                                          contract:self.contract
                                                                                                              turn:nextTurn];
        
        [self.navigationController pushViewController:missionViewController animated:YES];
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
    
    if ([self.itemTitles count] > 1) {
        cell.itemDescription.text = NSLocalizedString(@"minig_popupSuccessChance",nil);
        if (indexPath.row == 0) {
            [cell.hrImage setHidden:YES];
        }
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers


-(void)processMeteorDamage {
    
    long hullDamage = 0;
    NSString *text ;
    
    
    if ([self.game getUpgradeTier:UPGRADE_SHIELD_IDX] < self.contract.level) {
        hullDamage = (self.contract.level - [self.game getUpgradeTier:UPGRADE_SHIELD_IDX]) * 20;
        text = NSLocalizedString(@"mining_heavyDamagePopupMessage", nil);
    }
    else {
        hullDamage = 5;
        text = NSLocalizedString(@"mining_lightDamagePopupMessage", nil);
    }
  
    if (self.game.health - hullDamage < 15 ) {
        hullDamage = self.game.health - 15;
    }
    
    [self.game decreaseHealthByPercent:hullDamage/100.0];

    
    [TDUtils showStandartAlertTitle:NSLocalizedString(@"mining_damagePopupTitle", nil)
                            message:[NSString stringWithFormat:text, hullDamage]
                           delegate:nil];

}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
