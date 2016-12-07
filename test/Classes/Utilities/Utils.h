//
//  Utils.h
//  test
//
//  Created by Kostas I. Stamatis on 06/12/16.
//  Copyright © 2016 ZT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void) formatValueForNumber:(NSNumber *)value pipMultiplier:(NSNumber *)pipMultiplier onCompletion:(void (^)(NSString *part1, NSString *part2, NSString *part3))completionHandler;

@end
