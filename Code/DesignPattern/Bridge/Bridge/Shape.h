//
//  Shape.h
//  Bridge
//
//  Created by 郭孟漾 on 2021/8/9.
//

#import <Foundation/Foundation.h>
#import "Color.h"

@protocol Shape <NSObject>

@property (nonatomic, strong) id<Color> color;

- (void)draw;

@end
