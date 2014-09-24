//
//  TDStroyData.h
//  spaceman
//
//  Created by Admin on 9/12/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDStringWithMarks.h"

@interface TDStroyData : NSObject

@property (nonatomic) NSArray *pages;
@property (nonatomic) NSString *imageName;
@property (nonatomic) NSString *returnText;

+(TDStroyData *)storyWithImage:(NSString *)image
                    returnText:(NSString *)returnText
                         pages:(TDStringWithMarks *)firstArg, ...;


@end
