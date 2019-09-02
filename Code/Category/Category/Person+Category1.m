//
//  Person+Category1.m
//  Category
//
//  Created by 郭孟漾 on 2019/9/2.
//  Copyright © 2019 gmy. All rights reserved.
//

#import "Person+Category1.h"
#import <objc/runtime.h>

@implementation Person (Category1)

+ (void)load {
    NSLog(@"Person Category1 load");
}

- (void)printName
{
    NSLog(@"%@", @"Person Category1 printName");
}

- (void)setName:(NSString *)name
{
    objc_setAssociatedObject(self,
                             "name",
                             name,
                             OBJC_ASSOCIATION_COPY);
}

- (NSString*)name
{
    NSString *nameObject = objc_getAssociatedObject(self, "name");
    return nameObject;
}

@end
