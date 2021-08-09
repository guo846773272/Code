//
//  ViewController.m
//  Bridge
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "ViewController.h"
#import "White.h"
#import "Black.h"
#import "Circle.h"
#import "Square.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //白色
    id<Color> whiteColor = [[White alloc] init];
    //圆形
    id<Shape> circleShape = [[Circle alloc] init];
    //白色的圆形
    circleShape.color = whiteColor;
    [circleShape draw];
    
    //黑色
    id<Color> blackColor = [[Black alloc] init];
    //正方形
    id<Shape> squareShape = [[Square alloc] init];
    //黑色的正方形
    squareShape.color = blackColor;
    [squareShape draw];
}


@end
