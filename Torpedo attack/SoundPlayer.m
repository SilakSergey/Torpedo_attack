#import "SoundPlayer.h"

@implementation SoundPlayer

static SoundPlayer *sharedAudioPlayer;

+ (SoundPlayer *)sharedAudioPlayer {
    if (sharedAudioPlayer == nil) {
        sharedAudioPlayer = [[SoundPlayer alloc] init];
    }
    return sharedAudioPlayer;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initAudioPlayers];
    }
    return self;
}



- (void)initAudioPlayers {
    
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"backgroundSound"
                                         ofType:@"mp3"]];
    self.playSound = [[AVAudioPlayer alloc]
                                  initWithContentsOfURL:fileURL error:nil];
    [self.playSound prepareToPlay];
    self.playSound.numberOfLoops = -1;
    [self.playSound prepareToPlay];
    
    
    
    NSURL *fileURL_Launch = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"launch"
                                         ofType:@"mp3"]];
    self.playLaunch = [[AVAudioPlayer alloc]
                                  initWithContentsOfURL:fileURL_Launch error:nil];
    [self.playLaunch prepareToPlay];
    self.playLaunch.numberOfLoops = 0;
    [self.playLaunch prepareToPlay];

    NSURL *fileURL_Explosion = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                             pathForResource:@"explosion"
                                             ofType:@"mp3"]];
    self.playExplosion= [[AVAudioPlayer alloc]
                        initWithContentsOfURL:fileURL_Explosion error:nil];
    [self.playExplosion prepareToPlay];
    self.playExplosion.numberOfLoops = 0;
    [self.playExplosion prepareToPlay];
}
@end
