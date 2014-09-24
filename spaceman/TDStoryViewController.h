//
//  TDStoryViewController.h
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDViewController.h"

#import "TDViewController.h"
#import "TDStoryView.h"
#import "TDStoryCell.h"
#import "TDPopupManager.h"

@interface TDStoryViewController : TDViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

-(id)initWithGame:(TDGame *)game
            story:(TDStroyData *)story
             page:(NSInteger)page;

@end
