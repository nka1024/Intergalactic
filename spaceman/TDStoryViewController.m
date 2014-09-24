//
//  TDStoryViewController.m
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDStoryViewController.h"

@interface TDStoryViewController ()

@property (nonatomic, strong) TDActionView *modalView;
@property (nonatomic, strong) TDStoryView *storyView;

@property (nonatomic, strong) TDStroyData *story;
@property (nonatomic) NSInteger page;

@end

@implementation TDStoryViewController

- (id)initWithGame:(TDGame *)game
             story:(TDStroyData *)story
              page:(NSInteger)page {
    
    self = [super initWithGame:game];
    
    if (self) {
        self.story = story;
        self.page = page;
        
        self.storyView = [[TDStoryView alloc] initWithDelegate:self];
        self.view = self.storyView;

        [self.storyView populate:story page:page];
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated {
    [self.game suspendGameLoop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Do any additional setup after loading the view.
}


/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Handlers

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isLastStoryPage) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        self.page++;
        
        TDStoryViewController *storyViewController = [[TDStoryViewController alloc] initWithGame:self.game
                                                                                           story:self.story
                                                                                            page:self.page];
        [self.navigationController pushViewController:storyViewController animated:YES];
    }
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Helpers

-(BOOL)isLastStoryPage {
    return self.page + 1 >= self.story.pages.count;
}

-(TDStringWithMarks*)pageText {
    return [self.story.pages objectAtIndex:self.page];
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
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
    
    TDStoryCell *cell = [[TDStoryCell alloc] initWithReuseIdentifier:@"storyCell"];
    
    NSInteger pagesTotal = [self.story.pages count];
    NSInteger pageCount = self.page + 1;
    
    cell.itemTitle.text = self.isLastStoryPage ? self.story.returnText :NSLocalizedString(@"storyView_next", nil);
    cell.itemDescription.text = [NSString stringWithFormat:NSLocalizedString(@"storyView_pages", nil), pageCount, pagesTotal];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

/////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Util

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
