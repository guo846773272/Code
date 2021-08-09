//
//  BuyStock.m
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "BuyStock.h"
#import "Stock.h"

@interface BuyStock ()

@property (nonatomic, strong) Stock *abcStock;

@end

@implementation BuyStock

- (instancetype)initWithStock:(Stock *)stock {
    if (self = [super init]) {
        _abcStock = stock;
    }
    return self;
}

- (void)execute {
    [self.abcStock buy];
}

@end
