//
//  InformationScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 27.01.2021.
//

#import "InformationScene.h"
#import "Constants.h"
#import "CurrentOrientation.h"

@implementation InformationScene{
    
    SKSpriteNode *BackgroundSprite;
    SKSpriteNode* menuBack;
    SKSpriteNode* backButtonSprite;
    SKLabelNode *LabelMenu;

    UITextView *textView;
    CurrentOrientation *currentOrientation;
    
    SKTexture *texture;
}



- (void)didMoveToView:(SKView *)view {
    [self orientation_init];
    
    [self SceneSetting];
    
    [self createBackgroundSprite];
    [self createTextView];
    [self textVewOrders];
    [self createLabelMenu];
    [self createButtonPlay];
}

-(void)orientation_init {
    currentOrientation = [[CurrentOrientation alloc] init];
}

-(void)SceneSetting
{
    [self addObservers];
 }


- (void) orientationChanged:(NSNotification *)note
{
    [self removeAllChildren];
    [self removeTextView];
    [self createBackgroundSprite];
    [self createTextView];
    [self textVewOrders];
    [self createLabelMenu];
    [self createButtonPlay];
    
}


-(void)createTextView
{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        textView = [[UITextView alloc] initWithFrame:CGRectMake(200, 400, 400, 170)];
        
        if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
            textView = [[UITextView alloc] initWithFrame:CGRectMake(200, 400, 300, 240)];
        }
   
        [textView  setFont: [UIFont fontWithName:@"Capture it(RUS BY LYAJKA)" size:11]];
        
        } else if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
          
            textView = [[UITextView alloc] initWithFrame:CGRectMake(200, 400, 700, 270)];  
            [textView  setFont: [UIFont fontWithName:@"Capture it(RUS BY LYAJKA)" size:20]];
        
          }
    
    textView.center = self.view.center;
    textView.textColor = [UIColor blackColor];
   
    textView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    textView.editable = NO;
    textView.selectable=NO;
    
    [self.view addSubview:textView];
}


-(void)setTextView:(NSString*) text{
    
    textView.text = text;
}

-(void)removeTextView{
    
    [textView removeFromSuperview];
}


-(void)textVewOrders{
    
    switch ([self getDestroyedUD]) {
        case 0:
            [self setTextView: NSLocalizedString(TEXT_ORDERS_1, @"Ensign")];
            break;
            
        case 50:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Lieutenant (junior grade). To award the Navy and Marine Corps Achievement Medal for achievements in combat or non-combat situations.\n\nMove forward to a given square and begin a combat mission.", @"Lieutenant (junior grade)")];
            
            [self makeAward:NSLocalizedString(@"US_1", nil) :NSLocalizedString(@"US_1_Sprite", nil) :NSLocalizedString(@"US_1_SpriteName", nil) :NSLocalizedString(@"250", nil)];
            break;
            
            
        case 100:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Lieutenant.\n\nMove forward into the given square and begin the combat mission.", @"Lieutenant")];
            break;
            
            
        case 150:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Lieutenant commander.\n\nMove forward into the given square and begin the combat mission.", @"Lieutenant commander")];
            break;
            
        case 200:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Commander. To award the Navy and Marine Corps Commendation Medal for heroism.\n\nMove forward into a given square and begin a combat mission.", @"Commander")];
                
            [self makeAward:NSLocalizedString(@"US_2", nil) :NSLocalizedString(@"US_2_Sprite", nil) :NSLocalizedString(@"US_2_SpriteName", nil) :NSLocalizedString(@"250", nil)];
            break;
            
        case 300:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Captain.\n\nMove forward into the given square and begin the combat mission.", @"Captain")];
            break;
            
        case 400:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Rear admiral (lower half).\n\nMove forward into the given square and begin the combat mission.", @"Rear admiral (lower half)")];
            break;
            
        case 500:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Rear admiral. To award the Navy Distinguished Service Medal for exceptionally dignified service within the framework of great responsibility.\n\nMove forward into the given square and begin the combat mission.", @"Rear admiral")];
            [self makeAward:NSLocalizedString(@"US_3", nil) :NSLocalizedString(@"US_3_Sprite", nil) :NSLocalizedString(@"US_3_SpriteName", nil) :NSLocalizedString(@"250", nil)];
            break;
            
        case 750:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Vice admiral.\n\nMove forward into the given square and begin the combat mission.", @"Vice admiral")];
            break;
            
        case 1000:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Admiral. Award the Navy Cross for extraordinary heroism in battle.\n\nMove forward into the given square and begin the combat mission.", @"Admiral")];
            [self makeAward:NSLocalizedString(@"US_4", nil) :NSLocalizedString(@"US_4_Sprite", nil) :NSLocalizedString(@"US_4_SpriteName", nil) :NSLocalizedString(@"250", nil)];
            break;
            
        case 2000:
            [self setTextView:NSLocalizedString(@"You have been awarded the next military rank Fleet admiral. To award the Medal of Honor for outstanding courage and courage at the risk of life and exceeding duty.\n\nMove forward into the given square and begin the combat mission.", @"Fleet admiral")];
            [self makeAward:NSLocalizedString(@"US_5", nil) :NSLocalizedString(@"US_5_Sprite", nil) :NSLocalizedString(@"US_5_SpriteName", nil) :NSLocalizedString(@"250", nil)];
            break;

        default:
            break;
    }
}


