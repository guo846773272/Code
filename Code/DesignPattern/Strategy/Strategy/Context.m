//
//  Context.m
//  Strategy
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import "Context.h"
#import "OperationAdd.h"

@interface Context ()

@property (nonatomic, strong) id<Strategy>strategy;

@end

@implementation Context

- (instancetype)initWithStrategy:(id<Strategy>)strategy {
    if (self = [super init]) {
        _strategy = strategy;
    }
    return self;
}

- (NSInteger)execStrategyWithNum1:(NSInteger)num1 num2:(NSInteger)num2 {
    return [self.strategy doOperationWithNum1:num1 num2:num2];
}

@end
