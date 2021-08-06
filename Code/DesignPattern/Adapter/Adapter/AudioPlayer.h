//
//  AudioPlayer.h
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioPlayer : NSObject

- (void)playWithAudioType:(NSString *)audioType fileName:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
