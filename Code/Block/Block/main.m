//
//  main.m
//  Block
//
//  Created by 郭孟漾 on 2018/12/16.
//  Copyright © 2018 gmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


//Block的类型和继承链
//以下代码在MRC环境下

//定义在全局区
void(^globalBlock1)(void) = ^{
    
};

void test1() {
    //未截获自动变量
    void(^globalBlock2)(void) = ^{
        
    };
    //截获自动变量(MRC下验证，ARC会执行copy)
    int a = 0;
    void(^stackBlock)(void) = ^{
        NSLog(@"a: %d", a);
    };
    //截获自动变量 调用copy
    void(^mallocBlock)(void) = [^{
        NSLog(@"a: %d", a);
    } copy];
    
    NSLog(@"globalBlock1: %@", globalBlock1);
    NSLog(@"globalBlock2: %@", globalBlock2);
    NSLog(@"stackBlock: %@", stackBlock);
    NSLog(@"mallocBlock: %@", mallocBlock);
    
    //继承链
    NSLog(@"------------------------------");
    
    NSLog(@"globalBlock1 superclass: %@", [globalBlock1 superclass]);
    NSLog(@"stackBlock superclass: %@", [[stackBlock class] superclass]);
    NSLog(@"mallocBlock superclass: %@", [[mallocBlock class] superclass]);
    
    NSLog(@"------------------------------");
    
    NSLog(@"globalBlock1 superclass superclass: %@", [[globalBlock1 superclass] superclass]);
    NSLog(@"stackBlock superclass superclass: %@", [[[stackBlock class] superclass] superclass]);
    NSLog(@"mallocBlock superclass superclass: %@", [[[mallocBlock class] superclass] superclass]);
    
    NSLog(@"------------------------------");
    
    NSLog(@"globalBlock1 superclass superclass superclass: %@", [[[globalBlock1 superclass] superclass] superclass]);
}
//Block截获变量
static int static_global_val = 0;//静态全局变量
int global_val = 0;//全局变量

void test2() {
//    int val = 0;//不能在block内部修改的变量
    static int static_val = 0;//静态变量
    __block int block_val = 0;//__block修饰的变量
    void(^block)(void) = ^{
        
        static_global_val ++;
        global_val ++;
        static_val ++;
        block_val ++;
        
        NSLog(@"static_global_val: %d", static_global_val);
        NSLog(@"global_val: %d", global_val);
        NSLog(@"static_val: %d", static_val);
        NSLog(@"block_val: %d", block_val);
    };
    block();
}
//验证复制__block变量
void test3() {
    __block int a = 1;
    NSLog(@"a=%d  地址：%p", a, &a);
    void(^block)(void) = ^{
        a ++;
        NSLog(@"a=%d  地址：%p", a, &a);
    };
    [block copy];
    block();
    NSLog(@"a=%d  地址：%p", a, &a);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        test1();
//        test2();
        test3();
    }
    return 0;
}
