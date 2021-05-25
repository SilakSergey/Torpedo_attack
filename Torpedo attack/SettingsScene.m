//
//  SettingsScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 20.01.2021.
//

#import "SettingsScene.h"
#import "Constants.h"
#import "CurrentOrientation.h"

@implementation SettingsScene{
    
    SKSpriteNode *BackgroundSprite;
    SKSpriteNode *backButtonSprite;
    SKSpriteNode *menuBack;
    SKSpriteNode *switcherMusicSprite;
    SKSpriteNode *switcherEffectsSprite;
    SKSpriteNode *switcherHardModeSprite;

    
    SKLabelNode *LabelMenu;
    SKLabelNode *LabelMenuSoundMusic;
    SKLabelNode *LabelMenuSoundEffects;
    SKLabelNode *LabelMenuHardMode;
    
    SKTexture *texture;
    CurrentOrientation *currentOrientation;
}



- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    [self orientation_init];
    
    [self SceneSetting];
    
    [self createBackgroundSprite];
    [self createBackButtonSprite];
    
    [self createLabelSettings:currentOrientation.getOrientation];
    
}

-(void)orientation_init {
    currentOrientation = [[CurrentOrientation alloc] init];
}

-(void)SceneSetting
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
       addObserver:self selector:@selector(orientationChanged:)
       name:UIDeviceOrientationDidChangeNotification
       object:[UIDevice currentDevice]];
 }



- (void) orientationChanged:(NSNotification *)note
{
    [self createLabelSettings:currentOrientation.getOrientation];
}


-(void)createBackgroundSprite{
    texture = [SKTexture textureWithImageNamed:@"backMenuWithFon"];
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    BackgroundSprite.size = self.frame.size; // Задаем размер.
    BackgroundSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    BackgroundSprite.name = @"BackgroundSprite";// задаем имя.
    BackgroundSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundSprite.zPosition=-1;
    [self addChild:BackgroundSprite];//добавляем наш объект на нашу сцену.
}
    -(void)createBackButtonSprite{
    texture = [SKTexture textureWithImageNamed: NSLocalizedString( @"buttonBack", nil)];
    backButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    backButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    backButtonSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    backButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), -self.frame.size.height/2+100);
    backButtonSprite.name = @"menuBackButtonSprite";// задаем имя.
    backButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    backButtonSprite.zPosition=0;
    [self addChild:backButtonSprite];//добавляем наш объект на нашу сцену.
}

-(void)createLabelSettings:(NSString*) orientation
{
    [self removeAllLabels];
    
    int XLabel1;
    int XLabel2;
    int XLabel3;
    
    
    if ([orientation isEqualToString:PORTRAIT]){
        
        //P
        XLabel1=-170;
        XLabel2=-120;
        XLabel3=-140;
        
        if ([[[NSLocale currentLocale] localeIdentifier]  containsString: @"ru_RU"]){
            
            XLabel1=-160;
            XLabel2=-80;
            XLabel3=-90;
        }

    } else {
        
        XLabel1=282;
        XLabel2=355;
        XLabel3=330;
        
        if ([[[NSLocale currentLocale] localeIdentifier]  containsString: @"ru_RU"]){
            
            XLabel1=282;
            XLabel2=400;
            XLabel3=385;
        }
    }
    
    LabelMenu = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Settings", nil)]];
    LabelMenu.position = CGPointMake(0, self.frame.size.height/2-120);
    
    if ([orientation isEqualToString:PORTRAIT]){
        
        LabelMenu.fontSize = 50;
        
    } else {
        
        LabelMenu.fontSize = 70;
    }
    
    
    LabelMenu.fontColor = [UIColor blackColor];
    LabelMenu.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenu.name = @"Label";
    LabelMenu.zPosition=1;
    [BackgroundSprite addChild:LabelMenu];
    
    LabelMenuSoundMusic = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Music", nil)]];
    if ([orientation isEqualToString:PORTRAIT]){
        
        LabelMenuSoundMusic.position = CGPointMake(XLabel1, 50);
        LabelMenuSoundMusic.fontSize = 25;
        
    } else {
        
        LabelMenuSoundMusic.position = CGPointMake(self.frame.origin.x+XLabel1, 50);
        LabelMenuSoundMusic.fontSize = 35;
    }
   
    LabelMenuSoundMusic.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenuSoundMusic.name = @"LabelMenuSoundMusic";
    LabelMenuSoundMusic.fontColor = [UIColor blackColor];
    LabelMenuSoundMusic.zPosition=1;
    [BackgroundSprite addChild:LabelMenuSoundMusic];
    
//
    LabelMenuSoundEffects = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Sound effects", nil)]];
    if ([orientation isEqualToString:PORTRAIT]){
        
       
        LabelMenuSoundEffects.position = CGPointMake(XLabel2, -50);
        LabelMenuSoundEffects.fontSize = 25;
        
    } else {
        
        LabelMenuSoundEffects.position = CGPointMake(self.frame.origin.x+XLabel2, -50);
        LabelMenuSoundEffects.fontSize = 35;

    }
    
   
    LabelMenuSoundEffects.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenuSoundEffects.name = @"LabelMenuSoundEffects";
    LabelMenuSoundEffects.fontColor = [UIColor blackColor];
    LabelMenuSoundEffects.zPosition=1;
    [BackgroundSprite addChild:LabelMenuSoundEffects];
    
    
    
    
    //
    LabelMenuHardMode = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Hard mode", nil)]];
    if ([orientation isEqualToString:PORTRAIT]){
        
        LabelMenuHardMode.position = CGPointMake(XLabel3, -150);
        LabelMenuHardMode.fontSize = 25;
        
    } else {
        
        LabelMenuHardMode.position = CGPointMake(self.frame.origin.x+XLabel3, -150);
        LabelMenuHardMode.fontSize = 35;
    }
    
   
    LabelMenuHardMode.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenuHardMode.name = @"LabelMenuHardMode";
    LabelMenuHardMode.fontColor = [UIColor blackColor];
    LabelMenuHardMode.zPosition=1;
    [BackgroundSprite addChild:LabelMenuHardMode];
    
    [self addSound];
    [self addEffects];
    [self addHardMode];
}

