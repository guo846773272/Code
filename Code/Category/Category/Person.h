//
//  Person.h
//  Category
//
//  Created by 郭孟漾 on 2019/9/2.
//  Copyright © 2019 gmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (void)printName;

@end

@interface Person(Test)

@property(nonatomic, copy) NSString *name;

- (void)printName;

@end

