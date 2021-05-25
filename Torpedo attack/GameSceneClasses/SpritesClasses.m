//
//  SpritesClasses.m
//  Torpedo attack
//
//  Created by Sergey Silak on 06.05.2021.
//

#import "SpritesClasses.h"
#import "Constants.h"
#import "CurrentOrientation.h"

@implementation SpritesClasses{
    
    SKSpriteNode *BackgroundSprite;
}

@synthesize BackgroundSprite;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateBackgroundSprite];
    }
    
    return self;
}


-(void)CreateBackgroundSprite
{
    SKTexture* TextureBackgroundSprite = [SKTexture textureWithImageNamed:@"sky"];
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:TextureBackgroundSprite];
    BackgroundSprite.size = self.frame.size;
    BackgroundSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    BackgroundSprite.name = @"BackgroundSprite";// задаем имя.
    BackgroundSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundSprite.zPosition=1;
}

@end



//-------NEW INTERFACE------------//
@implementation SpritesClassesWater{
    
    SKSpriteNode *BackgroundWaterSprite;
}

@synthesize BackgroundWaterSprite;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateBackgroundWaterSprite];
    }
    
    return self;
}


#pragma mark CreateBackgroundWaterSprite

-(void)CreateBackgroundWaterSprite
{
   //animated background
    NSMutableArray * runTexture=[NSMutableArray new];
    
    for (int i=0; i<120; i++) {
        
        [runTexture addObject:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
  
    BackgroundWaterSprite = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"1.png"]];
    BackgroundWaterSprite.anchorPoint = CGPointMake(0, 0); //задаем начальную точку.
    BackgroundWaterSprite.name = @"BackgroundWaterSprite";// задаем имя.
    BackgroundWaterSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundWaterSprite.size = CGSizeMake(1024, 250);
    BackgroundWaterSprite.zPosition=3;
    SKAction* runAnimation = [SKAction animateWithTextures:runTexture timePerFrame:0.06 resize:YES restore:NO];
    [BackgroundWaterSprite runAction:[SKAction repeatActionForever:runAnimation]];
}

@end




//-------NEW INTERFACE------------//
@implementation SpritesClassesRockLeft{
    
    SKSpriteNode *RockSpriteLeft;
}

@synthesize RockSpriteLeft;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateRockSpriteLeft];
    }
    
    return self;
}



#pragma mark CreateRockSpriteLeft

-(void)CreateRockSpriteLeft
{
    //--------------------------------------------------------------
    SKTexture* TextureRockSpriteLeft = [SKTexture textureWithImageNamed:@"rockLeft"];
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    RockSpriteLeft = [SKSpriteNode spriteNodeWithTexture:TextureRockSpriteLeft];
    RockSpriteLeft.size = CGSizeMake(ROCK_WIDTH, ROCK_HEIGHT);
    
    RockSpriteLeft.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    RockSpriteLeft.name = @"RockSpriteLeft";// задаем имя.
    RockSpriteLeft.scene.scaleMode = SKSceneScaleModeAspectFit;
    RockSpriteLeft.zPosition=5;
}

@end




//-------NEW INTERFACE------------//
@implementation SpritesClassesRockRight{
    
    SKSpriteNode *RockSpriteRight;
}

@synthesize RockSpriteRight;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateRockSpriteRight];
    }
    
    return self;
}

#pragma mark CreateRockSpriteRight

-(void)CreateRockSpriteRight
{
    //--------------------------------------------------------------
    SKTexture*  TextureRockSpriteRight = [SKTexture textureWithImageNamed:@"rockRight"];
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    RockSpriteRight = [SKSpriteNode spriteNodeWithTexture:TextureRockSpriteRight];
    RockSpriteRight.size = CGSizeMake(ROCK_WIDTH, ROCK_HEIGHT);
    RockSpriteRight.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    RockSpriteRight.name = @"RockSpriteRight";// задаем имя.
    RockSpriteRight.scene.scaleMode = SKSceneScaleModeAspectFit;
    RockSpriteRight.zPosition=5;
}

@end




//-------NEW INTERFACE------------//
@implementation SpritesClassesBinokleSprite{
    
    SKSpriteNode *binokleSprite;
    NSString *binokleName;
}

@synthesize binokleSprite, binokleName;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateBinokleSprite:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}


#pragma mark ADD SPRITES ON SCENE

-(void)CreateBinokleSprite:(NSString *)orientation{
    
    binokleName = BINOKLE_NAME_MAIN;
    SKTexture* TexturebinokleSprite = [SKTexture textureWithImageNamed:binokleName];
    binokleSprite = [SKSpriteNode spriteNodeWithTexture:TexturebinokleSprite];
    binokleSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    binokleSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    binokleSprite.name = @"binokleSprite";// задаем имя.
    binokleSprite.zPosition=10;

}
@end


//-------NEW INTERFACE------------//
@implementation SpritesClassesMenuButtonSprite{
    
    SKSpriteNode *menuButtonSprite;

}

@synthesize menuButtonSprite ;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateMenuButtonSprite:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}



#pragma mark CREATE MAIN MENU SPRITE

