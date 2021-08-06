//
//  MediaAdapter.h
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import <Foundation/Foundation.h>
#import "MediaPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface MediaAdapter : NSObject<MediaPlayer>

- (instancetype)initWithAudioType:(NSString *)audioType;

@end

NS_ASSUME_NONNULL_END
