//
//  AdvancedMediaPlayer.h
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#ifndef AdvancedMediaPlayer_h
#define AdvancedMediaPlayer_h


#endif /* AdvancedMediaPlayer_h */

@protocol AdvancedMediaPlayer <NSObject>

- (void)playMp4WithFileName:(NSString *)fileName;
- (void)playVlcWithFileName:(NSString *)fileName;

@end
