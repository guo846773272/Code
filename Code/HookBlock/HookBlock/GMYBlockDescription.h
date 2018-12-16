//
//  GMYBlockDescription.h
//  HookBlock
//
//  Created by 郭孟漾 on 2018/12/15.
//  Copyright © 2018 gmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

enum {
    GMYBLOCK_DEALLOCATING =      (0x0001),  // runtime
    GMYBLOCK_REFCOUNT_MASK =     (0xfffe),  // runtime
    GMYBLOCK_NEEDS_FREE =        (1 << 24), // runtime
    GMYBLOCK_HAS_COPY_DISPOSE =  (1 << 25), // compiler
    GMYBLOCK_HAS_CTOR =          (1 << 26), // compiler: helpers have C++ code
    GMYBLOCK_IS_GC =             (1 << 27), // runtime
    GMYBLOCK_IS_GLOBAL =         (1 << 28), // compiler
    GMYBLOCK_USE_STRET =         (1 << 29), // compiler: undefined if !BLOCK_HAS_SIGNATURE
    GMYBLOCK_HAS_SIGNATURE  =    (1 << 30), // compiler
    GMYBLOCK_HAS_EXTENDED_LAYOUT=(1 << 31)  // compiler
};

struct GMY_Block_descriptor {
    uintptr_t reserved;
    uintptr_t size;
    
    void (*copy)(void *dst, const void *src);
    void (*dispose)(const void *);
    
    const char *signature;
    const char *layout;     // contents depend on BLOCK_HAS_EXTENDED_LAYOUT
};

struct GMY_Block_layout {
    void *isa;
    volatile int32_t flags; // contains ref count
    int32_t reserved;
    void (*invoke)(void *, ...);
    struct GMY_Block_descriptor_1 *descriptor;
    // imported variables
};

@interface GMYBlockDescription : NSObject

@property (nonatomic, readonly) NSMethodSignature *blockSignature;
//@property (nonatomic, readonly) unsigned long int size;
@property (nonatomic, readonly) id block;

- (instancetype)initWithGMYBlock:(id)block;

@end

NS_ASSUME_NONNULL_END