-(void)removeAllLabels
{
    [LabelMenu removeFromParent];
    [LabelMenuSoundMusic removeFromParent];
    [LabelMenuSoundEffects removeFromParent];
    [LabelMenuHardMode removeFromParent];
}


-(void)addSound{
    
    [switcherMusicSprite removeFromParent];
    
    texture = [SKTexture textureWithImageNamed:@"offButton"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SOUNDBACKGROUND_KEY] isEqualToString:@"ON"]){
        
        texture = [SKTexture textureWithImageNamed:@"onButton"];
    }
    
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    switcherMusicSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    switcherMusicSprite.size = CGSizeMake(95, 50);
    switcherMusicSprite.position = CGPointMake(200, self.frame.size.height/2-35);
    switcherMusicSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    switcherMusicSprite.name = @"switcherMusicSprite";// задаем имя.
    switcherMusicSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    switcherMusicSprite.zPosition=1;
    [backButtonSprite addChild:switcherMusicSprite];//добавляем наш объект на нашу сцену.
}

-(void)addEffects{
    
    [switcherEffectsSprite removeFromParent];
    
    texture = [SKTexture textureWithImageNamed:@"offButton"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SOUNDEFFECTS_KEY] isEqualToString:@"ON"]){
        
        texture = [SKTexture textureWithImageNamed:@"onButton"];
    }
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    switcherEffectsSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    switcherEffectsSprite.size = CGSizeMake(95, 50);
    switcherEffectsSprite.position = CGPointMake(200, self.frame.size.height/2-135);
    switcherEffectsSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    switcherEffectsSprite.name = @"switcherEffectsSprite";// задаем имя.
    switcherEffectsSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    switcherEffectsSprite.zPosition=1;
    [backButtonSprite addChild:switcherEffectsSprite];//добавляем наш объект на нашу сцену.
}


-(void)addHardMode{
    
    [switcherHardModeSprite removeFromParent];
    
    texture = [SKTexture textureWithImageNamed:@"offButton"];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:HARD_KEY] isEqualToString:@"ON"]){
        
        texture = [SKTexture textureWithImageNamed:@"onButton"];
    }
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    switcherHardModeSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    switcherHardModeSprite.size = CGSizeMake(95, 50);
    switcherHardModeSprite.position = CGPointMake(200, self.frame.size.height/2-235);
    switcherHardModeSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    switcherHardModeSprite.name = @"switcherHardMode";// задаем имя.
    switcherHardModeSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    switcherHardModeSprite.zPosition=1;
    [backButtonSprite addChild:switcherHardModeSprite];//добавляем наш объект на нашу сцену.
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

 UITouch *touch = [touches anyObject];
 CGPoint location = [touch locationInNode:self];

 SKNode *node = [self nodeAtPoint:location];

 if ([node.name isEqualToString:@"menuBackButtonSprite"]) {
     [[NSNotificationCenter defaultCenter] removeObserver:self];
     [self loadMainMenu];
 }

    
    if ([node.name isEqualToString:@"switcherMusicSprite"]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:SOUNDBACKGROUND_KEY] isEqualToString:@"ON"]){
            
            [[NSUserDefaults standardUserDefaults] setObject:@"OFF" forKey:SOUNDBACKGROUND_KEY];
            
            [audioPlayer.playSound stop];
          
            
        } else {
            
            
            [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:SOUNDBACKGROUND_KEY];
            
            
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [switcherMusicSprite removeFromParent];
        
        [self addSound];
        
       
    }
    
    if ([node.name isEqualToString:@"switcherEffectsSprite"]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:SOUNDEFFECTS_KEY] isEqualToString:@"ON"]){
            
            [[NSUserDefaults standardUserDefaults] setObject:@"OFF" forKey:SOUNDEFFECTS_KEY];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:SOUNDEFFECTS_KEY];
            
        }
       
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [switcherEffectsSprite removeFromParent];
        
        [self addEffects];
    }
    
    
    if ([node.name isEqualToString:@"switcherHardMode"]) {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:HARD_KEY] isEqualToString:@"ON"]){
            
            [[NSUserDefaults standardUserDefaults] setObject:@"OFF" forKey:HARD_KEY];
            
        } else {
            
            [[NSUserDefaults standardUserDefaults] setObject:@"ON" forKey:HARD_KEY];
            
        }
       
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [switcherHardModeSprite removeFromParent];
        
        [self addHardMode];
    }
    
    
    
    
}

-(void)loadMainMenu{
    
    // Load the SKScene from 'GameScene.sks'
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"MainMenuScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
}


@end
