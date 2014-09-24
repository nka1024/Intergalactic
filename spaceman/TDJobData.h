//
//  TDJob.h
//  spaceman
//
//  Created by Admin on 9/8/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDStringWithMarks.h"

@interface TDJobData : NSObject

@property (nonatomic) long long salary;
@property (nonatomic) NSInteger rank;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *greeting;
@property (strong, nonatomic) TDStringWithMarks *info;

+(TDJobData *) jobWithSalary:(long long)salary
                        rank:(NSInteger)rank
                       title:(NSString *)title
                        info:(TDStringWithMarks *)info
                    greeting:(NSString *)greeting;

@end
