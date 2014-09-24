//
//  TDStringWithMarks.m
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDStringWithMarks.h"

@implementation TDStringWithMarks

+(TDStringWithMarks *)stringWithText:(NSString *)text marks:(NSString *)firstArg, ... {
    
    NSMutableArray *marks = [[NSMutableArray alloc] init];
    
    va_list args;
    va_start(args, firstArg);
    
    for (NSString *arg = firstArg; arg != nil; arg = va_arg(args, NSString*)) {
        [marks insertObject:arg atIndex:[marks count]];
    }
    va_end(args);

    TDStringWithMarks *string = [[TDStringWithMarks alloc] init];
    string.marks = marks;
    string.text = text;
    
    return string;
}

@end
