//
//  Square.m
//  Bridge
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import "Square.h"

@implementation Square

@synthesize color;

- (void)draw {
    [self.color bepaintWithShape:@"正方形"];
}

@end
