//
//  Broker.m
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "Broker.h"
#import "Order.h"

@interface Broker ()

@property (nonatomic, strong) NSMutableArray<id<Order>> *orderMArr;

@end

@implementation Broker

- (void)takeOrderWithOrder:(id<Order>)order {
    if (order) {
        [self.orderMArr addObject:order];
    }
}

- (void)placeOrders {
    for (id<Order> order in self.orderMArr) {
        [order execute];
    }
}

- (NSMutableArray<id<Order>> *)orderMArr {
    if (!_orderMArr) {
        _orderMArr = [NSMutableArray array];
    }
    return _orderMArr;
}

@end
