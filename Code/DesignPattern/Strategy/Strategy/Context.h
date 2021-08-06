//
//  Context.h
//  Strategy
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "OperationAdd.h"
#import "OperationMinus.h"

NS_ASSUME_NONNULL_BEGIN

@interface Context : NSObject

- (instancetype)initWithStrategy:(id<Strategy>)strategy;
- (NSInteger)execStrategyWithNum1:(NSInteger)num1 num2:(NSInteger)num2;

@end

NS_ASSUME_NONNULL_END
