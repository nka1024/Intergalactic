//
//  TDContractData.h
//  Интергалактик
//
//  Created by Admin on 9/17/14.
//  Copyright (c) 2014 Kirill Nepomnyaschy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TDContractTypeMining,
    TDContractTypeTrade
    
} TDContractType;


@interface TDContractData : NSObject

@property (nonatomic) TDContractType type;
@property (nonatomic) NSInteger level;
@property (strong, nonatomic) NSString *subject;
@property (nonatomic) long long reward;

@end
