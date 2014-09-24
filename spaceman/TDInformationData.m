//
//  TDInformationData.m
//  Интергалактик
//
//  Created by Admin on 9/16/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import "TDInformationData.h"

@implementation TDInformationData

+(instancetype)informationWithTitle:(NSString *)title
                            content:(TDStringWithMarks *)content {
    
    TDInformationData *informationData = [[TDInformationData alloc] init];
    
    informationData.title = title;
    informationData.content = content;
    
    return informationData;
}
@end
