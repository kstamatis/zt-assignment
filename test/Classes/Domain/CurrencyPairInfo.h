//
//  CurrencyPairInfo.h
//  test
//
//  Created by Kostas I. Stamatis on 06/12/16.
//  Copyright © 2016 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CurrencyValueStatus) {
    CurrencyValueStatusUnchanged,
    CurrencyValueStatusIncreased,
    CurrencyValueStatusDecreased
};

@interface CurrencyPairInfo : NSObject

@property (nonatomic, strong) NSNumber *buyValue;
@property (nonatomic, strong) NSNumber *sellValue;
@property (nonatomic, strong) NSNumber *pipMultiplier;
@property (nonatomic, strong) NSString *pair;
@property (nonatomic, strong) NSNumber *currencyID;

@property (nonatomic, assign) CurrencyValueStatus buyStatus;
@property (nonatomic, assign) CurrencyValueStatus sellStatus;

- (id) initWithDictionary:(NSDictionary *)dict;
- (void) setOldCurrencyInfo:(CurrencyPairInfo *)oldInfo;

@end
