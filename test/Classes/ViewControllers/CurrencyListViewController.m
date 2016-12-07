//
//  CurrencyListViewController.m
//  test
//
//  Created by Kostas Stamatis on 06/12/2016.
//  Copyright © 2016 ZT. All rights reserved.
//

#import "CurrencyListViewController.h"
#import "CurrencyPairTableViewCell.h"

@interface CurrencyListViewController () {
    
    IBOutlet UITableView *pairsTableView;
    
    NSMutableArray<CurrencyPairInfo *> *allData;
    NSMutableDictionary<NSNumber *, CurrencyPairInfo *> *index;
    NSTimer *refreshTimer;
}

@end

@implementation CurrencyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //Navigation bar
    self.title = @"ZLTr4d3"; //Avoid reference of ZT in code!!
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"burger_icon"] style:UIBarButtonItemStylePlain target:self action:nil];
    
    index = [NSMutableDictionary new];
    
    //Initialize and start timer to refresh rates
    refreshTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [refreshTimer fire];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    if (refreshTimer){
        [refreshTimer invalidate];
    }
}

#pragma mark - Timer methods

- (void) timerFired:(id)timer {
    //Run in separate thread
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        //Avoid reference of ZT in code!! Thus, I used a shortened version of the rest URL
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://bit.ly/2h346FA"]];
        if (data){
            NSError *error = nil;
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            
            if (!error) {
                allData = [NSMutableArray new];
                
                for (NSDictionary *dict in array) {
                    CurrencyPairInfo *cpi = [[CurrencyPairInfo alloc] initWithDictionary:dict];
                    [cpi setOldCurrencyInfo:index[cpi.currencyID]];
                    [allData addObject:cpi];
                    [index setObject:cpi forKey:cpi.currencyID];
                }
                
                // go to main thread for the UI update
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [pairsTableView reloadData];
                }];
            }
        }
        
    });
}

#pragma mark - UITableView Datasource/Delegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return allData.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CurrencyPairTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"currency-pair-cell"];
    
    [cell setCurrencyPairInfo:allData[indexPath.row]];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 142;
}

@end
