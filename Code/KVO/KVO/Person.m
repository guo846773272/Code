//
//  Person.m
//  KVO
//
//  Created by GMY on 2019/9/24.
//  Copyright © 2019 gmy. All rights reserved.
//

#import "Person.h"

#import <objc/runtime.h>
#import <objc/message.h>

static const char *custom_observer = "custom_observer";
static const char *custom_getter = "custom_getter";
static const char *custom_setter = "custom_setter";

@implementation Person

void setMethod(id self, SEL _cmd, id newValue) {
    
    //getter
    NSString *getterName = objc_getAssociatedObject(self, custom_getter);
    
    //setter
    NSString *setterName = objc_getAssociatedObject(self, custom_setter);
    
    Class class = [self class];
    
    //isa指向原类
    object_setClass(self, class_getSuperclass(class));
    
    //获取旧值
    id oldValue = objc_msgSend(self, NSSelectorFromString(getterName));
    
    //调用原类set方法
    objc_msgSend(self, NSSelectorFromString([setterName stringByAppendingString:@":"]), newValue);
    
    id observer = objc_getAssociatedObject(self, custom_observer);
    
    NSMutableDictionary *change = [NSMutableDictionary dictionary];
    if (newValue)
        change[NSKeyValueChangeNewKey] = newValue;
    if (oldValue)
        change[NSKeyValueChangeOldKey] = oldValue;
    
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), getterName, self, change, nil);
    
    object_setClass(self, class);
}

- (void)custom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context {
    
    //创建指定前缀CustomKVONotifying_%@的子类并注册
    NSString *curClassName = NSStringFromClass([self class]);
    NSString *customClassName = [NSString stringWithFormat:@"CustomKVONotifying_%@", curClassName];
    
    Class customClass = objc_getClass(customClassName.UTF8String);
    if (!customClass) {
        customClass = objc_allocateClassPair([self class], customClassName.UTF8String, 0);
        objc_registerClassPair(customClass);
    }
    
    //set方法首字母大写
    NSString *keyPathChange = [[[keyPath substringToIndex:1] uppercaseString] stringByAppendingString:[keyPath substringFromIndex:1]];
    NSString *setNameStr = [NSString stringWithFormat:@"set%@", keyPathChange];
    SEL setSEL = NSSelectorFromString([setNameStr stringByAppendingString:@":"]);
    
    //添加set方法
    Method getMethod = class_getInstanceMethod([self class], @selector(keyPath));
    const char *types = method_getTypeEncoding(getMethod);
    class_addMethod(customClass, setSEL, (IMP)setMethod, types);
    
    //修改isa
    object_setClass(self, customClass);
    
    //保存observer
    objc_setAssociatedObject(self, custom_observer, observer, OBJC_ASSOCIATION_ASSIGN);
    
    //保存set、get方法名
    objc_setAssociatedObject(self, custom_setter, setNameStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, custom_getter, keyPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

@end
