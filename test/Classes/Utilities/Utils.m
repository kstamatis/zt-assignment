//
//  Utils.m
//  test
//
//  Created by Kostas I. Stamatis on 06/12/16.
//  Copyright © 2016 ZT. All rights reserved.
//

#import "Utils.h"

@implementation Utils

//Method to produce the three parts to display in the UI for the buy or sell value, given the value and the pip multiplier
+ (void) formatValueForNumber:(NSNumber *)value pipMultiplier:(NSNumber *)pipMultiplier onCompletion:(void (^)(NSString *part1, NSString *part2, NSString *part3))completionHandler {
    
    if (!value){
        completionHandler(@"-",@"-",@"-");
        return;
    }
    
    //Calculate the number of zeros fron the pip multiplier
    NSInteger nDecimals = [pipMultiplier stringValue].length - 1;
    
    //Get the string of the value in order to work on a string basis and not on the number itself (since noticed problems with the double precision)
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *format = @"#.";
    for (int i=0; i<nDecimals+2; i++){
        format = [format stringByAppendingString:@"#"];
    }
    formatter.positiveFormat = format;
    NSString *valueString = [formatter stringFromNumber:value];
    
    //Calculate the integral and the decimal string
    double valueDouble = [value doubleValue];
    int integral = (int)valueDouble;
    NSString *integralString = [NSString stringWithFormat:@"%i", integral];
    NSString *decimalString = @"";
    NSRange range = [valueString rangeOfString:[NSString stringWithFormat:@"%i", integral]];
    if (range.length != valueString.length) {
        range.length = range.length + 1;
        decimalString = [valueString stringByReplacingCharactersInRange:range withString:@""];
    }
    
    //Pad with zeros on the left, if needed
    NSInteger length = decimalString.length;
    if (length <= nDecimals){
        for (int i=0; i<nDecimals-length+1; i++){
            decimalString = [decimalString stringByAppendingString:@"0"];
        }
    }
    
    if (nDecimals == 1) { //Do not know if this case can even happen!!
        NSString *part1 = @"0";
        if (integralString.length > 1){
            part1 = [integralString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{0,%lu}", integralString.length-1])];
        }
        NSString *part2 = [NSString stringWithFormat:@"%@.%@", [integralString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{%lu,1}", integralString.length-1])], [decimalString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{0,1}"])]];
        NSString *part3 = [decimalString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{1,1}"])];
        
        completionHandler(part1, part2, part3);
    }
    else if (nDecimals > 1) {
        NSString *part1 = [NSString stringWithFormat:@"%i.", integral];
        part1 = [part1 stringByAppendingString:[decimalString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{0,%li}", nDecimals-2])]];
        NSString *part2 = [decimalString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{%li,2}", nDecimals-2])];
        NSString *part3 = [decimalString substringWithRange:NSRangeFromString([NSString stringWithFormat:@"{%li,1}", nDecimals])];
        
        completionHandler(part1, part2, part3);
    }
}

@end
