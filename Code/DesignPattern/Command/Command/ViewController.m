//
//  ViewController.m
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "ViewController.h"
#import "Broker.h"
#import "Stock.h"
#import "BuyStock.h"
#import "SellStock.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Stock *stock = [[Stock alloc] init];
    
    BuyStock *buyStock = [[BuyStock alloc] initWithStock:stock];
    SellStock *sellStock = [[SellStock alloc] initWithStock:stock];
    
    Broker *broker = [[Broker alloc] init];
    [broker takeOrderWithOrder:buyStock];
    [broker takeOrderWithOrder:sellStock];
    
    [broker placeOrders];
    
}


@end
