//
//  TDPopupManager.h
//  spaceman
//
//  Created by Admin on 9/6/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDActionView.h"

@interface TDPopupManager : NSObject


-(void)showModalPopup:(UIViewController *) target
                 text:(NSString *) text
                 time:(NSInteger) time
             selector:(SEL) selector;

+ (TDPopupManager *)sharedInstance;

@end
