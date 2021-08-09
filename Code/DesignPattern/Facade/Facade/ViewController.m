//
//  ViewController.m
//  Facade
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "ViewController.h"
#import "ShapeMaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ShapeMaker *shapeMaker = [[ShapeMaker alloc] init];
    [shapeMaker drawCircle];
    [shapeMaker drawSquare];
}

@end
