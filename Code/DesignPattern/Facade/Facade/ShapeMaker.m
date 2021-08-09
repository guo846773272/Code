//
//  ShapeMaker.m
//  Facade
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "ShapeMaker.h"
#import "Square.h"
#import "Circle.h"

@interface ShapeMaker ()

@property (nonatomic, strong) id<Shape> circleShape;
@property (nonatomic, strong) id<Shape> squareShape;

@end

@implementation ShapeMaker

- (instancetype)init {
    if (self = [super init]) {
        _circleShape = [[Circle alloc] init];
        _squareShape = [[Square alloc] init];
    }
    return self;
}

- (void)drawCircle {
    [self.circleShape draw];
}

- (void)drawSquare {
    [self.squareShape draw];
}

@end
