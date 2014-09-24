//
//  TDEquipmentView.m
//  spaceman
//
//  Created by Admin on 9/4/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDMissionView.h"

@implementation TDMissionView

-(id)initWithDelegate:(id<UITableViewDelegate,UITableViewDataSource> )delegate
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
        

        UIView *textView = [[UIView alloc] init];
        UIView *statusView = [[UIView alloc] init];
        
//        textView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
//        statusView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        
        UILabel *statusLeftLabel = [[UILabel alloc] init];
        statusLeftLabel.font = [TDUtils tinyFont];
        statusLeftLabel.textColor = [TDUtils whiteColor];
        statusLeftLabel.text = @"Найти корабль пирата:\nУничтожить пирата:";
        statusLeftLabel.textAlignment = NSTextAlignmentLeft;
        statusLeftLabel.numberOfLines = 5;
        
    
        UILabel *statusRightLabel = [[UILabel alloc] init];
        statusRightLabel.font = [TDUtils tinyFont];
        statusRightLabel.textColor = [TDUtils blueColor];
        statusRightLabel.text = @"не выполнено\nне выполнено";
        statusRightLabel.textAlignment = NSTextAlignmentLeft;
        statusRightLabel.numberOfLines = 5;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.numberOfLines = 40;
        
        self.statusLeftLabel = statusLeftLabel;
        self.statusRightLabel = statusRightLabel;
        self.textLabel = textLabel;
        
        UIProgressView *progressView = [[UIProgressView alloc] init];
        progressView.tintColor = [TDUtils whiteColor];
        progressView.trackTintColor = [UIColor clearColor];
        progressView.progressViewStyle = UIProgressViewStyleBar;
        progressView.progress = 0.0;
        self.progressView = progressView;
        
        [self setTextBody:@"Корабль вышел из гиперпространства возле нелегальной торговой станции. Пират должен быть где-то в её окрестностях..." style:1];
        /*  TABLE VIEW  */
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView = tableView;
        
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = delegate;
        tableView.dataSource = delegate;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        tableView.separatorColor = [[TDUtils blueColor] colorWithAlphaComponent:0.43];
        tableView.contentInset = UIEdgeInsetsMake(-20, 0, -20, 0);
        tableView.backgroundColor = [UIColor clearColor];
        tableView.alwaysBounceVertical = NO;
        
        
        NSDictionary *textSubviews = NSDictionaryOfVariableBindings( textLabel, progressView);
        NSDictionary *statusSubviews = NSDictionaryOfVariableBindings(statusLeftLabel, statusRightLabel);
        NSDictionary *rootSubviews = NSDictionaryOfVariableBindings(textView, tableView);
        
        for (UIView *view in [textSubviews allValues]){
            [textView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        for (UIView *view in [statusSubviews allValues]){
            [statusView addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        for (UIView *view in [rootSubviews allValues]){
            [self addSubview:view];
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        
//        [TDUtils addVFLConstraintToView:textView subviews:textSubviews format:@"H:|[statusView]|"];
        [TDUtils addVFLConstraintToView:textView subviews:textSubviews format:@"H:|[textLabel]|"];
        [TDUtils addVFLConstraintToView:textView subviews:textSubviews format:@"H:|[progressView]|"];
        [TDUtils addVFLConstraintToView:textView subviews:textSubviews format:@"V:|-24-[textLabel]-[progressView]|"];
        
        [TDUtils addVFLConstraintToView:statusView subviews:statusSubviews format:@"H:|[statusLeftLabel]-20-[statusRightLabel]"];
        [TDUtils addVFLConstraintToView:statusView subviews:statusSubviews format:@"V:|[statusLeftLabel]|"];
        [TDUtils addVFLConstraintToView:statusView subviews:statusSubviews format:@"V:|[statusRightLabel]|"];
        
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-[textView]-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"H:|-8-[tableView]-8-|"];
        [TDUtils addVFLConstraintToView:self subviews:rootSubviews format:@"V:|-24-[textView]-40-[tableView]|"];
        
        
    }
    return self;
}
-(void) setTextBody:(NSString *)text style:(int)style{
    
    NSMutableParagraphStyle *paragrapStyle = NSMutableParagraphStyle.new;
    paragrapStyle.alignment = style == 1? NSTextAlignmentJustified : NSTextAlignmentCenter;
//    paragrapStyle.alignment = style == 1? NSTextAlignmentLeft : NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragrapStyle,
                                  NSBaselineOffsetAttributeName:@0,
                                  NSFontAttributeName: style == 1? [TDUtils smallFont] : [TDUtils smallFont],
                                  NSForegroundColorAttributeName: style == 1? [TDUtils blueColor]: [TDUtils whiteColor]};
    
    NSMutableAttributedString *attributedString;
    attributedString = [[NSMutableAttributedString alloc] initWithString:text
                                                              attributes:attributes];
    
//    NSArray *marks = [NSArray arrayWithObjects:@"поисковых", @"защитных", nil];
//    for (NSString *mark in marks) {
//        NSRange range = [text rangeOfString:mark];
//        
//        [attributedString addAttribute:NSForegroundColorAttributeName
//                                 value:[TDUtils whiteColor]
//                                 range:range];
//    }
    
    //    self.contractBodyLabel.text = text;
    self.textLabel.attributedText = attributedString;
    
}

-(void)populateWithText:(NSString *)text {
    [self setTextBody:text style:1];
}

-(void)layoutSubviews {
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [super layoutSubviews];
}


//-(void) doAction {
//    self.progressView.progress = 0.0f;
//    
//    [self setTextBody:@"Поиск залежей..." style:0];
//
//    
//    self.timer = [NSTimer scheduledTimerWithTimeInterval: 0.01f
//                                                  target: self
//                                                selector: @selector(updateActionProgress)
//                                                userInfo: nil
//                                                 repeats: YES];
//
//}

//- (void)updateActionProgress {
//    
//    self.progressView.progress += 0.002;
//    
//    if (self.progressView.progress >= 1.0) {
//        [self.timer invalidate];
//        
//        [self setTextBody:@"Поисковый дроид обнаружил астероид с высоким содержанием гелия-4. Можно приступать к бурению." style:1];
//        self.progressView.progress = 0.0;
//        
//    }
//}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
