//
//  TDInformationData.h
//  Интергалактик
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDStringWithMarks.h"

@interface TDInformationData : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) TDStringWithMarks *content;

+(instancetype)informationWithTitle:(NSString*)title
                            content:(TDStringWithMarks*)content;
@end
