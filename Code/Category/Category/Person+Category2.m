//
//  Person+Category2.m
//  Category
//
//  Created by 郭孟漾 on 2019/9/2.
//  Copyright © 2019 gmy. All rights reserved.
//

#import "Person+Category2.h"

@implementation Person (Category2)

+ (void)load {
    NSLog(@"Person Category2 load");
}

- (void)printName
{
    NSLog(@"%@", @"Person Category2 printName");
}

@end
