//
//  ViewController.m
//  GCD
//
//  Created by mengyang_guo on 2018/8/16.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self test00];
//    [self test01];
//    [self test02];
//    [self test03];
    
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
//    [self test7];
//    [self test8];
//    [self test9];
//    [self test10];
//    [self test11];
    
//    [self fun0];
//    [self fun1];
//    [self fun2];
//    [self fun3];
//    [self fun4];
    
//    [self group];
//    [self groupCallback];
    
    [self apply];
    
//    [self semaphore0];
//    [self semaphore1];
//    [self semaphore2];
//    [self semaphore3];
//    [self semaphore4];
}
#pragma mark --串行并行
//同步串行
- (void)test00 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_sync(serialQueue, ^{
        NSLog(@"2");//主线程
    });
    NSLog(@"3");
    //123并且都在主线程无意义
}
//同步并行
- (void)test01 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"2");//主线程
    });
    NSLog(@"3");
    //123并且都在主线程无意义
}
//异步串行
- (void)test02 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    //123或者132
}
//异步并行
- (void)test03 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    //123或者132
}
// 串行同步
- (void)test1 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"1");
    });
    NSLog(@"2");
    dispatch_sync(serialQueue, ^{
        NSLog(@"3");
    });
    NSLog(@"4");
    //打印顺序1、2、3、4
}

// 串行异步
- (void)test2 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"1");
    });
    NSLog(@"2");
    dispatch_async(serialQueue, ^{
        NSLog(@"3");
    });
    NSLog(@"4");
    //1234 ，2134，1243，2413，2143
    //1 一定在 3 之前打印出来，2 一定在 4 之前打印，2 一定在 3 之前打印
}

// 串行异步中嵌套异步
- (void)test3 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");//子线程
        dispatch_async(serialQueue, ^{
            NSLog(@"3");//子线程
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //1在前，后面乱序
}

// 串行异步中嵌套同步
- (void)test4 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(serialQueue, ^{
        NSLog(@"2");
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //打印顺序152或者125然后死锁
}
// 串行同步中嵌套异步
- (void)test5 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_sync(serialQueue, ^{
        NSLog(@"2");
        dispatch_async(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //12345，12435，12453。这里1一定在最前，2 一定在 4 前，4 一定在 5 前
}
// 串行同步中嵌套同步
- (void)test6 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_sync(serialQueue, ^{
        NSLog(@"2");
        dispatch_sync(serialQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //12  然后死锁
}
// 并发同步
- (void)test7 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"1");
    });
    NSLog(@"2");
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"3");
    });
    NSLog(@"4");
    //打印顺序1、2、3、4
}

// 并发异步
- (void)test8 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        NSLog(@"1");
    });
    NSLog(@"2");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"3");
    });
    NSLog(@"4");
    //这里只能保证 24 顺序执行，13 乱序，可能插在任意位置：2413 ，2431，2143，2341，2134，2314。
}
// 并发异步中嵌套同步
- (void)test9 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_async(concurrentQueue, ^{
        NSLog(@"2");
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //这里会打印出 4 个结果：12345，12534，12354，15234。注意同步操作保证了 3 一定会在 4 之前打印出来
}

// 并发同步中嵌套异步
- (void)test10 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"2");
        dispatch_async(concurrentQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //这里会打印出 3 个结果：12345，12435，12453。这里同步操作保证了 2 和 4 一定在 3 和 5 之前打印出来
}

// 并发同步中嵌同步
- (void)test11 {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.Charles.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"2");
        dispatch_sync(concurrentQueue, ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //12345 不开辟子线程
}

#pragma mark --globle_queue main_queue
//异步主队列
- (void)fun0 {
    NSLog(@"1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");//主线程
    });
    NSLog(@"3");
    //1、3、2
}
//异步全局队列
- (void)fun1 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    //123或者132
}
//同步主队列
- (void)fun2 {
    NSLog(@"1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2");
    });
    NSLog(@"3");
    //1 之后死锁
}
//同步全局队列
- (void)fun3 {
    NSLog(@"1");
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
        NSLog(@"%@", [NSThread currentThread]);//在主线程
    });
    NSLog(@"3");
    //123没用
}
//异步全局队列嵌套同步主队列
- (void)fun4 {
    NSLog(@"1");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"2");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3");
        });
        NSLog(@"4");
    });
    NSLog(@"5");
    //15234或者12534
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self func0];
//    [self func1];
    
}

- (void)func0 {
    
//    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
//    NSLog(@"当前任务");
//    dispatch_sync(serialQueue, ^{
//        NSLog(@"最先加入自定义串行队列");
//        sleep(2);
//    });
//    dispatch_sync(serialQueue, ^{
//        NSLog(@"次加入自定义串行队列");
//    });
//    NSLog(@"下一个任务");
    
    dispatch_queue_t serialQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"当前任务");
    dispatch_async(serialQueue, ^{
        NSLog(@"最先加入自定义串行队列");
        sleep(2);
    });
    dispatch_async(serialQueue, ^{
        NSLog(@"次加入自定义串行队列");
    });
    NSLog(@"下一个任务");
}

- (void)func1 {
//    dispatch_queue_t conCurrentQueue = dispatch_queue_create("com.Charles.conCurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//    NSLog(@"current task");
//    dispatch_sync(conCurrentQueue, ^{
//        NSLog(@"先加入队列");
//    });
//    dispatch_sync(conCurrentQueue, ^{
//        NSLog(@"次加入队列");
//    });
//    NSLog(@"next task");
    
    dispatch_queue_t conCurrentQueue = dispatch_queue_create("com.Charles.serialQueue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"当前任务");
    dispatch_async(conCurrentQueue, ^{
        NSLog(@"最先加入自定义串行队列");
        sleep(2);
    });
    dispatch_async(conCurrentQueue, ^{
        NSLog(@"次加入自定义串行队列");
    });
    NSLog(@"下一个任务");
    
}

#pragma mark --dispatch_apply

- (void)apply {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"apply---begin");
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd---%@",index, [NSThread currentThread]);
    });
    NSLog(@"apply---end");
}

