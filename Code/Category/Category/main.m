//
//  main.m
//  Category
//
//  Created by 郭孟漾 on 2019/9/2.
//  Copyright © 2019 gmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *p = [[Person alloc] init];
        [p printName];
        
        p.name = @"Jack";
        NSLog(@"p.name: %@", p.name);
    }
    return 0;
}
