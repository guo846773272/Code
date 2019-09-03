//
//  ViewController.m
//  autoreleasepool
//
//  Created by 郭孟漾 on 2019/9/3.
//  Copyright © 2019 gmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak) id obj;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [NSThread detachNewThreadSelector:@selector(createAndConfigObserverInSecondaryThread) toTarget:self withObject:nil];
}

- (void)createAndConfigObserverInSecondaryThread{
    __autoreleasing id test = [NSObject new];
    NSLog(@"obj = %@", test);
    _obj = test;
    [[NSThread currentThread] setName:@"test runloop thread"];
    NSLog(@"thread ending");
}

@end
