//
//  SellStock.m
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "SellStock.h"
#import "Stock.h"

@interface SellStock ()

@property (nonatomic, strong) Stock *abcStock;

@end

@implementation SellStock

- (instancetype)initWithStock:(Stock *)stock {
    if (self = [super init]) {
        _abcStock = stock;
    }
    return self;
}

- (void)execute {
    [self.abcStock sell];
}

@end
