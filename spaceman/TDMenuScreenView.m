//
//  TDMenuScreenView.m
//  spaceman
//
//  Created by Admin on 9/14/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDMenuScreenView.h"

@implementation TDMenuScreenView

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource>)delegate{
    self = [super init];
    if (self) {
        // droid Image
        
        self.backgroundColor = [TDUtils whiteColor];
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_bg.png"]];
//                UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"horizontalLine.png"]];
        [image setContentMode:UIViewContentModeCenter];
                [image setContentMode:UIViewContentModeTop];
        
        //        [image setHidden:YES];
        //        [image setImage:[UIImage imageNamed:@"horizontalLine.png"]];
        
        self.image = image;
        
        
        // table view
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView = tableView;
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.alwaysBounceVertical = NO;
        
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(image, tableView);
        
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
//        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[textLabel]-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[tableView]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|[image]|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-[image]|"];

        if ([TDUtils isSmallScreen]) {
            [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-100-[tableView(120)]"];
        }else {
            [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:[tableView(120)]-40-|"];
        }
        
    }
    
    return self;
}
@end
