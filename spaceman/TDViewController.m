//
//  TDViewController.m
//  spaceman
//
//  Created by Admin on 9/9/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDViewController.h"


@implementation TDViewController

- (id)initWithGame:(TDGame *) game
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        
        self.game = game;
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleGameUpdate:)
                                                     name:GAME_UPDATE_NOTIFICATION
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleDayChange:)
                                                     name:GAME_DAY_CHANGED_NOTIFICATION
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleGameover:)
                                                     name:GAME_GAMEOVER_NOTIFICATION
                                                   object:nil];
        
    }
    
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self handleGameUpdate:nil];
}


-(void)handleGameUpdate:(id)notification {
    
}

-(void)handleDayChange:(id)notification {
    
}

-(void)handleGameover:(id)notification {
    
}

@end
