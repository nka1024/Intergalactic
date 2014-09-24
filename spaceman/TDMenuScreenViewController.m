//
//  TDMenuScreenControllerViewController.m
//  spaceman
//
//  Created by Admin on 9/14/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDMenuScreenViewController.h"

@interface TDMenuScreenViewController ()

@property (nonatomic, strong) NSArray* itemTitles;

@property (nonatomic) NSInteger lastSelection;
@property (nonatomic, strong) NSString *pilotName;
@property (nonatomic) BOOL newGame;

@end

@implementation TDMenuScreenViewController

- (id)init
{
    self = [super init];
    if (self) {
        
        self.menuScreenView = [[TDMenuScreenView alloc] initWithDelegate:self];
        self.view = self.menuScreenView;
        
        NSMutableArray *items = [[NSMutableArray alloc] init];
       

        [items insertObject:[TDStringWithMarks stringWithText:NSLocalizedString(@"menuScreen_newGame", nil)
                                                        marks:NSLocalizedString(@"menuScreen_newGameHighlight", nil), nil]
                    atIndex:items.count];
        if ([TDDataStorage sharedInstance].timestamp > 0) {
            [items insertObject:[TDStringWithMarks stringWithText:NSLocalizedString(@"menuScreen_resume", nil)
                                                            marks:NSLocalizedString(@"menuScreen_resumeHighlight", nil) , nil]
                        atIndex:items.count];
        }
        
        self.itemTitles = items;
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

-(void) handleActionComplete{
    
    TDGame *game;
    if (self.newGame) {
        game = [[TDGame alloc] initNewGameWithPilotName:self.pilotName];
    } else {
        game = [[TDGame alloc] initLoadedGame];
    }
    
    TDRootViewController *rootViewController = [[TDRootViewController alloc] initWithGame:game];
    [self.navigationController setViewControllers:@[rootViewController]];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        self.pilotName = textField.text;
        
        if (self.pilotName.length < 3 || self.pilotName.length > 24) {
            [self repeatNameAlert];
        } else {
            [self launchLoadAnimation];
        }
    }
    
}

-(void)playerNameAlert {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"menuScreen_newGamePopupTitle", nil)
                                                     message:NSLocalizedString(@"menuScreen_newGamePopupMessage", nil)
                                                    delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"menuScreen_newGamePopupCancel", nil)
                                           otherButtonTitles:NSLocalizedString(@"menuScreen_newGamePopupOk", nil),nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)repeatNameAlert {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"menuScreen_wrongNamePopupTitle", nil)
                                                     message:NSLocalizedString(@"menuScreen_wrongNamePopupMessage", nil)
                                                    delegate:self
                                           cancelButtonTitle:NSLocalizedString(@"menuScreen_wrongNamePopupCancel", nil)
                                           otherButtonTitles:NSLocalizedString(@"menuScreen_wrongNamePopupOk", nil),nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.lastSelection = indexPath.row;
    
    if (indexPath.row == 0) {
        self.newGame = true;
        [self playerNameAlert];
    } else {
        self.newGame = false;
        
        [self launchLoadAnimation];
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
    
    TDMenuCell *cell = [[TDMenuCell alloc] initWithReuseIdentifier:@"missionCell"];
    
    cell.isNewGame= indexPath.row == 0;
    [cell setCaptionText:[self.itemTitles objectAtIndex:indexPath.row]];
    


    cell.backgroundColor = [UIColor clearColor];

    
    return cell;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers

-(void)launchLoadAnimation {
    [[TDPopupManager sharedInstance] showModalPopup:self
                                               text:NSLocalizedString(@"menuScreen_Loading", nil)
                                               time:2
                                           selector:@selector(handleActionComplete)];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

@end
