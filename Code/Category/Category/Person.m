//
//  Person.m
//  Category
//
//  Created by 郭孟漾 on 2019/9/2.
//  Copyright © 2019 gmy. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)load {
    NSLog(@"Person load");
}

- (void)printName
{
    NSLog(@"%@",@"Person printName");
}

@end

@implementation Person(Test)

+ (void)load {
    NSLog(@"Person Test load");
}

- (void)printName
{
    NSLog(@"%@", @"Person Test printName");
}

@end
