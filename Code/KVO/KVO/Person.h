//
//  Person.h
//  KVO
//
//  Created by GMY on 2019/9/24.
//  Copyright © 2019 gmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *gender;

- (void)custom_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;

@end

NS_ASSUME_NONNULL_END
