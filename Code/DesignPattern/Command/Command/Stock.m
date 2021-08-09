//
//  Stock.m
//  Command
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "Stock.h"

@interface Stock ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger quantity;

@end

@implementation Stock

- (instancetype)init {
    if (self = [super init]) {
        _name = @"ABC";
        _quantity = 10;
    }
    return self;
}

- (void)buy {
    NSLog(@"Stock [name: %@, quantity: %zd] bought", self.name, self.quantity);
}

- (void)sell {
    NSLog(@"Stock [name: %@, quantity: %zd] sold", self.name, self.quantity);
}


@end
