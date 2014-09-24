//
//  TDButtonView.h
//  spaceman
//
//  Created by Admin on 9/8/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDUtils.h"
#import "TDStringWithMarks.h"

typedef NS_ENUM(NSInteger, TDButtonType) {
    TDButtonTypeDefault = 0x00,
    TDButtonTypeRefresh = 0x01
};

@interface TDButton : UIButton

- (id)initWithType:(TDButtonType) type
              text:(TDStringWithMarks*)text;

-(void) setLabelText:(TDStringWithMarks*)text;
@end