-(void)CreateMenuButtonSprite: (NSString *)orientation{
   
    SKTexture *Texture = [SKTexture textureWithImageNamed:@"buttonMenu"];
    
    if ([[[NSLocale currentLocale] localeIdentifier]  containsString: @"ru_RU"]){
        
        Texture = [SKTexture textureWithImageNamed:@"buttonMenu_RU"];
    }
    
    menuButtonSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
   
    
    menuButtonSprite.anchorPoint = CGPointMake(0, 0); //задаем начальную точку.
    menuButtonSprite.name = @"menuButtonSprite";// задаем имя.
    menuButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    menuButtonSprite.zPosition=11;
    
    
}

@end



//-------NEW INTERFACE------------//
@implementation SpritesClassesStrikePointerSprite{
    
    SKSpriteNode *strikePointerSprite;

}

@synthesize strikePointerSprite ;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateStrikePointerSprite:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}




#pragma mark CreateStrikePointerSprite

-(void)CreateStrikePointerSprite: (NSString *)orientation{
    
    SKTexture *Texture = [SKTexture textureWithImageNamed:@"strikePointer"];
    
    if ([[[NSLocale currentLocale] localeIdentifier]  containsString: @"ru_RU"]){
        
        Texture = [SKTexture textureWithImageNamed:@"strikePointer_RU"];
        
    }
    
    strikePointerSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
    strikePointerSprite.anchorPoint = CGPointMake(0, 0); //задаем начальную точку.
    strikePointerSprite.name = @"strikePointerSprite";// задаем имя.
    strikePointerSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    strikePointerSprite.zPosition=11;
   
}


@end






//-------NEW INTERFACE------------//
@implementation SpritesClassesDestroyPointerSprite{
    
    SKSpriteNode *destroyPointerSprite;

}

@synthesize destroyPointerSprite ;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateDestroyPointerSprite:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}




#pragma mark CreateDestroyPointerSprite

-(void)CreateDestroyPointerSprite: (NSString *)orientation{

    SKTexture *Texture = [SKTexture textureWithImageNamed:@"destroyPointer"];
    
    if ([[[NSLocale currentLocale] localeIdentifier]  containsString: @"ru_RU"]){
        
        Texture = [SKTexture textureWithImageNamed:@"destroyPointer_RU"];
        
    }
    
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    destroyPointerSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
    destroyPointerSprite.anchorPoint = CGPointMake(0.5, 0.5); //задаем начальную точку.
    destroyPointerSprite.name = @"destroyPointerSprite";// задаем имя.
    destroyPointerSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    destroyPointerSprite.zPosition=11;
}


@end



//-------NEW INTERFACE------------//
@implementation SpritesClassesMovePointerSprite{
    
    SKSpriteNode *movePointerSprite;

}

@synthesize movePointerSprite ;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreatemMovePointerSprite:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}





#pragma mark CreatemMovePointerSprite

-(void)CreatemMovePointerSprite: (NSString *)orientation{
    
    SKTexture* Texture = [SKTexture textureWithImageNamed:@"movePointer"];
    //Создаем наш SKSpriteNode и инициализируем его. В качестве параметра передаем объект типа SKTexture, который мы создали выше.
    movePointerSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
    movePointerSprite.size = CGSizeMake(200, 70);
    movePointerSprite.anchorPoint = CGPointMake(0, 0); //задаем начальную точку.
    movePointerSprite.name = @"movePointerSprite";// задаем имя.
    movePointerSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    movePointerSprite.zPosition=11;
}

@end


//-------NEW INTERFACE------------//
@implementation SpritesClassesLabelScoresPhysics{
    
    SKLabelNode *LabelScoresPhysics;

}

@synthesize LabelScoresPhysics ;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateScores:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}


#pragma mark addScores

-(void)CreateScores:(NSString *)orientation{
    NSString *destroyed =[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY];
    
    LabelScoresPhysics = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%@%@", [self getStringCountZero:[destroyed intValue]], destroyed]];
    
    LabelScoresPhysics.fontName=@"HouseBrokenRoughHQ";
    LabelScoresPhysics.name = @"LabelScores";
    LabelScoresPhysics.zPosition=11;
    
        if ([BINOKLE_NAME_MAIN isEqualToString:BINOKLE1_NAME]){
                LabelScoresPhysics.fontColor=[UIColor blackColor];
           } else {
               LabelScoresPhysics.fontColor=[UIColor whiteColor];
           }
}



#pragma mark addScores

-(NSString*)getStringCountZero:(int)destroyed{
    
    NSString * count_zero = @"";
    
    switch (destroyed) {
        case 0 ... 9:
            count_zero = @"000";
            break;
            
        case 10 ... 99:
            count_zero = @"00";
            break;
        
        case 100 ... 999:
            count_zero = @"0";
            break;
            
        default:
            break;
    }
    
    return count_zero;
}


@end




//-------NEW INTERFACE------------//
@implementation SpritesClassesLabelInfo{
    
    SKLabelNode *LabelInfo;

}

@synthesize LabelInfo ;


-(id)init{
    
    self=[super init];
    
    if (self){
        
        [self CreateLabelInfo:[CurrentOrientation alloc].getOrientation];
    }
    
    return self;
}


#pragma mark addLabelInfo

-(void)CreateLabelInfo:(NSString *)orientation{
    LabelInfo = [SKLabelNode labelNodeWithText:@"0"];
    LabelInfo.fontName=@"Helvetica";
    LabelInfo.name = @"LabelInfo";
    LabelInfo.zPosition=11;
    LabelInfo.fontColor=[UIColor blackColor];
    LabelInfo.text = @"0";
}


@end
