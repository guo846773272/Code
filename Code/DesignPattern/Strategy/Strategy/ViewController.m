//
//  ViewController.m
//  Strategy
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import "ViewController.h"
#import "Context.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        OperationAdd *operationAdd = [[OperationAdd alloc] init];
        Context *context = [[Context alloc] initWithStrategy:operationAdd];
        NSInteger res = [context execStrategyWithNum1:2 num2:1];
        NSLog(@"OperationAdd-res: %zd", res);
    }
    
    {
        OperationMinus *operationMinus = [[OperationMinus alloc] init];
        Context *context = [[Context alloc] initWithStrategy:operationMinus];
        NSInteger res = [context execStrategyWithNum1:2 num2:1];
        NSLog(@"OperationMinus-res: %zd", res);
    }
}


@end
