//
//  Strategy.h
//  Strategy
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import <Foundation/Foundation.h>

@protocol Strategy <NSObject>

@required
- (NSInteger)doOperationWithNum1:(NSInteger)num1 num2:(NSInteger)num2;

@end
