//
//  AboutScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 20.01.2021.
//

#import "AboutScene.h"
#import "CurrentOrientation.h"
#import "Constants.h"

@implementation AboutScene{
    
    SKSpriteNode *BackgroundSprite;
    SKSpriteNode* menuBack;
    SKSpriteNode* backButtonSprite;
    
    SKLabelNode *LabelMenu;
    
    UITextView *textView;
    SKTexture* texture;
    CurrentOrientation *currentOrientation;
    
}



- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    [self orientation_init];
    [self SceneSetting];
    
    [self createBackgroundSprite];
    [self createLabelMenu];
    [self createTextView];
    [self createBackButtonSprite];
    
    
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
    [self removeAll];
    
    [self createBackgroundSprite];
    [self createLabelMenu];
    [self createTextView];
    [self createBackButtonSprite];
}


-(void)createLabelMenu {
    LabelMenu = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"About", nil)]];
    LabelMenu.position = CGPointMake(0, self.frame.size.height/2-120);
    
    if ([currentOrientation.getOrientation isEqualToString:PORTRAIT])
    {
        LabelMenu.fontSize = 50;
        
    } else {
        
        LabelMenu.fontSize = 70;
    }
    LabelMenu.fontColor = [UIColor blackColor];
    LabelMenu.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenu.name = @"Label";
    LabelMenu.zPosition=1;
    [BackgroundSprite addChild:LabelMenu];
}


-(void)createTextView {
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake(200, 400, 300, 170)];
        [textView  setFont: [UIFont fontWithName:@"Capture it(RUS BY LYAJKA)" size:11]];
        
        } else if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
          
            textView = [[UITextView alloc] initWithFrame:CGRectMake(200, 400, 600, 270)];
            [textView  setFont: [UIFont fontWithName:@"Capture it(RUS BY LYAJKA)" size:20]];
          }
    
    textView.center = self.view.center;
    textView.textColor = [UIColor blackColor];
   
    textView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    textView.editable = NO;
    textView.selectable=NO;
    textView.text = NSLocalizedString( @"The game is based on the \"Torpedo attack\" slot machine. It is intended solely for entertainment and does not purport to be historical realism. More than 20 silhouettes of real ships and submarines from around the world are presented.\n\nPurpose of the game: Hit the target ship twice.\n\nEnjoy.", nil);

    [self.view addSubview:textView];

}
-(void)removeTextView{
    [textView removeFromSuperview];
}

-(void)createBackgroundSprite
{
    texture = [SKTexture textureWithImageNamed:@"backMenuWithFon"];
    BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    BackgroundSprite.size = self.frame.size;
    BackgroundSprite.anchorPoint = CGPointMake(0.5, 0.5);
    BackgroundSprite.name = @"BackgroundSprite";
    BackgroundSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundSprite.zPosition=-1;
    [self addChild:BackgroundSprite];
}
    
-(void)createBackButtonSprite
{
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"buttonBack", nil) ];
    backButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    backButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    backButtonSprite.anchorPoint = CGPointMake(0.5, 0.5);
    backButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), -self.frame.size.height/2+100);
    backButtonSprite.name = @"menuBackButtonSprite";
    backButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    backButtonSprite.zPosition=0;
    [self addChild:backButtonSprite];
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

 UITouch *touch = [touches anyObject];
 CGPoint location = [touch locationInNode:self];

 SKNode *node = [self nodeAtPoint:location];

 if ([node.name isEqualToString:@"menuBackButtonSprite"]) {
     [[NSNotificationCenter defaultCenter] removeObserver:self];
     [self loadMainMenu];
 }


    
}

-(void)loadMainMenu{
    
    [self removeTextView];
    
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"MainMenuScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
}


-(void)removeAll{
    [LabelMenu removeFromParent];
    [textView removeFromSuperview];
}

@end
