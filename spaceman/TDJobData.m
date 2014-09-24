//
//  TDJob.m
//  spaceman
//
//  Created by Admin on 9/8/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDJobData.h"

@implementation TDJobData

+(TDJobData *) jobWithSalary:(long long)salary
                        rank:(NSInteger)rank
                       title:(NSString *)title
                        info:(TDStringWithMarks *)info
                    greeting:(NSString *)greeting {
    
    TDJobData *job = [[TDJobData alloc] init];
    
    job.rank = rank;
    job.salary = salary;
    job.title = title;
    job.info = info;
    job.greeting = greeting;
    
    return job;
}

@end
