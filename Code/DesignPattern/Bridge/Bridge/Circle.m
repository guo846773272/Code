//
//  Circle.m
//  Bridge
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "Circle.h"

@implementation Circle

@synthesize color;

- (void)draw {
    [self.color bepaintWithShape:@"圆形"];
}

@end