#pragma mark --dispatch_group_t

- (void)group {
    /**创建自己的队列*/
    dispatch_queue_t dispatchQueue = dispatch_queue_create("ted.queue.next", DISPATCH_QUEUE_CONCURRENT);
    /**创建一个队列组*/
    dispatch_group_t dispatchGroup = dispatch_group_create();
    /**将队列任务添加到队列组中*/
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        
        NSString *str = @"http://www.jianshu.com/p/6930f335adba";
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"dispatch-1");
            
        }];
        
        [task resume];
    });
    /**将队列任务添加到队列组中*/
    dispatch_group_async(dispatchGroup, dispatchQueue, ^(){
        NSString *str = @"http://www.jianshu.com/p/6930f335adba";
        NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"dispatch-2");
            
        }];
        [task resume];
    });
    /**队列组完成调用函数*/
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^(){
        NSLog(@"end");
    });
}

- (void)groupCallback {
    
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    
    for (int i=0; i<10; i++) {
        
        dispatch_group_async(downloadGroup, dispatch_get_global_queue(0, 0), ^{
            
            dispatch_group_enter(downloadGroup);
            
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                NSLog(@"线程：%@---%d---%d",[NSThread currentThread], i, i);
                dispatch_group_leave(downloadGroup);
                
            }];
            
            [task resume];
        });
        
    }
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        NSLog(@"dispatch_group_notify");
    });
}

#pragma mark --dispatch_semaphore_t(信号量)
//限制最大并发
- (void)semaphore0 {
//    创建信号量，参数：信号量的初值，如果小于0则会返回NULL
//    dispatch_semaphore_create（信号量值）
//    等待降低信号量
//    dispatch_semaphore_wait（信号量，等待时间）
//    提高信号量
//    dispatch_semaphore_signal(信号量)
//    crate的value表示，最多几个资源可访问
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //任务1
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 1");
        sleep(1);
        NSLog(@"complete task 1");
        dispatch_semaphore_signal(semaphore);
    });
    //任务2
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 2");
        sleep(1);
        NSLog(@"complete task 2");
        dispatch_semaphore_signal(semaphore);
    });
    //任务3
    dispatch_async(quene, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"run task 3");
        sleep(1);
        NSLog(@"complete task 3");
        dispatch_semaphore_signal(semaphore);
    });
}
//线程安全锁
- (void)semaphore1 {
    
    dispatch_semaphore_t semaphoreLock = dispatch_semaphore_create(1);
    
    for (NSInteger i = 0; i < 50; i ++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
            NSLog(@"i: %ld", i);
            dispatch_semaphore_signal(semaphoreLock);
        });
    }
}

//主线程被阻塞
- (void)semaphore2 {
    
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    static int count = 0;
    for (int i=0; i<10; i++) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            sleep(arc4random_uniform(2));
            NSLog(@"%d---%@",i,[NSThread currentThread]);
            count++;
            if (count==10) {
                dispatch_semaphore_signal(sem);
                count = 0;
            }
            
        }];
        
        [task resume];
    }
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    NSLog(@"wait之后");//阻塞了主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}
//主线程被阻塞
- (void)semaphore3 {
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (int i=0; i<10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            sleep(arc4random_uniform(2));
            NSLog(@"%d---%@",i,[NSThread currentThread]);
            dispatch_semaphore_signal(sem);
        }];
        [task resume];
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
    NSLog(@"==================主线程任务");//阻塞主线程
}
//多个异步任务完成后处理回调任务，不阻塞主线程，(类似于groupCallback)
- (void)semaphore4 {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    //代表http访问返回的数量
    //这里模仿的http请求block块都是在同一线程（主线程）执行返回的，所以对这个变量的访问不存在资源竞争问题，故不需要枷锁处理
    //如果网络请求在不同线程返回，要对这个变量进行枷锁处理，不然很会有资源竞争危险
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //demo testUsingSemaphore方法是在主线程调用的，不直接调用遍历执行，而是嵌套了一个异步，是为了避免主线程阻塞
        for (int i=0; i<10; i++) {
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                sleep(arc4random_uniform(2));
                NSLog(@"%d---%@",i,[NSThread currentThread]);
                //全部请求返回才触发signal
                if (i == 9) {
                    dispatch_semaphore_signal(sem);
                }
            }];
            [task resume];
        }
        //如果全部请求没有返回则该线程会一直阻塞
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        NSLog(@"all http request done! end thread: %@", [NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"UI update in main thread!");
        });
    });
    NSLog(@"主线程任务");
}

- (void)barrier {
    
//    dispatch_barrier_async(dispatch_queue_t queue, dispatch_block_t block);
//    作用：
//    1.在它前面的任务执行结束后它才执行，它后面的任务要等它执行完成后才会开始执行。
//    2.避免数据竞争
    
    // 1.创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    // 2.向队列中添加任务
    dispatch_async(queue, ^{  // 1.2是并行的
        NSLog(@"任务1, %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务2, %@",[NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"任务 barrier, %@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{   // 这两个是同时执行的
        NSLog(@"任务3, %@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"任务4, %@",[NSThread currentThread]);
    });
}



@end
