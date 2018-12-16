//
//  GMYBlockDescription.m
//  HookBlock
//
//  Created by 郭孟漾 on 2018/12/15.
//  Copyright © 2018 gmy. All rights reserved.
//

#import "GMYBlockDescription.h"

@interface GMYBlockDescription ()

@property (nonatomic, assign) NSInteger blockFlags;

@end

@implementation GMYBlockDescription

- (instancetype)initWithGMYBlock:(id)block {
    if (self = [super init]) {
        struct GMY_Block_layout *blockLayout = (__bridge struct GMY_Block_layout *)block;
        
        //判断是否标识
        //有方法签名
        _blockFlags = blockLayout->flags;
        if (_blockFlags & GMYBLOCK_HAS_SIGNATURE) {
            void *blockDesc = blockLayout->descriptor;
            blockDesc += 2 * sizeof(uintptr_t);
            
            if (_blockFlags & GMYBLOCK_HAS_COPY_DISPOSE) {
                blockDesc += sizeof(void (*)(void *dst, const void *src));
                blockDesc += sizeof(void (*)(const void *));
            }
            
            const char *signature = (*(const char **)blockDesc);
            _blockSignature = [NSMethodSignature signatureWithObjCTypes:signature];
        }
    }
    return self;
}

@end
