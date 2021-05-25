#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define audioPlayer [SoundPlayer sharedAudioPlayer]

@interface SoundPlayer : NSObject
@property (nonatomic, retain) AVAudioPlayer *playSound;
@property (nonatomic, retain) AVAudioPlayer *playLaunch;
@property (nonatomic, retain) AVAudioPlayer *playExplosion;
+ (SoundPlayer *)sharedAudioPlayer;

@end
