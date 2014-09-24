//
//  TDStringWithMarks.h
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDStringWithMarks : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSArray *marks;

+(TDStringWithMarks *) stringWithText:(NSString *)text
                                marks:(NSString *)firstArg, ... NS_REQUIRES_NIL_TERMINATION;

@end
