//
//  ViewController.m
//  HookBlock
//
//  Created by 郭孟漾 on 2018/11/2.
//  Copyright © 2018年 gmy. All rights reserved.
//

#import "ViewController.h"

#import "GMYBlockDescription.h"

/*
 block源代码地址： https://opensource.apple.com/tarballs/libclosure/
 */

/*
 CTObjectiveCRuntimeAdditions的方式
 https://github.com/ebf/CTObjectiveCRuntimeAdditions
 */
struct BlockDesc {
    void *isa; // initialized to &_NSConcreteStackBlock or &_NSConcreteGlobalBlock
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    struct block_descriptor {
        unsigned long int reserved;    // NULL
        unsigned long int size;         // sizeof(struct Block_literal_1)
        // optional helper functions
        void (*copy_helper)(void *dst, void *src);     // IFF (1<<25)
        void (*dispose_helper)(void *src);             // IFF (1<<25)
        // required ABI.2010.3.16
        const char *signature;                         // IFF (1<<30)
    } *descriptor;
    // imported variables
};

enum {
    CTBlockDescriptionFlagsHasCopyDispose = (1 << 25),
    CTBlockDescriptionFlagsHasCtor = (1 << 26), // helpers have C++ code
    CTBlockDescriptionFlagsIsGlobal = (1 << 28),
    CTBlockDescriptionFlagsHasStret = (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    CTBlockDescriptionFlagsHasSignature = (1 << 30)
};

typedef int BlockDescFlags;


/*
 Aspects方式
 */
typedef NS_OPTIONS(int, AspectBlockFlags) {
    AspectBlockFlagsHasCopyDisposeHelpers = (1 << 25),
    AspectBlockFlagsHasSignature          = (1 << 30)
};

typedef struct _AspectBlock {
    __unused Class isa;
    AspectBlockFlags flags;
    __unused int reserved;
    void (__unused *invoke)(struct _AspectBlock *block, ...);
    struct {
        unsigned long int reserved;
        unsigned long int size;
        // requires AspectBlockFlagsHasCopyDisposeHelpers
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
        // requires AspectBlockFlagsHasSignature
        const char *signature;
        const char *layout;
    } *descriptor;
    // imported variables
} *AspectBlockRef;




//struct GMY_Block_descriptor {
//    uintptr_t reserved;
//    uintptr_t size;
//
//    void (*copy)(void *dst, const void *src);
//    void (*dispose)(const void *);
//};
//
//struct GMY_Block_layout {
//    void *isa;
//    volatile int32_t flags; // contains ref count
//    int32_t reserved;
//    void (*invoke)(void *, ...);
//    struct GMY_Block_descriptor_1 *descriptor;
//    // imported variables
//};


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self test1];
//    [self test2];
//    [self test3];
}

- (void)test1 {
    id(^block)(NSString *) = ^(NSString *str) {
        return str;
    };
    
    struct BlockDesc *blockDesc = (__bridge struct BlockDesc *)block;
    BlockDescFlags flags = blockDesc->flags;
//    unsigned long int size = blockDesc->descriptor->size;
    NSMethodSignature *blockSignature;
    if (flags & CTBlockDescriptionFlagsHasSignature) {
        void *signatureLocation = blockDesc->descriptor;
        signatureLocation += sizeof(unsigned long int);
        signatureLocation += sizeof(unsigned long int);
        if (flags & CTBlockDescriptionFlagsHasCopyDispose) {
            signatureLocation += sizeof(void(*)(void *dst, void *src));
            signatureLocation += sizeof(void (*)(void *src));
        }
        const char *signature = (*(const char **)signatureLocation);
        blockSignature = [NSMethodSignature signatureWithObjCTypes:signature];
    }
    
    
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:blockSignature];
    invocation.target = block;
    NSString *string = @"string";
    [invocation setArgument:&string atIndex:1];
    [invocation invoke];
    id returnValue;
    [invocation getReturnValue:&returnValue];
    NSLog(@"returnValue = %@", returnValue);
}

//访问函数指针invoke的方式
- (void)test2 {
    void (^block)(void) = ^{
        NSLog(@"block");
    };
    
    struct GMY_Block_layout *myBlock = (__bridge struct GMY_Block_layout *)block;
    myBlock->invoke(myBlock);
}

- (void)test3 {
    //定义block
    void (^block)(NSString *) = ^(NSString *str){
        NSLog(@"block: %@", str);
    };
    //转化
    struct GMY_Block_layout *blockLayout = (__bridge struct GMY_Block_layout *)block;
    //根据flags的容错判断
    volatile int32_t blockFlags = blockLayout->flags;
    if (blockFlags & GMYBLOCK_HAS_SIGNATURE) {//判断方法签名
        void *blockDesc = blockLayout->descriptor;
        blockDesc += 2 * sizeof(uintptr_t);//指针偏移
        
        if (blockFlags & GMYBLOCK_HAS_COPY_DISPOSE) {
            blockDesc += sizeof(void (*)(void *dst, const void *src));
            blockDesc += sizeof(void (*)(const void *));//指针偏移
        }
        
        const char *signature = (*(const char **)blockDesc);//根据指针取值
        //由NSInvocation对象调用
        NSMethodSignature *blockSignature = [NSMethodSignature signatureWithObjCTypes:signature];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:blockSignature];
        [invocation setTarget:block];
        NSString *str = @"block";
        [invocation setArgument:&str atIndex:1];
        [invocation invoke];
    }
    
}

- (void)test4 {//封装test3
    void (^block)(NSString *) = ^(NSString *str){
        NSLog(@"block: %@", str);
    };
    GMYBlockDescription *blockDesc = [[GMYBlockDescription alloc] initWithGMYBlock:block];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:blockDesc.blockSignature];
    [invocation setTarget:block];
    NSString *str = @"block";
    [invocation setArgument:&str atIndex:1];
    [invocation invoke];
}

@end
