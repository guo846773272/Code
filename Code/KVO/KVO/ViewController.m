//
//  ViewController.m
//  KVO
//
//  Created by GMY on 2019/9/24.
//  Copyright © 2019 gmy. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self KVO];
//    [self customKVO];
    
}

#pragma mark -- KVO

- (void)KVO {
    Person *p0 = [[Person alloc] init];
    Person *p1 = [[Person alloc] init];
    
    NSLog(@"before addObserver");
    
    NSLog(@"%@-%p", object_getClass(p0), object_getClass(p0));//Person
    NSLog(@"%@-%p", object_getClass(p1), object_getClass(p1));//Person
    NSLog(@"%d", object_getClass(p0) == object_getClass(p1));//1
    
    [p0 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"after addObserver");
    
    NSLog(@"%@-%p", object_getClass(p0), object_getClass(p0));//NSKVONotifying_Person
    NSLog(@"%@-%p", object_getClass(p1), object_getClass(p1));//Person
    NSLog(@"%d", object_getClass(p0) == object_getClass(p1));//0
    
    p0.name = @"Jack";
    
    //手动触发
//    [p0 willChangeValueForKey:@"name"];
//    [p0 didChangeValueForKey:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%@", change);
}

#pragma mark -- custom KVO

- (void)customKVO {
    
    Person *p = [[Person alloc] init];
    [p custom_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    p.name = @"Tom";
    
    [p custom_addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew context:nil];
    p.gender = @"Male gender";
}

@end
