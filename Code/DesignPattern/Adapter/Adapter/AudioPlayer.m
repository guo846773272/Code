//
//  AudioPlayer.m
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import "AudioPlayer.h"
#import "MediaAdapter.h"

@interface AudioPlayer ()

@end

@implementation AudioPlayer

- (void)playWithAudioType:(NSString *)audioType fileName:(NSString *)fileName {
    if ([audioType isEqualToString:@"mp3"]) {
        NSLog(@"Playing mp3 file. Name: %@", fileName);
    } else if ([audioType isEqualToString:@"vlc"] ||
               [audioType isEqualToString:@"mp4"]
               ) {
        MediaAdapter *mediaAdapter = [[MediaAdapter alloc] initWithAudioType:audioType];
        [mediaAdapter playWithAudioType:audioType fileName:fileName];
    } else {
        NSLog(@"Invalid media. %@ format not supported", audioType);
    }
}

@end
