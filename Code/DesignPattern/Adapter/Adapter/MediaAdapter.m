//
//  MediaAdapter.m
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import "MediaAdapter.h"
#import "AdvancedMediaPlayer.h"
#import "VlcPlayer.h"
#import "Mp4Player.h"

@interface MediaAdapter ()

@property (nonatomic, strong) id<AdvancedMediaPlayer>advancedMusicPlayer;

@end

@implementation MediaAdapter

- (instancetype)initWithAudioType:(NSString *)audioType {
    if (self = [super init]) {
        if ([audioType isEqualToString:@"vlc"]) {
            _advancedMusicPlayer = [[VlcPlayer alloc] init];
        } else if ([audioType isEqualToString:@"mp4"]) {
            _advancedMusicPlayer = [[Mp4Player alloc] init];
        }
    }
    return self;
}

- (void)playWithAudioType:(NSString *)audioType fileName:(NSString *)fileName {
    if ([audioType isEqualToString:@"vlc"]) {
        [self.advancedMusicPlayer playVlcWithFileName:fileName];
    } else if ([audioType isEqualToString:@"mp4"]) {
        [self.advancedMusicPlayer playMp4WithFileName:fileName];
    }
}

@end
