//
//  RatingScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 27.01.2021.
//

#import "RatingScene.h"
#import "Constants.h"
#import "CurrentOrientation.h"

@implementation RatingScene{
    
    SKSpriteNode *BackgroundSprite;
    SKSpriteNode *backButtonSprite;
    SKLabelNode *LabelMenu;
    SKLabelNode *LabelInfo;
    
    SKSpriteNode *RU_1_Sprite;
    SKSpriteNode *RU_2_Sprite;
    SKSpriteNode *RU_3_Sprite;
    SKSpriteNode *RU_4_Sprite;
    SKSpriteNode *RU_5_Sprite;
    
    
    SKSpriteNode *RU_1_R_Sprite;
    SKSpriteNode *RU_2_R_Sprite;
    SKSpriteNode *RU_3_R_Sprite;
    SKSpriteNode *RU_4_R_Sprite;
    SKSpriteNode *RU_5_R_Sprite;
    SKSpriteNode *RU_6_R_Sprite;
    SKSpriteNode *RU_7_R_Sprite;
    SKSpriteNode *RU_8_R_Sprite;
    SKSpriteNode *RU_9_R_Sprite;
    SKSpriteNode *RU_10_R_Sprite;
    SKSpriteNode *RU_11_R_Sprite;
    
    
    
    SKSpriteNode *US_1_Sprite;
    SKSpriteNode *US_2_Sprite;
    SKSpriteNode *US_3_Sprite;
    SKSpriteNode *US_4_Sprite;
    SKSpriteNode *US_5_Sprite;
    
    
    SKSpriteNode *US_1_R_Sprite;
    SKSpriteNode *US_2_R_Sprite;
    SKSpriteNode *US_3_R_Sprite;
    SKSpriteNode *US_4_R_Sprite;
    SKSpriteNode *US_5_R_Sprite;
    SKSpriteNode *US_6_R_Sprite;
    SKSpriteNode *US_7_R_Sprite;
    SKSpriteNode *US_8_R_Sprite;
    SKSpriteNode *US_9_R_Sprite;
    SKSpriteNode *US_10_R_Sprite;
    SKSpriteNode *US_11_R_Sprite;
    
    SKTexture * texture;
    CurrentOrientation *currentOrientation;
    
}



- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    [self orientation_init];
    
    [self SceneSetting];
    
    [self createBackgroundSprite];
    [self createLabelMenu];
    [self createLabelinfo];
    [self createBackButtonSprite];
    [self makeRanks];
}

-(void)orientation_init {
    currentOrientation = [[CurrentOrientation alloc] init];
}

-(void)SceneSetting
{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged)
       name:UIDeviceOrientationDidChangeNotification
       object:[UIDevice currentDevice]];
    
 }




- (void) orientationChanged
{
    [self removeAll];
    [self createBackgroundSprite];
    [self createLabelMenu];
    [self createLabelinfo];
    [self createBackButtonSprite];
    [self makeRanks];
}


-(void)removeAll{
    
    [self removeAllChildren];
}


-(void)createBackgroundSprite{
        
    texture = [SKTexture textureWithImageNamed:@"fon"];
    BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    BackgroundSprite.size = self.frame.size;
    
    if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
        texture = [SKTexture textureWithImageNamed:@"fon_p"];
        BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:texture];
        BackgroundSprite.size = CGSizeMake(self.frame.size.height, self.frame.size.height);
    
    }
    BackgroundSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    BackgroundSprite.name = @"BackgroundSprite";// задаем имя.
    BackgroundSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundSprite.zPosition=-1;
    [self addChild:BackgroundSprite];//добавляем наш объект на нашу сцену.
}



