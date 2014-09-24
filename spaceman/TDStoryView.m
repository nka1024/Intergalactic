//
//  TDStoryView.m
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDStoryView.h"

@implementation TDStoryView

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];

        UILabel *statusLeftLabel = [[UILabel alloc] init];
        statusLeftLabel.font = [TDUtils tinyFont];
        statusLeftLabel.textColor = [TDUtils whiteColor];
        statusLeftLabel.text = @"Найти корабль пирата:\nУничтожить пирата:";
        statusLeftLabel.textAlignment = NSTextAlignmentLeft;
        statusLeftLabel.numberOfLines = 4;
        
        
        UILabel *statusRightLabel = [[UILabel alloc] init];
        statusRightLabel.font = [TDUtils tinyFont];
        statusRightLabel.textColor = [TDUtils blueColor];
        statusRightLabel.text = @"не выполнено\nне выполнено";
        statusRightLabel.textAlignment = NSTextAlignmentLeft;
        statusRightLabel.numberOfLines = 4;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 50;
        
        self.statusLeftLabel = statusLeftLabel;
        self.statusRightLabel = statusRightLabel;
        self.textLabel = textLabel;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.tintColor = [TDUtils whiteColor];
        progressView.trackTintColor = [UIColor clearColor];
        progressView.progressViewStyle = UIProgressViewStyleBar;
        progressView.progress = 0.0;
        self.progressView = progressView;
        

        // droid Image
        
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ship_model1.png"]];
        [image setContentMode:UIViewContentModeCenter];

        [image setHidden:YES];
        [image setImage:[UIImage imageNamed:@"horizontalLine.png"]];
        
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
        
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(textLabel, image, tableView);

        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[textLabel]-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[tableView]-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[image]-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-40-[textLabel]-40-[image]-[tableView]|"];
    }
    return self;
}
-(void)setTextBody:(TDStringWithMarks *)text style:(int)style{
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = style == 1? NSTextAlignmentJustified : NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: [TDUtils smallFont],
                                  NSForegroundColorAttributeName: style == 1? [TDUtils blueColor]: [TDUtils whiteColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text.text
                                                              attributes:attributes];

    for (NSString *mark in text.marks) {
        NSRange range = [text.text rangeOfString:mark];
        
        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:[TDUtils whiteColor]
                                 range:range];
    }
    
    self.textLabel.attributedText = attributedString;
}

-(void)populate:(TDStroyData *)story page:(NSInteger) page {
    [self setTextBody:[story.pages objectAtIndex:page] style:1];
    
    if (page + 1 >= story.pages.count) {
        [self.image setHidden:NO];
        if (story.imageName) {
            [self.image setImage:[UIImage imageNamed:story.imageName]];
        } else {
            [self.image setHidden:YES];
        }
    }
}

-(void)layoutSubviews {
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [super layoutSubviews];
}

@end
