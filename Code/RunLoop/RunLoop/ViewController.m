//
//  ViewController.m
//  RunLoop
//
//  Created by 郭孟漾 on 2019/9/5.
//  Copyright © 2019 gmy. All rights reserved.
//


#import "ViewController.h"

#import "MyThread.h"

typedef void(^Callback)(void);

@interface ViewController ()

@property (nonatomic, strong) NSThread *thread;

@property (nonatomic, copy) Callback callback;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addRunLoopObserver {
    //1.创建监听者
    /*
     第一个参数:怎么分配存储空间
     第二个参数:要监听的状态 kCFRunLoopAllActivities 所有的状态
     第三个参数:时候持续监听
     第四个参数:优先级 总是传0
     第五个参数:当状态改变时候的回调
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        /*
         kCFRunLoopEntry = (1UL << 0),        即将进入runloop
         kCFRunLoopBeforeTimers = (1UL << 1), 即将处理timer事件
         kCFRunLoopBeforeSources = (1UL << 2),即将处理source事件
         kCFRunLoopBeforeWaiting = (1UL << 5),即将进入睡眠
         kCFRunLoopAfterWaiting = (1UL << 6), 被唤醒
         kCFRunLoopExit = (1UL << 7),         runloop退出
         kCFRunLoopAllActivities = 0x0FFFFFFFU
         */
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"即将进入runloop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将进入睡眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"runloop退出");
                break;
                
            default:
                break;
        }
    });
    
    /*
     第一个参数:要监听哪个runloop
     第二个参数:观察者
     第三个参数:运行模式
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(),observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
}

- (void)addEvent2BeforeWaiting {
    
    self.callback = ^(void) {
        NSLog(@"callback kCFRunLoopBeforeWaiting");
    };
    
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    static CFRunLoopObserverRef defaultModeObserver;
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    defaultModeObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting, YES, NSIntegerMax - 999, &_defaultModeRunLoopWorkDistributionCallback, &context);
    CFRunLoopAddObserver(runLoop, defaultModeObserver, kCFRunLoopDefaultMode);
    CFRelease(defaultModeObserver);
}

static void _defaultModeRunLoopWorkDistributionCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    _runLoopWorkDistributionCallback(observer, activity, info);
}

static void _runLoopWorkDistributionCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    ViewController *vc = (__bridge ViewController *)info;
    NSLog(@"observe: %@", observer);
    NSLog(@"activity: %lu", activity);
    
    NSLog(@"kCFRunLoopEntry: %lu", activity & kCFRunLoopEntry);
    NSLog(@"kCFRunLoopBeforeTimers: %lu", activity & kCFRunLoopBeforeTimers);
    NSLog(@"kCFRunLoopBeforeSources: %lu", activity & kCFRunLoopBeforeSources);
    NSLog(@"kCFRunLoopBeforeWaiting: %lu", activity & kCFRunLoopBeforeWaiting);
    NSLog(@"kCFRunLoopAfterWaiting: %lu", activity & kCFRunLoopAfterWaiting);
    NSLog(@"kCFRunLoopExit: %lu", activity & kCFRunLoopExit);
    NSLog(@"kCFRunLoopAllActivities: %lu", activity & kCFRunLoopAllActivities);
    
    NSLog(@"vc: %p", vc);
    
    if (vc.callback)
        vc.callback();
    
    NSLog(@"----------------------------");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self addRunLoopObserver];
    [self addEvent2BeforeWaiting];
    NSLog(@"self: %p", self);
    
//    [self test0];
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
//    [self test6];
    
}

- (void)test0 {
    //内部是定时器，触发timer事件
    [self performSelector:@selector(testPerformSelector0) withObject:nil afterDelay:1];
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"NSTimer ---- timer调用了");
    }];
}

- (void)testPerformSelector0 {
    
}

- (void)test1 {
    //触发source0事件
    //    [self performSelector:@selector(testPerformSelector1)];
    //    [self performSelectorOnMainThread:@selector(testPerformSelector1) withObject:nil waitUntilDone:YES];
}

- (void)testPerformSelector1 {
    
}

- (void)test2 {
    [self performSelector:@selector(testPerformSelector2) onThread:self.thread withObject:nil waitUntilDone:NO];
}

- (NSThread *)thread {
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(testSel2) object:nil];
    [_thread start];
    return _thread;
}

- (void)testSel2 {
    [self addRunLoopObserver];
    [[NSThread currentThread] setName:@"test2"];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    //启动runloop保持线程活跃
    //    [runLoop run];
    //启动runloop保持线程活跃，并设定时间退出runloop
    [runLoop runUntilDate:[NSDate date]];
    //    [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate date]];
}

- (void)testPerformSelector2 {
    
}

- (void)test3 {
    NSLog(@"%@----开辟子线程",[NSThread currentThread]);
    
    NSThread *subThread = [[MyThread alloc] initWithTarget:self selector:@selector(subThreadTodo) object:nil];
    subThread.name = @"subThread";
    [subThread start];
}

- (void)subThreadTodo
{
    NSLog(@"%@----开始执行子线程任务",[NSThread currentThread]);
    //获取当前子线程的RunLoop
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //给RunLoop添加一个事件源，注意添加的Mode
    //关于这里的[NSMachPort port]我的理解是，给RunLoop添加了一个占位事件源，告诉RunLoop有事可做，让RunLoop运行起来。
    //但是暂时这个事件源不会有具体的动作，而是要等RunLoop跑起来过后等有消息传递了才会有具体动作。
    [runLoop addPort:[NSMachPort port] forMode:UITrackingRunLoopMode];
    
    [runLoop run];
    NSLog(@"%@----执行子线程任务结束",[NSThread currentThread]);
}

- (void)test4 {
    [self performSelector:@selector(testPerformSelector4) withObject:nil afterDelay:0];
    NSLog(@"1");
    
}

- (void)testPerformSelector4 {
    NSLog(@"2");
}

- (void)test5 {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"1");
        /*
         * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
         * frame #0: 0x0000000103e54187 runloop`__23-[ViewController test5]_block_invoke(.block_descriptor=0x0000000103e56168) at ViewController.m:186:9
         frame #1: 0x00000001069f3d7f libdispatch.dylib`_dispatch_call_block_and_release + 12
         frame #2: 0x00000001069f4db5 libdispatch.dylib`_dispatch_client_callout + 8
         frame #3: 0x0000000106a02080 libdispatch.dylib`_dispatch_main_queue_callback_4CF + 1540
         frame #4: 0x00000001050f18a9 CoreFoundation`__CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
         frame #5: 0x00000001050ebf56 CoreFoundation`__CFRunLoopRun + 2310
         frame #6: 0x00000001050eb302 CoreFoundation`CFRunLoopRunSpecific + 626
         frame #7: 0x000000010d6872fe GraphicsServices`GSEventRunModal + 65
         frame #8: 0x0000000107f05ba2 UIKitCore`UIApplicationMain + 140
         frame #9: 0x0000000103e54340 runloop`main(argc=1, argv=0x00007ffeebdabf98) at main.m:14:16
         frame #10: 0x0000000106a69541 libdyld.dylib`start + 1
         frame #11: 0x0000000106a69541 libdyld.dylib`start + 1
         */
    });
    NSLog(@"2");
}

- (void)test6 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"1");
    });
    NSLog(@"2");
}

@end