-(void)createLabelMenu{
    
    texture = [SKTexture textureWithImageNamed: NSLocalizedString( @"buttonBack", nil)];
    LabelMenu = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@", NSLocalizedString(@"Ranks and awards", nil)]];
    LabelMenu.position = CGPointMake(0, self.frame.size.height/2-120);
    LabelMenu.fontSize = 70;
    if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
        LabelMenu.fontSize = 50;
    }
    LabelMenu.fontColor = [UIColor whiteColor];
    LabelMenu.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelMenu.name = @"Label";
    LabelMenu.zPosition=0;
    [BackgroundSprite addChild:LabelMenu];
}

    
-(void)createLabelinfo {
    LabelInfo = [SKLabelNode labelNodeWithText:@""];
    LabelInfo.position = CGPointMake(0, -28);
    LabelInfo.fontSize = 25;
    if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
        LabelInfo.fontSize = 20;
    }
    LabelInfo.fontColor = [UIColor blackColor];
    LabelInfo.fontName=@"Capture it(RUS BY LYAJKA)";
    LabelInfo.name = @"Label";
    LabelInfo.zPosition=0;
    [BackgroundSprite addChild:LabelInfo];
}

-(void)setLabelInfo:(NSString*) text{
    
    LabelInfo.text = text;
}
    
    
-(void)createBackButtonSprite{
    backButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    backButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    backButtonSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    backButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), -self.frame.size.height/2+100);
    backButtonSprite.name = @"menuBackButtonSprite";// задаем имя.
    backButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    backButtonSprite.zPosition=0;
    [BackgroundSprite addChild:backButtonSprite];//добавляем наш объект на нашу сцену.
}
    
-(void)makeRanks{
if ([[[NSLocale currentLocale] localeIdentifier]  containsString: @"ru_RU"]){
        [self makeRU_RANKS];
    } else {
        [self makeUS_RANKS];
    }
}

