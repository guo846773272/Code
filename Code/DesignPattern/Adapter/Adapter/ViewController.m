//
//  ViewController.m
//  Adapter
//
//  Created by 郭孟漾 on 2021/8/5.
//

#import "ViewController.h"
#import "AudioPlayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AudioPlayer *audioPlayer = [[AudioPlayer alloc] init];
    [audioPlayer playWithAudioType:@"mp3" fileName:@"mp3 music"];
    [audioPlayer playWithAudioType:@"mp4" fileName:@"mp4 video"];
    [audioPlayer playWithAudioType:@"vlc" fileName:@"vlc video"];
    [audioPlayer playWithAudioType:@"avi" fileName:@"avi video"];
}


@end
