//
//  MyThread.m
//  runloop
//
//  Created by GMY on 2018/10/8.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "MyThread.h"

@implementation MyThread

-(void)dealloc{
    NSLog(@"%@线程被释放了", self.name);
}

@end