-(void)makeRU_RANKS{
       
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=0){
      
            texture = [SKTexture textureWithImageNamed:@"RU_1_R"];
            RU_1_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_1_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_1_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_1_R_Sprite.position = CGPointMake(-220+OTSPUP_P, self.frame.size.height/2-240);
                
            } else {
                RU_1_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_1_R_Sprite.position = CGPointMake(-self.frame.size.width/2+RU_1_R_Sprite.frame.size.width/2+60, self.frame.size.height/2-200);
            }
            
            
            RU_1_R_Sprite.name = @"RU_1_R_SpriteName";// задаем имя.
            RU_1_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_1_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_1_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        //50-100
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=50){
      
            texture = [SKTexture textureWithImageNamed:@"RU_2_R"];
            RU_2_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_2_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_2_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_2_R_Sprite.position = CGPointMake(RU_1_R_Sprite.frame.origin.x+RU_1_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
                
            } else {
                RU_2_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_2_R_Sprite.position = CGPointMake(RU_1_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
               
            }
            
           
            RU_2_R_Sprite.name = @"RU_2_R_SpriteName";// задаем имя.
            RU_2_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_2_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_2_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        //100-150
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=100){
      
            texture = [SKTexture textureWithImageNamed:@"RU_3_R"];
            RU_3_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_3_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
           
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_3_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_3_R_Sprite.position = CGPointMake(RU_2_R_Sprite.frame.origin.x+RU_2_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_3_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_3_R_Sprite.position = CGPointMake(RU_2_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
            
           
            RU_3_R_Sprite.name = @"RU_3_R_SpriteName";// задаем имя.
            RU_3_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_3_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_3_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        //150-200
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=150){
      
            texture = [SKTexture textureWithImageNamed:@"RU_4_R"];
            RU_4_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_4_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
           
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_4_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_4_R_Sprite.position = CGPointMake(RU_3_R_Sprite.frame.origin.x+RU_3_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_4_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_4_R_Sprite.position = CGPointMake(RU_3_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
            
          
            RU_4_R_Sprite.name = @"RU_4_R_SpriteName";// задаем имя.
            RU_4_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_4_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_4_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        //200-300
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=200){
      
            texture = [SKTexture textureWithImageNamed:@"RU_5_R"];
            RU_5_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_5_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_5_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_5_R_Sprite.position = CGPointMake(RU_4_R_Sprite.frame.origin.x+RU_4_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_5_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_5_R_Sprite.position = CGPointMake(RU_4_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
            
          
            RU_5_R_Sprite.name = @"RU_5_R_SpriteName";// задаем имя.
            RU_5_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_5_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_5_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        //300-400
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=300){
      
            texture = [SKTexture textureWithImageNamed:@"RU_6_R"];
            RU_6_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_6_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_6_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_6_R_Sprite.position = CGPointMake(RU_5_R_Sprite.frame.origin.x+RU_5_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_6_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_6_R_Sprite.position = CGPointMake(RU_5_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
           
            RU_6_R_Sprite.name = @"RU_6_R_SpriteName";// задаем имя.
            RU_6_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_6_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_6_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        //400-500
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=400){
      
            texture = [SKTexture textureWithImageNamed:@"RU_7_R"];
            RU_7_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_7_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_7_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_7_R_Sprite.position = CGPointMake(RU_6_R_Sprite.frame.origin.x+RU_6_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_7_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_7_R_Sprite.position = CGPointMake(RU_6_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
           
            RU_7_R_Sprite.name = @"RU_7_R_SpriteName";// задаем имя.
            RU_7_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_7_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_7_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        //500-750
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=500){
      
            texture = [SKTexture textureWithImageNamed:@"RU_8_R"];
            RU_8_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_8_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_8_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_8_R_Sprite.position = CGPointMake(RU_7_R_Sprite.frame.origin.x+RU_7_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_8_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_8_R_Sprite.position = CGPointMake(RU_7_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
          
            RU_8_R_Sprite.name = @"RU_8_R_SpriteName";// задаем имя.
            RU_8_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_8_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_8_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        //750-1000
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=750){
      
            texture = [SKTexture textureWithImageNamed:@"RU_9_R"];
            RU_9_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_9_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_9_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_9_R_Sprite.position = CGPointMake(RU_8_R_Sprite.frame.origin.x+RU_8_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_9_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_9_R_Sprite.position = CGPointMake(RU_8_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
          
            RU_9_R_Sprite.name = @"RU_9_R_SpriteName";// задаем имя.
            RU_9_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_9_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_9_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
       
        
        //1000-2000
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=1000){
      
            texture = [SKTexture textureWithImageNamed:@"RU_10_R"];
            RU_10_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_10_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_10_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_10_R_Sprite.position = CGPointMake(RU_9_R_Sprite.frame.origin.x+RU_9_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_10_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_10_R_Sprite.position = CGPointMake(RU_9_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
            
          
            RU_10_R_Sprite.name = @"RU_10_R_SpriteName";// задаем имя.
            RU_10_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_10_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_10_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        //2000-выше
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=2000){
      
            texture = [SKTexture textureWithImageNamed:@"RU_11_R"];
            RU_11_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_11_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_11_R_Sprite.size = CGSizeMake(SHIRINA_A_P, VISOTA_A_P);
                RU_11_R_Sprite.position = CGPointMake(RU_10_R_Sprite.frame.origin.x+RU_10_R_Sprite.frame.size.width*2+OTSPUP_P, self.frame.size.height/2-240);
            } else {
                RU_11_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                RU_11_R_Sprite.position = CGPointMake(RU_10_R_Sprite.frame.origin.x+SHIRINA_A+OTSPUT, self.frame.size.height/2-200);
            }
            
            
            
            RU_11_R_Sprite.name = @"RU_11_R_SpriteName";// задаем имя.
            RU_11_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_11_R_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_11_R_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        
        
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=50){
      
          
            texture = [SKTexture textureWithImageNamed:@"RU_1"];
            RU_1_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_1_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_1_Sprite.size = CGSizeMake(SHIRINA_O_P, VISOTA_O_P);
                RU_1_Sprite.position = CGPointMake(-173, -90);
            } else {
                RU_1_Sprite.size = CGSizeMake(SHIRINA_O, VISOTA_O);
                RU_1_Sprite.position = CGPointMake(-250, -75);
            }
            
            
           
            RU_1_Sprite.name = @"RU_1_SpriteName";// задаем имя.
            RU_1_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_1_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_1_Sprite];//добавляем наш объект на нашу сцену.
     
        }
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=200){
            
        
            texture = [SKTexture textureWithImageNamed:@"RU_2"];
            RU_2_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            RU_2_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_2_Sprite.size = CGSizeMake(SHIRINA_O_P, VISOTA_O_P);
                RU_2_Sprite.position = CGPointMake(RU_1_Sprite.frame.origin.x+148, -90);
            } else {
                RU_2_Sprite.size = CGSizeMake(SHIRINA_O, VISOTA_O);
                RU_2_Sprite.position = CGPointMake(RU_1_Sprite.frame.origin.x+215, -75);
            }
            
            RU_2_Sprite.name = @"RU_2_SpriteName";// задаем имя.
            RU_2_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            RU_2_Sprite.zPosition=0;
            [BackgroundSprite addChild:RU_2_Sprite];//добавляем наш объект на нашу сцену.
            
        }
        
     
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=500){
     
        texture = [SKTexture textureWithImageNamed:@"RU_3"];
        RU_3_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
        RU_3_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_3_Sprite.size = CGSizeMake(SHIRINA_O_P, VISOTA_O_P);
                RU_3_Sprite.position = CGPointMake(RU_2_Sprite.frame.origin.x+150, -90);
            } else {
                RU_3_Sprite.size = CGSizeMake(SHIRINA_O, VISOTA_O);
                RU_3_Sprite.position = CGPointMake(RU_2_Sprite.frame.origin.x+215, -75);
            }
            
        RU_3_Sprite.name = @"RU_3_SpriteName";// задаем имя.
        RU_3_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
        RU_3_Sprite.zPosition=0;
        [BackgroundSprite addChild:RU_3_Sprite];//добавляем наш объект на нашу сцену.
        }
        
        
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=1000){
     
        texture = [SKTexture textureWithImageNamed:@"RU_4"];
        RU_4_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
        RU_4_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_4_Sprite.size = CGSizeMake(SHIRINA_O_P, VISOTA_O_P);
                RU_4_Sprite.position = CGPointMake(RU_3_Sprite.frame.origin.x+150, -90);
            } else {
                RU_4_Sprite.size = CGSizeMake(SHIRINA_O, VISOTA_O);
                RU_4_Sprite.position = CGPointMake(RU_3_Sprite.frame.origin.x+215, -75);
            }
            
        RU_4_Sprite.name = @"RU_4_SpriteName";// задаем имя.
        RU_4_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
        RU_4_Sprite.zPosition=0;
        [BackgroundSprite addChild:RU_4_Sprite];//добавляем наш объект на нашу сцену.
        }
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=2000){
     
        texture = [SKTexture textureWithImageNamed:@"RU_5"];
        RU_5_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
        RU_5_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
            
            if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                RU_5_Sprite.size = CGSizeMake(SHIRINA_O_P, VISOTA_O_P);
                RU_5_Sprite.position = CGPointMake(RU_4_Sprite.frame.origin.x+150, -90);
            } else {
                RU_5_Sprite.size = CGSizeMake(SHIRINA_O, VISOTA_O);
                RU_5_Sprite.position = CGPointMake(RU_4_Sprite.frame.origin.x+215, -75);
            }
            
        RU_5_Sprite.name = @"RU_5_SpriteName";// задаем имя.
        RU_5_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
        RU_5_Sprite.zPosition=0;
        [BackgroundSprite addChild:RU_5_Sprite];//добавляем наш объект на нашу сцену.
        }
}
        

    -(void)makeUS_RANKS{
           //US NAVY
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=0){
          
                texture = [SKTexture textureWithImageNamed:@"US_1_R"];
                US_1_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_1_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_1_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_1_R_Sprite.position = CGPointMake(-220+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_1_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_1_R_Sprite.position = CGPointMake(-self.frame.size.width/2+US_1_R_Sprite.frame.size.width/2+60, self.frame.size.height/2-200);
                }
                
               
                US_1_R_Sprite.name = @"US_1_R_SpriteName";// задаем имя.
                US_1_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_1_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_1_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            //50-100
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=50){
          
                texture = [SKTexture textureWithImageNamed:@"US_2_R"];
                US_2_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_2_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_2_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_2_R_Sprite.position = CGPointMake(US_1_R_Sprite.frame.origin.x+US_1_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_2_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_2_R_Sprite.position = CGPointMake(US_1_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_2_R_Sprite.name = @"US_2_R_SpriteName";// задаем имя.
                US_2_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_2_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_2_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            //100-150
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=100){
          
                texture = [SKTexture textureWithImageNamed:@"US_3_R"];
                US_3_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_3_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_3_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_3_R_Sprite.position = CGPointMake(US_2_R_Sprite.frame.origin.x+US_2_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_3_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_3_R_Sprite.position = CGPointMake(US_2_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_3_R_Sprite.name = @"US_3_R_SpriteName";// задаем имя.
                US_3_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_3_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_3_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
            //150-200
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=150){
          
                texture = [SKTexture textureWithImageNamed:@"US_4_R"];
                US_4_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_4_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_4_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_4_R_Sprite.position = CGPointMake(US_3_R_Sprite.frame.origin.x+US_3_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_4_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_4_R_Sprite.position = CGPointMake(US_3_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_4_R_Sprite.name = @"US_4_R_SpriteName";// задаем имя.
                US_4_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_4_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_4_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
            //200-300
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=200){
          
                texture = [SKTexture textureWithImageNamed:@"US_5_R"];
                US_5_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_5_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_5_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_5_R_Sprite.position = CGPointMake(US_4_R_Sprite.frame.origin.x+US_4_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_5_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_5_R_Sprite.position = CGPointMake(US_4_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_5_R_Sprite.name = @"US_5_R_SpriteName";// задаем имя.
                US_5_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_5_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_5_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
            //300-400
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=300){
          
                texture = [SKTexture textureWithImageNamed:@"US_6_R"];
                US_6_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_6_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_6_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_6_R_Sprite.position = CGPointMake(US_5_R_Sprite.frame.origin.x+US_5_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_6_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_6_R_Sprite.position = CGPointMake(US_5_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_6_R_Sprite.name = @"US_6_R_SpriteName";// задаем имя.
                US_6_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_6_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_6_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
            //400-500
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=400){
          
                texture = [SKTexture textureWithImageNamed:@"US_7_R"];
                US_7_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_7_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_7_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_7_R_Sprite.position = CGPointMake(US_6_R_Sprite.frame.origin.x+US_6_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_7_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_7_R_Sprite.position = CGPointMake(US_6_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_7_R_Sprite.name = @"US_7_R_SpriteName";// задаем имя.
                US_7_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_7_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_7_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            //500-750
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=500){
          
                texture = [SKTexture textureWithImageNamed:@"US_8_R"];
                US_8_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_8_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_8_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_8_R_Sprite.position = CGPointMake(US_7_R_Sprite.frame.origin.x+US_7_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_8_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_8_R_Sprite.position = CGPointMake(US_7_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_8_R_Sprite.name = @"US_8_R_SpriteName";// задаем имя.
                US_8_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_8_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_8_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
            //750-1000
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=750){
          
                texture = [SKTexture textureWithImageNamed:@"US_9_R"];
                US_9_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_9_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_9_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_9_R_Sprite.position = CGPointMake(US_8_R_Sprite.frame.origin.x+US_8_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_9_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_9_R_Sprite.position = CGPointMake(US_8_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_9_R_Sprite.name = @"US_9_R_SpriteName";// задаем имя.
                US_9_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_9_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_9_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
           
            
            //1000-2000
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=1000){
          
                texture = [SKTexture textureWithImageNamed:@"US_10_R"];
                US_10_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_10_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_10_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_10_R_Sprite.position = CGPointMake(US_9_R_Sprite.frame.origin.x+US_9_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_10_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_10_R_Sprite.position = CGPointMake(US_9_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_10_R_Sprite.name = @"US_10_R_SpriteName";// задаем имя.
                US_10_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_10_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_10_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
            //2000-выше
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=2000){
          
                texture = [SKTexture textureWithImageNamed:@"US_11_R"];
                US_11_R_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_11_R_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_11_R_Sprite.size = CGSizeMake(SHIRINA_A_P_US, VISOTA_A_P_US);
                    US_11_R_Sprite.position = CGPointMake(US_10_R_Sprite.frame.origin.x+US_10_R_Sprite.frame.size.width*2+OTSTUP_P_US, self.frame.size.height/2-240);
                    
                } else {
                    US_11_R_Sprite.size = CGSizeMake(SHIRINA_A, VISOTA_A);
                    US_11_R_Sprite.position = CGPointMake(US_10_R_Sprite.frame.origin.x+SHIRINA_A_US+OTSTUP_US, self.frame.size.height/2-200);
                }
                
                US_11_R_Sprite.name = @"US_11_R_SpriteName";// задаем имя.
                US_11_R_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_11_R_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_11_R_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            
      
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=50){
          
              
                texture = [SKTexture textureWithImageNamed:@"US_1"];
                US_1_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_1_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_1_Sprite.size = CGSizeMake(SHIRINA_O_P_US, VISOTA_O_P_US);
                    US_1_Sprite.position = CGPointMake(-173, -90);
                } else {
                    US_1_Sprite.size = CGSizeMake(SHIRINA_O_US, VISOTA_O_US);
                    US_1_Sprite.position = CGPointMake(-250, -75);
                }
                
                
                US_1_Sprite.name = @"US_1_SpriteName";// задаем имя.
                US_1_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_1_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_1_Sprite];//добавляем наш объект на нашу сцену.
         
            }
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=200){
                
            
                texture = [SKTexture textureWithImageNamed:@"US_2"];
                US_2_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
                US_2_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_2_Sprite.size = CGSizeMake(SHIRINA_O_P_US, VISOTA_O_P_US);
                    US_2_Sprite.position = CGPointMake(US_1_Sprite.frame.origin.x+148, -90);
                } else {
                    US_2_Sprite.size = CGSizeMake(SHIRINA_O_US, VISOTA_O_US);
                    US_2_Sprite.position = CGPointMake(US_1_Sprite.frame.origin.x+210, -75);
                }
                
                US_2_Sprite.name = @"US_2_SpriteName";// задаем имя.
                US_2_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
                US_2_Sprite.zPosition=0;
                [BackgroundSprite addChild:US_2_Sprite];//добавляем наш объект на нашу сцену.
                
            }
            
         
            
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=500){
         
            texture = [SKTexture textureWithImageNamed:@"US_3"];
            US_3_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            US_3_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_3_Sprite.size = CGSizeMake(SHIRINA_O_P_US, VISOTA_O_P_US);
                    US_3_Sprite.position = CGPointMake(US_2_Sprite.frame.origin.x+148, -90);
                } else {
                    US_3_Sprite.size = CGSizeMake(SHIRINA_O_US, VISOTA_O_US);
                    US_3_Sprite.position = CGPointMake(US_2_Sprite.frame.origin.x+210, -75);
                }
                
            US_3_Sprite.name = @"US_3_SpriteName";// задаем имя.
            US_3_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            US_3_Sprite.zPosition=0;
            [BackgroundSprite addChild:US_3_Sprite];//добавляем наш объект на нашу сцену.
            }
            
            
            
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=1000){
         
            texture = [SKTexture textureWithImageNamed:@"US_4"];
            US_4_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            US_4_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_4_Sprite.size = CGSizeMake(SHIRINA_O_P_US, VISOTA_O_P_US);
                    US_4_Sprite.position = CGPointMake(US_3_Sprite.frame.origin.x+148, -90);
                } else {
                    US_4_Sprite.size = CGSizeMake(SHIRINA_O_US, VISOTA_O_US);
                    US_4_Sprite.position = CGPointMake(US_3_Sprite.frame.origin.x+210, -75);
                }
                
            US_4_Sprite.name = @"US_4_SpriteName";// задаем имя.
            US_4_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            US_4_Sprite.zPosition=0;
            [BackgroundSprite addChild:US_4_Sprite];//добавляем наш объект на нашу сцену.
            }
            
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue]>=2000){
         
            texture = [SKTexture textureWithImageNamed:@"US_5"];
            US_5_Sprite = [SKSpriteNode spriteNodeWithTexture:texture];
            US_5_Sprite.anchorPoint = CGPointMake(1, 1); //задаем начальную точку.
                
                if ([currentOrientation.getOrientation isEqualToString:PORTRAIT]){
                    US_5_Sprite.size = CGSizeMake(SHIRINA_O_P_US, VISOTA_O_P_US);
                    US_5_Sprite.position = CGPointMake(US_4_Sprite.frame.origin.x+155, -90);
                } else {
                    US_5_Sprite.size = CGSizeMake(SHIRINA_O_US, VISOTA_O_US);
                    US_5_Sprite.position = CGPointMake(US_4_Sprite.frame.origin.x+215, -75);
                }
                
            US_5_Sprite.name = @"US_5_SpriteName";// задаем имя.
            US_5_Sprite.scene.scaleMode = SKSceneScaleModeAspectFill;
            US_5_Sprite.zPosition=0;
            [BackgroundSprite addChild:US_5_Sprite];//добавляем наш объект на нашу сцену.
            }
        }
        

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"menuBackButtonSprite"]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self loadMainMenu];
    }
    
    [self getAward:node.name];
    
}

-(void)getAward:(NSString*)name
{
    if ([name rangeOfString:@"_1_R_SpriteName"].location != NSNotFound){[self setLabelInfo:NSLocalizedString(@"Ensign", @"Ensign")];}
    if ([name rangeOfString:@"_2_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Lieutenant(junior grade)", @"Lieutenant(junior grade)")];}
    if ([name rangeOfString:@"_3_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Lieutenant", @"Lieutenant")];}
    if ([name rangeOfString:@"_4_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Lieutenant commander", @"Lieutenant commander")];}
    if ([name rangeOfString:@"_5_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Commander", @"Commander")];}
    if ([name rangeOfString:@"_6_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Captain", @"Captain")];}
    if ([name rangeOfString:@"_7_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Rear admiral (lower half)", @"Rear admiral (lower half)")];}
    if ([name rangeOfString:@"_8_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Rear admiral", @"Rear admiral")];}
    if ([name rangeOfString:@"_9_R_SpriteName"].location != NSNotFound) { [self setLabelInfo:NSLocalizedString(@"Vice admiral", @"Vice admiral")];}
    if ([name rangeOfString:@"_10_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Admiral", @"Admiral")];}
    if ([name rangeOfString:@"_11_R_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Fleet admiral", @"Fleet admiral")];}
    if ([name rangeOfString:@"_1_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Navy and Marine Corps Achievement Medal", @"Navy and Marine Corps Achievement Medal")];}
    if ([name rangeOfString:@"_2_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Navy and Marine Corps Commendation Medal", @"Navy and Marine Corps Commendation Medal")];}
    if ([name rangeOfString:@"_3_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Navy Distinguished Service Medal", @"Navy Distinguished Service Medal")];}
    if ([name rangeOfString:@"_4_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Navy Cross", @"Navy Cross")];}
    if ([name rangeOfString:@"_5_SpriteName"].location != NSNotFound) {[self setLabelInfo:NSLocalizedString(@"Medal of Honor", @"Medal of Honor")];}
}

-(void)loadMainMenu{
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"MainMenuScene"];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
}

@end
