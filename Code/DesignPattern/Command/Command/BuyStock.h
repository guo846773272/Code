//
//  BuyStock.h
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Order.h"

@class Stock;

NS_ASSUME_NONNULL_BEGIN

@interface BuyStock : NSObject<Order>

- (instancetype)initWithStock:(Stock *)stock;

@end

NS_ASSUME_NONNULL_END
