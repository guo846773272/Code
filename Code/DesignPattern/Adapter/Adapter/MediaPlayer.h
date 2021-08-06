//
//  MediaPlayer.h
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import <Foundation/Foundation.h>

@protocol MediaPlayer <NSObject>

- (void)playWithAudioType:(NSString *)audioType fileName:(NSString *)fileName;

@end
