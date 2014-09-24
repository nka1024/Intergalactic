//
//  TDStroyData.m
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDStroyData.h"

@implementation TDStroyData


+(TDStroyData *)storyWithImage:(NSString *)image
                    returnText:(NSString *)returnText
                         pages:(TDStringWithMarks *)firstArg, ... NS_REQUIRES_NIL_TERMINATION {
    
    NSMutableArray *pages = [[NSMutableArray alloc] init];
    
    va_list args;
    va_start(args, firstArg);
    
    for (TDStringWithMarks *arg = firstArg; arg != nil; arg = va_arg(args, TDStringWithMarks*)) {
        [pages insertObject:arg atIndex:[pages count]];
    }
    va_end(args);

    TDStroyData *story = [[TDStroyData alloc] init];
    
    story.pages = pages;
    story.returnText = returnText;
    story.imageName = image;
    
    return story;
}
@end