-(int)getDestroyedUD{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue];
}
    

//imageNamed - RU_*, spriteName - RU_*_Sprite, name - RU_*_SpriteName, int_y - 230
//imageNamed - US_*, spriteName - US_*_Sprite, name - US_*_SpriteName, int_y - 250

-(void) makeAward: (NSString*)imageNamed : (SKSpriteNode*)spriteName : (NSString*)name : (NSString*)int_y {
    
    texture = [SKTexture textureWithImageNamed:imageNamed];
    spriteName = [SKSpriteNode spriteNodeWithTexture:texture];
    spriteName.anchorPoint = CGPointMake(0.5, 0.5);
    spriteName.size = CGSizeMake(SHIRINA_O, VISOTA_O);
    spriteName.position = CGPointMake(0, -self.frame.size.height/2+[int_y floatValue]);
    spriteName.name = name;
    spriteName.scene.scaleMode = SKSceneScaleModeAspectFill;
    spriteName.zPosition=0;
    [self addChild:spriteName];
}
    
-(void)createBackgroundSprite
{
    texture = [SKTexture textureWithImageNamed:@"list"];
    BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    BackgroundSprite.size = self.frame.size;
    BackgroundSprite.anchorPoint = CGPointMake(0.5, 0.5);
    BackgroundSprite.name = @"BackgroundSprite";
    BackgroundSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundSprite.zPosition=-1;
    [self addChild:BackgroundSprite];
}
-(void)createButtonPlay{
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"buttonPlay", nil) ];
    backButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    backButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    backButtonSprite.anchorPoint = CGPointMake(0.5, 0.5);
    backButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), -self.frame.size.height/2+100);
    backButtonSprite.name = @"menuBackButtonSprite";
    backButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    backButtonSprite.zPosition=0;
    [self addChild:backButtonSprite];
}

-(void)createLabelMenu{
    LabelMenu = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Order", nil)]];
    LabelMenu.position = CGPointMake(0, self.frame.size.height/2-150);
    LabelMenu.fontSize = 70;
    LabelMenu.fontColor = [UIColor blackColor];
    LabelMenu.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenu.name = @"Label";
    LabelMenu.zPosition=0;
    [BackgroundSprite addChild:LabelMenu];
}





-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

 UITouch *touch = [touches anyObject];
 CGPoint location = [touch locationInNode:self];
 SKNode *node = [self nodeAtPoint:location];

 if ([node.name isEqualToString:@"menuBackButtonSprite"]) {
     [self removeObservers];
     [self loadMainMenu:@"GameScene"];
    }
}

-(void)loadMainMenu:(NSString*)fileNamed{
    
    [self removeTextView];

    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:fileNamed];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
}


-(void)addObservers{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
       addObserver:self selector:@selector(orientationChanged:)
       name:UIDeviceOrientationDidChangeNotification
       object:[UIDevice currentDevice]];
}

-(void)removeObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
