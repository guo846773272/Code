//
//  Broker.h
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@interface Broker : NSObject

- (void)takeOrderWithOrder:(id<Order>)order;
- (void)placeOrders;

@end

NS_ASSUME_NONNULL_END
