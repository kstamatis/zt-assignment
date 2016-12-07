//
//  CurrencyPairInfo.m
//  test
//
//  Created by Kostas I. Stamatis on 06/12/16.
//  Copyright © 2016 ZT. All rights reserved.
//

#import "CurrencyPairInfo.h"

@implementation CurrencyPairInfo

- (id) initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]){
        self.buyValue = dict[@"buy"];
        self.sellValue = dict[@"sell"];
        self.pipMultiplier = dict[@"pipMultiplier"];
        self.pair = dict[@"name"];
        self.currencyID = dict[@"currencyId"];
    }
    return self;
}

- (void) setOldCurrencyInfo:(CurrencyPairInfo *)oldInfo {
    if (oldInfo){
        if ([oldInfo.buyValue isEqualToNumber:self.buyValue]){
            self.buyStatus = CurrencyValueStatusUnchanged;
            self.sellStatus = CurrencyValueStatusUnchanged;
        }
        else if ([oldInfo.buyValue compare:self.buyValue] == NSOrderedAscending){
            self.buyStatus = CurrencyValueStatusIncreased;
        }
        else if ([oldInfo.buyValue compare:self.buyValue] == NSOrderedDescending){
            self.buyStatus = CurrencyValueStatusDecreased;
        }
        
        if ([oldInfo.sellValue isEqualToNumber:self.sellValue]){
            self.sellStatus = CurrencyValueStatusUnchanged;
        }
        else if ([oldInfo.sellValue compare:self.sellValue] == NSOrderedAscending){
            self.sellStatus = CurrencyValueStatusIncreased;
        }
        else if ([oldInfo.sellValue compare:self.sellValue] == NSOrderedDescending){
            self.sellStatus = CurrencyValueStatusDecreased;
        }
    }
    else {
        self.buyStatus = CurrencyValueStatusUnchanged;
        self.sellStatus = CurrencyValueStatusUnchanged;
    }
}

@end
