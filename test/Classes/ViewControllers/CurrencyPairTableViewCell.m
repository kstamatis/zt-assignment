//
//  CurrencyPairTableViewCell.m
//  test
//
//  Created by Kostas Stamatis on 06/12/2016.
//  Copyright © 2016 ZT. All rights reserved.
//

#import "CurrencyPairTableViewCell.h"
#import "Utils.h"

@interface CurrencyPairTableViewCell () {
    
    IBOutlet UIView *buyView;
    IBOutlet UIView *sellView;
    IBOutlet UILabel *buyValueLabel;
    IBOutlet UILabel *sellValueLabel;
    IBOutlet UILabel *pairNameLabel;
    IBOutlet UILabel *spreadLabel;
}

@end

@implementation CurrencyPairTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    [self initializeUI];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) initializeUI {
   
    buyView.layer.cornerRadius = 4;
    sellView.layer.cornerRadius = 4;
    
}

- (void) setCurrencyPairInfo:(CurrencyPairInfo *)currencyPairInfo {
    
    //display buy and sell values
    [Utils formatValueForNumber:currencyPairInfo.buyValue pipMultiplier:currencyPairInfo.pipMultiplier onCompletion:^(NSString *part1, NSString *part2, NSString *part3) {
        [self drawBuySellValueWithPart1:part1 part2:part2 part3:part3 onLabel:buyValueLabel];
    }];
    
    [Utils formatValueForNumber:currencyPairInfo.sellValue pipMultiplier:currencyPairInfo.pipMultiplier onCompletion:^(NSString *part1, NSString *part2, NSString *part3) {
        [self drawBuySellValueWithPart1:part1 part2:part2 part3:part3 onLabel:sellValueLabel];
    }];
    
    //pair name
    pairNameLabel.text = currencyPairInfo.pair;
    
    //Coloring buy view
    switch (currencyPairInfo.buyStatus) {
        case CurrencyValueStatusUnchanged:
            buyView.backgroundColor = [UIColor grayColor];
            break;
        case CurrencyValueStatusIncreased:
            buyView.backgroundColor = [UIColor greenColor];
            break;
        case CurrencyValueStatusDecreased:
            buyView.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    
    //Coloring sell view
    switch (currencyPairInfo.sellStatus) {
        case CurrencyValueStatusUnchanged:
            sellView.backgroundColor = [UIColor grayColor];
            break;
        case CurrencyValueStatusIncreased:
            sellView.backgroundColor = [UIColor greenColor];
            break;
        case CurrencyValueStatusDecreased:
            sellView.backgroundColor = [UIColor redColor];
            break;
        default:
            break;
    }
    
    //Spead label
    double spread = (currencyPairInfo.buyValue.doubleValue - currencyPairInfo.sellValue.doubleValue) * currencyPairInfo.pipMultiplier.doubleValue;
    spreadLabel.text = [NSString stringWithFormat:@"%.1f", spread];
}

#pragma mark - Help Methods

- (void) drawBuySellValueWithPart1:(NSString *)part1 part2:(NSString *)part2 part3:(NSString *)part3 onLabel:(UILabel *)label {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.minimumLineHeight = 20;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:[part1 stringByAppendingString:@" "] attributes:@{NSBaselineOffsetAttributeName : @-7, NSParagraphStyleAttributeName:paragraphStyle}];
    
    NSAttributedString *str2 = [[NSAttributedString alloc] initWithString:part2 attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:16], NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}];
    [str1 appendAttributedString:str2];
    
    
    NSMutableAttributedString *str3 = [[NSMutableAttributedString alloc] initWithString:[@" " stringByAppendingString:part3] attributes:@{NSBaselineOffsetAttributeName : @7}];
    [str1 appendAttributedString:str3];
    
    label.attributedText = str1;
}

@end
