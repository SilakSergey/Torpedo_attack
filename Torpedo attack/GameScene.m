//
//  GameScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 14.01.2021.
//

#import "GameScene.h"
#import "Constants.h"
#import "SpritesClasses.h"
#import "CurrentOrientation.h"

@implementation GameScene {
    GameScene*scene;
    
    SKSpriteNode *boatSprite, *torpedoSpriteInWater, *flashSprite, *launchButtonSprite, *launchButtonSpriteOFF, *smokeSprite;
    
    SKLabelNode *LabelDetonation;
    
    NSTimer *countdownTimerTorpedoCount, *countdownTimerBoat;

    int secondsCountTorpedoCount, secondsCountBoat;

    int DURATION_TORPEDO_GLOBAL;
    
    SpritesClasses * spritesClasses;
    SpritesClassesWater * spritesClassesWater;
    SpritesClassesRockLeft *spritesClassesRockLeft;
    SpritesClassesRockRight *spritesClassesRockRight;
    SpritesClassesBinokleSprite *spritesClassesBinokleSprite;
    SpritesClassesMenuButtonSprite *spritesClassesMenuButtonSprite;
    SpritesClassesStrikePointerSprite *spritesClassesStrikePointerSprite;
    SpritesClassesDestroyPointerSprite *spritesClassesDestroyPointerSprite;
    SpritesClassesMovePointerSprite *spritesClassesMovePointerSprite;
    SpritesClassesLabelScoresPhysics *spritesClassesLabelScoresPhysics;
    SpritesClassesLabelInfo *spritesClassesLabelInfo;
    
    
    CurrentOrientation *currentOrientation;
    
    
    NSString * diraction;
    NSString *BOAT_NAME_GLOBAL;
    float BOAT_WIDTH_GLOBAL;
}

- (void)viewWillLayoutSubviews
{
    
    
    
    
    
}



- (void)didMoveToView:(SKView *)view {

    currentOrientation = [[CurrentOrientation alloc] init];
     
    //Загрузка спрайтов
    dispatch_async(dispatch_get_main_queue(), ^{
        //настройки звука
        [self SceneSetting];
        
        /*Загружаем слушатель смены ориентации*/
        [self loadNotificationChangeOrientation];
        
        /*------------------------------------------------Загрузка природы------------------------------*/
        /*Загружаем небо*/
        [self addSky];
        /*Загружаем море*/
        [self addSea];
        /*Загружаем скалы*/
        //Левая
        [self addLeftRock];
        //Правая
        [self addRightRock];
        
        
        /*------------------------------------------------Загрузка элементов главного экрана ------------*/
        /*Загружаем  sprite монокуляра*/
        [self addBinokle];
        /*Загружаем sprites menu и подсказок к кнопкам на sprite Binokle*/
        [self addMenuButton:[self->currentOrientation getOrientation]];
        [self addStrikePointer:[self->currentOrientation getOrientation]];
        [self addDestroyPointerSprite:[self->currentOrientation getOrientation]];
        [self addMovePointerSprite:[self->currentOrientation getOrientation]];
        /*Загружаем Label вывода потопленных кораблей*/
        [self addLabelScoresPhysics:[self->currentOrientation getOrientation]];
        /*Загружаем Label вывода информации о движении монокля*/
        [self addLabelInfo:[self->currentOrientation getOrientation]];
        
        /*Загружаем кнопку ГОТОВ К СТРЕЛЬБЕ*/
        [self CreateLaunchON:[self->currentOrientation getOrientation]];
        
        /*------------------------------------------------Загрузка ИГРЫ------------------------------*/
        //Добавляем новый корабль
        [self addBoat];
        /*время движения торпеды*/
        [self generateTorpedoCount:[self getHardModeStatus]];
        /*Загружаем Label времени движения торпеды*/
        [self CreateLabelDetonation:[self->currentOrientation getOrientation]];
    });
}


-(void)addSky{
    spritesClasses= [[SpritesClasses alloc] init];
    self->spritesClasses.BackgroundSprite.size = self.frame.size;
    [self addChild:self->spritesClasses.BackgroundSprite];
}

-(void)addSea{
    spritesClassesWater= [[SpritesClassesWater alloc] init];
    self->spritesClassesWater.BackgroundWaterSprite.position = CGPointMake(-self.frame.size.width/2, -self.frame.size.height/2+135);
    [self addChild:self->spritesClassesWater.BackgroundWaterSprite];
}

-(void)addLeftRock{
    spritesClassesRockLeft =[[SpritesClassesRockLeft alloc] init];
    self->spritesClassesRockLeft.RockSpriteLeft.position = CGPointMake(-self.frame.size.width/2+ROCK_WIDTH/2, CGRectGetMidY(self.frame)+ROCK_HEIGHT/2);
    [self addChild:self->spritesClassesRockLeft.RockSpriteLeft];
}

-(void)addRightRock{
    spritesClassesRockRight =[[SpritesClassesRockRight alloc] init];
    self->spritesClassesRockRight.RockSpriteRight.position = CGPointMake(self.frame.size.width/2-ROCK_WIDTH/2, CGRectGetMidY(self.frame)+ROCK_HEIGHT/2);
    [self addChild:self->spritesClassesRockRight.RockSpriteRight];
}

-(void)addBinokle{
    spritesClassesBinokleSprite =[[SpritesClassesBinokleSprite alloc] init];
    if ([[self->currentOrientation getOrientation] isEqualToString:PORTRAIT]){
        self->spritesClassesBinokleSprite.binokleSprite.size = CGSizeMake(self.frame.size.height, self.frame.size.height);
    } else {
        self->spritesClassesBinokleSprite.binokleSprite.size = CGSizeMake(self.frame.size.width, self.frame.size.width);
    }
    self->spritesClassesBinokleSprite.binokleSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:self->spritesClassesBinokleSprite.binokleSprite];
}


-(void)addMenuButton: (NSString *)orientation{
    spritesClassesMenuButtonSprite =[[SpritesClassesMenuButtonSprite alloc] init];
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesMenuButtonSprite.menuButtonSprite.size = CGSizeMake(120, 40);
        spritesClassesMenuButtonSprite.menuButtonSprite.position = CGPointMake(-250, 330);
    } else {
        spritesClassesMenuButtonSprite.menuButtonSprite.size = CGSizeMake(180, 60);
        spritesClassesMenuButtonSprite.menuButtonSprite.position = CGPointMake(self.frame.origin.x+10, self.frame.size.height/2-120);
    }

    [self addChild:spritesClassesMenuButtonSprite.menuButtonSprite];
}


-(void)addStrikePointer: (NSString *)orientation{
    spritesClassesStrikePointerSprite = [[SpritesClassesStrikePointerSprite alloc] init];
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesStrikePointerSprite.strikePointerSprite.size = CGSizeMake(115, 40);
        spritesClassesStrikePointerSprite.strikePointerSprite.position = CGPointMake(-250, self.frame.size.height/2-250);
    } else {
        spritesClassesStrikePointerSprite.strikePointerSprite.size = CGSizeMake(200, 70);
        spritesClassesStrikePointerSprite.strikePointerSprite.position = CGPointMake(self.frame.origin.x+20, -35);
    }
    
    [self addChild:spritesClassesStrikePointerSprite.strikePointerSprite];
}



-(void)addDestroyPointerSprite: (NSString *)orientation{
    spritesClassesDestroyPointerSprite = [[SpritesClassesDestroyPointerSprite alloc] init];
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesDestroyPointerSprite.destroyPointerSprite.size = CGSizeMake(115, 40);
        spritesClassesDestroyPointerSprite.destroyPointerSprite.position = CGPointMake(170, self.frame.size.height/2-70);
    } else {
        spritesClassesDestroyPointerSprite.destroyPointerSprite.size = CGSizeMake(200, 70);
        spritesClassesDestroyPointerSprite.destroyPointerSprite.position = CGPointMake(self.frame.size.width/2-120, self.frame.size.height/2-170);
        
    }
    [self addChild:spritesClassesDestroyPointerSprite.destroyPointerSprite];
}


-(void)addMovePointerSprite: (NSString *)orientation{
    spritesClassesMovePointerSprite= [[SpritesClassesMovePointerSprite alloc] init];
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesMovePointerSprite.movePointerSprite.size = CGSizeMake(140, 50);
        spritesClassesMovePointerSprite.movePointerSprite.position = CGPointMake(-250, -self.frame.size.height/2+25);
    } else {
        spritesClassesMovePointerSprite.movePointerSprite.size = CGSizeMake(200, 70);
        spritesClassesMovePointerSprite.movePointerSprite.position = CGPointMake(self.frame.origin.x+20, -self.frame.size.height/2+75);
    }
    [self addChild:spritesClassesMovePointerSprite.movePointerSprite];
}


-(void)addLabelScoresPhysics: (NSString *)orientation{
    spritesClassesLabelScoresPhysics= [[SpritesClassesLabelScoresPhysics alloc] init];
    if ([orientation isEqualToString:PORTRAIT]){

        spritesClassesLabelScoresPhysics.LabelScoresPhysics.position = CGPointMake(self.frame.size.height/2-215, self.frame.size.height/2-40);
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.fontSize = 40;
    } else {
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.position = CGPointMake(self.frame.size.width/2-120, self.frame.size.height/2-120);
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.fontSize = 60;
    }
    [self addChild:spritesClassesLabelScoresPhysics.LabelScoresPhysics];
}

-(void)addLabelInfo: (NSString *)orientation{
    spritesClassesLabelInfo= [[SpritesClassesLabelInfo alloc] init];
    if ([orientation isEqualToString:PORTRAIT]){
        
        if ([BINOKLE_NAME_MAIN isEqualToString:BINOKLE1_NAME]){
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 90);
        } else {
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 100);
        }
        
        spritesClassesLabelInfo.LabelInfo.fontSize = 17;

    } else {
        
        if ([BINOKLE_NAME_MAIN isEqualToString:BINOKLE1_NAME]){
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 120);
        } else {
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 130);
        }
        spritesClassesLabelInfo.LabelInfo.fontSize = 20;
    }
    [self addChild:spritesClassesLabelInfo.LabelInfo];
}


-(void)addBoat{
   
    //выбор направления движения корабля
    [self  generateDirectionBoat];
    //выбор размера в зависимости от сложности игры
    [self generateBoatWidth:[self getHardModeStatus]];
    //создаем sprite корабля
    [self CreateBoatSprite:[self->currentOrientation getOrientation]];
    //двигаем его
    [self moveSprite: arc4random_uniform(90 - 30) + 30 :self->boatSprite];
}



-(NSString *)generateDirectionBoat{
    //-------------------------------------------------------------- Выбор направления движения корабля
    if (arc4random_uniform(2) == 0){
        //движение справа
        NSArray *arrayBoatsRight = ARRAY_BOATS_RIGHT;
            
        int randomBoat = arc4random_uniform((int)arrayBoatsRight.count);
        
        BOAT_NAME_GLOBAL=MAIN_BOAT_NAME_R;
        
        for (int i=0; i<arrayBoatsRight.count; i++) {
            
            if (randomBoat == i){BOAT_NAME_GLOBAL = arrayBoatsRight[i];}
        }
        
        diraction=FROM_RIGHT;
        
    } else{
        //движение слева
        NSArray *arrayBoatsLeft = ARRAY_BOATS_LEFT;
            
        int randomBoat = arc4random_uniform((int)arrayBoatsLeft.count);
        
        BOAT_NAME_GLOBAL=MAIN_BOAT_NAME_L;
        
        for (int i=0; i<arrayBoatsLeft.count; i++) {
            
            if (randomBoat == i){BOAT_NAME_GLOBAL = arrayBoatsLeft[i];}
        }
        
        diraction = FROM_LEFT;
    }
 //   NSLog(@"%@",diraction);
    return diraction;
}


-(int)generateBoatWidth:(NSString *)randomBoat{
    
    //размер корабля
    BOAT_WIDTH_GLOBAL = DEFINE_BOAT_WIDTH;
     
    if ([randomBoat isEqualToString:YES_KEY]){
        
        NSArray *arrayBoatWidth = ARRAY_BOAT_WIDTH;
        

        int randomBoat = arc4random_uniform((int)arrayBoatWidth.count);
        
        for (int i=0; i<arrayBoatWidth.count; i++) {
            
            if (randomBoat == i){BOAT_WIDTH_GLOBAL = [arrayBoatWidth[i] floatValue];}
        }
    }
    return BOAT_WIDTH_GLOBAL;
    
}


-(void)CreateBoatSprite: (NSString *)orientation{
    //-------------------------------------------------------------- Создаем и добавляем на сцену спрайт корабля
    SKTexture *TextureBoat = [SKTexture textureWithImageNamed:BOAT_NAME_GLOBAL];
    boatSprite = [SKSpriteNode spriteNodeWithTexture:TextureBoat];
    boatSprite.anchorPoint = CGPointMake(0.5, 0.5);
    boatSprite.name = @"boatSprite";
  
    
    if ([[self->currentOrientation getOrientation] isEqualToString:PORTRAIT]){
        
        boatSprite.size = CGSizeMake(BOAT_WIDTH_GLOBAL*sizeBOAT, BOAT_WIDTH_GLOBAL*sizeBOAT/3);

    if ([diraction isEqualToString:FROM_RIGHT]){
        boatSprite.position = CGPointMake(-self.frame.size.width/2+BOAT_WIDTH_GLOBAL*sizeBOAT/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL*sizeBOAT/3/2);
    } else {
        boatSprite.position = CGPointMake(self.frame.size.width/2-BOAT_WIDTH_GLOBAL*sizeBOAT/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL*sizeBOAT/3/2);
    }

} else{
    boatSprite.size = CGSizeMake(BOAT_WIDTH_GLOBAL, BOAT_WIDTH_GLOBAL/3);
    if ([diraction isEqualToString:FROM_RIGHT]){
        boatSprite.position = CGPointMake(-self.frame.size.width/2+BOAT_WIDTH_GLOBAL/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL/3/2);
    } else {
        boatSprite.position = CGPointMake(self.frame.size.width/2-BOAT_WIDTH_GLOBAL/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL/3/2);
    }
}

    boatSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:boatSprite.frame.size];
    boatSprite.physicsBody.dynamic = NO;
    boatSprite.zPosition = 2;
    boatSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [spritesClasses.BackgroundSprite addChild:boatSprite];
}



#pragma mark GENERATE TORPEDO DURATION

-(int)generateTorpedoCount:(NSString *)randomBoat{
    
    //время торпеды
    DURATION_TORPEDO_GLOBAL = DEFINE_MOVE_TORPEDO;
    
    if ([randomBoat isEqualToString:YES_KEY]){
        
    NSArray *arrayDurationTorpedo = ARRAY_DURATION_TORPEDO;

    int randomDurationTorpedo = arc4random_uniform((int)arrayDurationTorpedo.count);
    
        
    for (int i=0; i<arrayDurationTorpedo.count; i++) {
        
            if (randomDurationTorpedo == i){DURATION_TORPEDO_GLOBAL = [arrayDurationTorpedo[i] floatValue];}
        }
    }
    return  DURATION_TORPEDO_GLOBAL;
}



#pragma mark CHANGE SPRITES FRAME ORIENTATION

-(void)cspBinokle:(NSString *)orientation {
    
  
    
    if ([orientation isEqualToString:PORTRAIT]){
        
        self->spritesClassesBinokleSprite.binokleSprite.size = CGSizeMake(self.frame.size.height, self.frame.size.height);
    } else {
        self->spritesClassesBinokleSprite.binokleSprite.size = CGSizeMake(self.frame.size.width, self.frame.size.width);
    }
}

-(void)cspmenuButtonSprite:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesMenuButtonSprite.menuButtonSprite.size = CGSizeMake(120, 40);
        spritesClassesMenuButtonSprite.menuButtonSprite.position = CGPointMake(-250, 330);
    } else {
        spritesClassesMenuButtonSprite.menuButtonSprite.size = CGSizeMake(180, 60);
        spritesClassesMenuButtonSprite.menuButtonSprite.position = CGPointMake(self.frame.origin.x+10, self.frame.size.height/2-120);
    }
}

-(void)cspmovePointerSprite:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesMovePointerSprite.movePointerSprite.size = CGSizeMake(140, 50);
        spritesClassesMovePointerSprite.movePointerSprite.position = CGPointMake(-250, -self.frame.size.height/2+25);
    } else {
        spritesClassesMovePointerSprite.movePointerSprite.size = CGSizeMake(200, 70);
        spritesClassesMovePointerSprite.movePointerSprite.position = CGPointMake(self.frame.origin.x+20, -self.frame.size.height/2+75);
    }
}

-(void)cspstrikePointerSprite:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesStrikePointerSprite.strikePointerSprite.size = CGSizeMake(115, 40);
        spritesClassesStrikePointerSprite.strikePointerSprite.position = CGPointMake(-250, self.frame.size.height/2-250);
    } else {
        spritesClassesStrikePointerSprite.strikePointerSprite.size = CGSizeMake(200, 70);
        spritesClassesStrikePointerSprite.strikePointerSprite.position = CGPointMake(self.frame.origin.x+20, -35);
    }
}


-(void)cspdestroyPointerSprite:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        spritesClassesDestroyPointerSprite.destroyPointerSprite.size = CGSizeMake(115, 40);
        spritesClassesDestroyPointerSprite.destroyPointerSprite.position = CGPointMake(170, self.frame.size.height/2-70);
    } else {
        spritesClassesDestroyPointerSprite.destroyPointerSprite.size = CGSizeMake(200, 70);
        spritesClassesDestroyPointerSprite.destroyPointerSprite.position = CGPointMake(self.frame.size.width/2-120, self.frame.size.height/2-170);
    }
}


-(void)cspLabelScoresPhysics:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
    
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.position = CGPointMake(self.frame.size.height/2-215, self.frame.size.height/2-40);
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.fontSize = 40;
    } else {
        
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.position = CGPointMake(self.frame.size.width/2-120, self.frame.size.height/2-120);
        spritesClassesLabelScoresPhysics.LabelScoresPhysics.fontSize = 60;
    }
}


-(void)csplaunchButtonSprite:(NSString *)orientation {

    if ([orientation isEqualToString:PORTRAIT]){
        launchButtonSprite.size = CGSizeMake(130, 130);
        launchButtonSprite.position = CGPointMake(120, -self.frame.size.height/2+25);
    } else {
        launchButtonSprite.size = CGSizeMake(150, 150);
        launchButtonSprite.position = CGPointMake(self.frame.size.width/2-180, -self.frame.size.height/2+75);
    }
}

-(void)csplaunchButtonSpriteOFF:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
        launchButtonSpriteOFF.size = CGSizeMake(130, 130);
        launchButtonSpriteOFF.position = CGPointMake(120, -self.frame.size.height/2+25);
    } else {
        launchButtonSpriteOFF.size = CGSizeMake(150, 150);
        launchButtonSpriteOFF.position = CGPointMake(self.frame.size.width/2-180, -self.frame.size.height/2+75);
    }
}


-(void)cspLabelDetonation:(NSString *)orientation {

if ([orientation isEqualToString:PORTRAIT]){
    
    LabelDetonation.position = CGPointMake(-190, self.frame.size.height/2-200);
    LabelDetonation.fontSize =60;
} else{
    LabelDetonation.fontSize =80;
    LabelDetonation.position = CGPointMake(self.frame.origin.x+120, 50);
    }
}



-(void)cspLabelInfo:(NSString *)orientation {
    
    if ([orientation isEqualToString:PORTRAIT]){
        
        if ([spritesClassesBinokleSprite.binokleName isEqualToString:BINOKLE1_NAME]){
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 90);
        } else {
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 100);
        }
        
        spritesClassesLabelInfo.LabelInfo.fontSize = 17;
    
    } else {
        
        if ([spritesClassesBinokleSprite.binokleName isEqualToString:BINOKLE1_NAME]){
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 120);
        } else {
            spritesClassesLabelInfo.LabelInfo.position = CGPointMake(30, 130);
        }
        
        spritesClassesLabelInfo.LabelInfo.fontSize = 20;
    }
}


-(void)cspboatSprite: (NSString *)orientation{
    //корабль
    if ([orientation isEqualToString:PORTRAIT]){
   //portrait
        boatSprite.size = CGSizeMake(BOAT_WIDTH_GLOBAL*sizeBOAT, BOAT_WIDTH_GLOBAL*sizeBOAT/3);
        
        if ([diraction isEqualToString:FROM_RIGHT]){
            boatSprite.position = CGPointMake(-self.frame.size.width/2+BOAT_WIDTH_GLOBAL*sizeBOAT/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL*sizeBOAT/3/2);
        } else {
            boatSprite.position = CGPointMake(self.frame.size.width/2-BOAT_WIDTH_GLOBAL*sizeBOAT/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL*sizeBOAT/3/2);
        }
     
    } else {
        
        boatSprite.size = CGSizeMake(BOAT_WIDTH_GLOBAL, BOAT_WIDTH_GLOBAL/3);
        
        if ([diraction isEqualToString:FROM_RIGHT]){
            boatSprite.position = CGPointMake(-self.frame.size.width/2+BOAT_WIDTH_GLOBAL/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL/3/2);
        } else {
            boatSprite.position = CGPointMake(self.frame.size.width/2-BOAT_WIDTH_GLOBAL/2, CGRectGetMidY(self.frame)+BOAT_WIDTH_GLOBAL/3/2);
        }
    }
}

#pragma mark addLaunchON

-(void)CreateLaunchON:(NSString *) orientation{
    
    SKTexture* Texture = [SKTexture textureWithImageNamed:@"launchON"];
    
    launchButtonSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
    
    
    if ([orientation isEqualToString:PORTRAIT]){
        launchButtonSprite.size = CGSizeMake(130, 130);
        launchButtonSprite.position = CGPointMake(120, -self.frame.size.height/2+25);
    } else {
        launchButtonSprite.size = CGSizeMake(150, 150);
        launchButtonSprite.position = CGPointMake(self.frame.size.width/2-180, -self.frame.size.height/2+75);
    }
    launchButtonSprite.anchorPoint = CGPointMake(0, 0);
    launchButtonSprite.name = @"launchButtonSprite";
    launchButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    launchButtonSprite.zPosition=11;
    [self addChild:launchButtonSprite];
}


#pragma mark addLaunchOFF
-(void)CreateLaunchOFF:(NSString *) orientation{
    
    SKTexture* Texture = [SKTexture textureWithImageNamed:@"launchOFF"];
    
    launchButtonSpriteOFF = [SKSpriteNode spriteNodeWithTexture:Texture];
    
    if ([orientation isEqualToString:PORTRAIT]){
        launchButtonSpriteOFF.size = CGSizeMake(130, 130);
        launchButtonSpriteOFF.position = CGPointMake(120, -self.frame.size.height/2+25);
    } else {
        launchButtonSpriteOFF.size = CGSizeMake(150, 150);
        launchButtonSpriteOFF.position = CGPointMake(self.frame.size.width/2-180, -self.frame.size.height/2+75);
    }
    launchButtonSpriteOFF.anchorPoint = CGPointMake(0, 0);
    launchButtonSpriteOFF.name = @"launchButtonSpriteOFF";
    launchButtonSpriteOFF.scene.scaleMode = SKSceneScaleModeAspectFill;
    launchButtonSpriteOFF.zPosition=11;
    [self addChild:launchButtonSpriteOFF];
}




#pragma mark addTorpedoFire

-(void)CreateTorpedoSpriteInWater{
    
    SKTexture *Texture = [SKTexture textureWithImageNamed:@"torpedo_in_water"];
    torpedoSpriteInWater = [SKSpriteNode spriteNodeWithTexture:Texture];
    torpedoSpriteInWater.size = CGSizeMake(2, 10);
    torpedoSpriteInWater.position = CGPointMake(-spritesClasses.BackgroundSprite.position.x, -self.frame.size.height);
    torpedoSpriteInWater.anchorPoint = CGPointMake(0.5, 0.5);
    torpedoSpriteInWater.zPosition = 2;
    torpedoSpriteInWater.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:torpedoSpriteInWater.frame.size];
    torpedoSpriteInWater.physicsBody.dynamic = NO;
    torpedoSpriteInWater.name = @"torpedoInWaterSprite";
    [spritesClasses.BackgroundSprite addChild:torpedoSpriteInWater];
}


#pragma mark moveTorpedo

-(void)moveTorpedo:(int) durationTorpedo{
    
    [torpedoSpriteInWater runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveToY:0 duration:durationTorpedo]]]]];
}


#pragma mark StartBtn

-(void)StartBtn{
    //-------------------------------------------------------------- Нажата кнопка пуск торпеды
    [launchButtonSprite removeFromParent];
    
    [self CreateLaunchOFF:[currentOrientation getOrientation]];
    [self soundEffects:LAUNCH];
    [self setTimer:DURATION_TORPEDO_GLOBAL];
    [self CreateTorpedoSpriteInWater];
    [self moveTorpedo:DURATION_TORPEDO_GLOBAL];
}

#pragma mark soundEffects

-(void)soundEffects: (NSString*)fileName{
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:SOUNDEFFECTS_KEY] isEqualToString:@"ON"]){
        if ([fileName isEqualToString:LAUNCH]){[audioPlayer.playLaunch play];}
        if ([fileName isEqualToString:EXPLOSION]){[audioPlayer.playExplosion play];}
    }
}

#pragma mark setTimer

-(void)setTimer:(int)seconds{
    
    secondsCountTorpedoCount = seconds;
    countdownTimerTorpedoCount = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(RunTimerAddTorpedo) userInfo:nil repeats:YES];
}

#pragma mark setTimerSprite

-(void)setTimerSprite:(int)seconds{

    secondsCountBoat = seconds;
    countdownTimerBoat = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(RunTimerRemoveSprite) userInfo:nil repeats:YES];
}


#pragma mark addLabelDetonation

-(void)CreateLabelDetonation:(NSString *)orientation{
    
    if (!LabelDetonation){
        LabelDetonation = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%d",secondsCountTorpedoCount]];
        
        if ([orientation isEqualToString:PORTRAIT]){
            
            LabelDetonation.position = CGPointMake(-190, self.frame.size.height/2-200);
            LabelDetonation.fontSize =60;
        } else{
            LabelDetonation.fontSize =80;
            LabelDetonation.position = CGPointMake(self.frame.origin.x+120, 50);
        }
        
        if ([spritesClassesBinokleSprite.binokleName isEqualToString:BINOKLE1_NAME]){
                LabelDetonation.fontColor=[UIColor blackColor];
           } else {
               LabelDetonation.fontColor=[UIColor whiteColor];
           }
                
        LabelDetonation.fontName=@"HouseBrokenRoughHQ";
        LabelDetonation.name = @"LabelTorpedo";
        LabelDetonation.zPosition=11;
        [self setLabelDetonation:[NSString stringWithFormat:@"%d",DURATION_TORPEDO_GLOBAL]];
        [self addChild:LabelDetonation];
        
    } else {
        if ([orientation isEqualToString:PORTRAIT]){
            
            LabelDetonation.position = CGPointMake(-190, self.frame.size.height/2-200);
            LabelDetonation.fontSize =60;
        } else{
            LabelDetonation.fontSize =80;
            LabelDetonation.position = CGPointMake(self.frame.origin.x+120, 50);
        }
        [self setLabelDetonation:[NSString stringWithFormat:@"%d",secondsCountTorpedoCount]];
    }
}

-(NSString*)setLabelDetonation :(NSString*)text{
    return LabelDetonation.text = text;
}

#pragma mark RunTimerAddTorpedo

-(void)RunTimerAddTorpedo {
    
    secondsCountTorpedoCount=secondsCountTorpedoCount-1;
    
    [self CreateLabelDetonation:[currentOrientation getOrientation]];
    
    //если время отсчета закончилось
    if (secondsCountTorpedoCount==0) {
        //-------------------------------------------------------------- Проверяем попадание
        [self checkCollisions];
        //--------------------------------------------------------------
        [torpedoSpriteInWater removeFromParent];
        
        [countdownTimerTorpedoCount invalidate];
       
        [launchButtonSpriteOFF removeFromParent];
        [self CreateLaunchON:[currentOrientation getOrientation]];
        [self setLabelDetonation:[NSString stringWithFormat:@"%d",DURATION_TORPEDO_GLOBAL]];
       
    }
}

#pragma mark checkCollisions - Проверка попаданий

-(void)checkCollisions{
    //-------------------------------------------------------------- Если попадание
    if (torpedoSpriteInWater.position.x > boatSprite.position.x-BOAT_WIDTH_GLOBAL/2+20 & torpedoSpriteInWater.position.x < boatSprite.position.x+BOAT_WIDTH_GLOBAL/2-20){
   //      NSLog(@"BOOM!!!");
        //-------------------------------------------------------------- +1 к попаданию
        [self addStrikeCollision];
        //--------------------------------------------------------------Звук взрыва
        [self soundEffects:EXPLOSION];
        //--------------------------------------------------------------вспышка
        [self CreateFlashEffect];
        //--------------------------------------------------------------дым
        [self CreateSmoke];
        //-------------------------------------------------------------- Синхронизация движения дыма и корабля
        [self sinhronizeSmokeBoat];
        //-------------------------------------------------------------- Проверка - Если утопили
        [self ifDestroyedCheck];
    }
}


-(void)moveSprite:(int) timerInterval : (SKSpriteNode*) spriteName {
    //-------------------------------------------------------------- Двигаем sprite (корабль или дым)
    
 //   NSLog(@"diraction: %@",diraction );
    
    if ([diraction isEqualToString:FROM_RIGHT]){
        
        [spriteName runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveToX:self.frame.size.width/2 duration:timerInterval]]]] withKey:@"moving"];
        
    } else{
        
        [spriteName runAction:[SKAction repeatActionForever:[SKAction moveToX:-self.frame.size.width  duration:timerInterval]]  withKey:@"moving"];
    }
    //при движении корабля проверяем не скрылся ли он за скалами таймер на 100 сек
    [self setTimerSprite:100];
}



#pragma mark sinhronizeSmokeBoat - Синхронизация корабля и дыма

-(void)sinhronizeSmokeBoat{
    //останавливаем корабль
    [boatSprite removeActionForKey:@"moving"];
    //запускаем корабль и дым с одной скоростью
    int timerInterval = arc4random_uniform(150 - 30) + 30;
    [self moveSprite:timerInterval  :boatSprite];
    [self moveSprite:timerInterval  :smokeSprite];
}

#pragma mark ifDestroyedCheck - Если утопили

-(void)ifDestroyedCheck{
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:STRIKE_KEY]  intValue] == 2 ){
               
               [spritesClassesLabelScoresPhysics.LabelScoresPhysics removeFromParent];
               [self addLabelScoresPhysics:[currentOrientation getOrientation]];

                [smokeSprite removeFromParent];
                [countdownTimerBoat invalidate];
                [spritesClassesLabelScoresPhysics.LabelScoresPhysics removeFromParent];
                [self clearStrikeCount];
        
               //+1 потопленный корабль
               [self addDestroyedBoatCount];
              
                [boatSprite runAction:[SKAction sequence:@[[SKAction moveToY:-30 duration:10],[SKAction removeFromParent]]]];
                        
               [self addLabelScoresPhysics:[currentOrientation getOrientation]];
               
               int destroyed = [[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue];
               
               
               if (destroyed == 50 || destroyed == 100 || destroyed == 150 || destroyed == 200 || destroyed == 300 || destroyed == 400 || destroyed == 500 || destroyed == 750 || destroyed == 1000 || destroyed == 2000){
                   //-------------------------------------------------------------- Если ключевые потопленные корабли - вывод сообщений о наградах
                   [self loadMenu:@"InformationScene"];
                   
               } else {
               
                   //-------------------------------------------------------------- Добавляем новый корабль и двигаем его
                   [self addBoat];
                   //-------------------------------------------------------------- Расчёт нового времени движения торпеды
                   /*время движения торпеды*/
                   [self generateTorpedoCount:[self getHardModeStatus]];
                   /*Загружаем Label времени движения торпеды*/
                   [self setLabelDetonation:[NSString stringWithFormat:@"%d",DURATION_TORPEDO_GLOBAL]];
               }
        }
}

#pragma mark Очистка количества попаданий в корабль
-(void)clearStrikeCount{
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:STRIKE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark +1 к потопленным кораблям
-(void)addDestroyedBoatCount{

    [[NSUserDefaults standardUserDefaults] setInteger:[[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue] + 1 forKey:DESTROYED_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark Вспышка
-(void)CreateFlashEffect{
    //-------------------------------------------------------------- Вспышка
    SKTexture *Texture = [SKTexture textureWithImageNamed:@"flash"];
    
    flashSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
    flashSprite.size = CGSizeMake(FLASH, FLASH);
    flashSprite.position = CGPointMake( torpedoSpriteInWater.position.x+2, torpedoSpriteInWater.position.y+10);
    flashSprite.anchorPoint = CGPointMake(0.5, 0.5);
    flashSprite.name = @"flashSprite";
    flashSprite.zPosition=3;
    [spritesClasses.BackgroundSprite addChild:flashSprite];
    
     //есть попадание -  убираем вспышку
    [flashSprite runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:0.2f],[SKAction removeFromParent]]]];
}


#pragma mark Дым
-(void)CreateSmoke{
    //-------------------------------------------------------------- Дым
    SKTexture*  Texture;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:STRIKE_KEY]  intValue] == 1 ){
        
        if ([diraction isEqualToString:FROM_RIGHT]){
            Texture = [SKTexture textureWithImageNamed:@"smokeR"];
        } else {
            Texture = [SKTexture textureWithImageNamed:@"smokeL"];
        }
        
        smokeSprite = [SKSpriteNode spriteNodeWithTexture:Texture];
        smokeSprite.size = CGSizeMake(SMOKE_WIDTH, SMOKE_HEIGHT);
        smokeSprite.position = CGPointMake(torpedoSpriteInWater.position.x, SMOKE_HEIGHT/2+3);
        smokeSprite.anchorPoint = CGPointMake(0.5, 0.5);
        smokeSprite.name = @"smokeSprite";
        smokeSprite.zPosition=2;
        [spritesClasses.BackgroundSprite addChild:smokeSprite];
    }
}



#pragma mark Корабль скрылся сбоку
-(void)RunTimerRemoveSprite {
    
    //-------------------------------------------------------------- корабль скрылся сбоку
    if ([diraction isEqualToString:FROM_RIGHT]){
        if (boatSprite.position.x >= self.frame.size.width/2-BOAT_WIDTH_GLOBAL/2){
                      
           
            [self RemoveBoatSmokeTimerBoatStrikeCount];
            
            //Добавляем новый корабль
            [self addBoat];
            /*время движения торпеды*/
            [self generateTorpedoCount:[self getHardModeStatus]];
            /*Загружаем Label времени движения торпеды*/
            [self setLabelDetonation:[NSString stringWithFormat:@"%d",DURATION_TORPEDO_GLOBAL]];
            
        }
        
    } else {
        
    if (boatSprite.position.x <= -self.frame.size.width/2+BOAT_WIDTH_GLOBAL/2){
        
        [self RemoveBoatSmokeTimerBoatStrikeCount];
        
        //Добавляем новый корабль
        [self addBoat];
        
        /*время движения торпеды*/
        [self generateTorpedoCount:[self getHardModeStatus]];
        [self setLabelDetonation:[NSString stringWithFormat:@"%d",DURATION_TORPEDO_GLOBAL]];
        
        }
    }
}

#pragma mark Убираем корабль, дым, останавливаем таймер и очищаем счетчик попаданий
-(void)RemoveBoatSmokeTimerBoatStrikeCount{
        [boatSprite removeFromParent];
        [smokeSprite removeFromParent];
        [countdownTimerBoat invalidate];
        [self clearStrikeCount];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self]; 

    SKNode *node = [self nodeAtPoint:location];

    if ([node.name isEqualToString:@"launchButtonSprite"]) {
        
        [self StartBtn];
    }
    
    if ([node.name isEqualToString:@"menuButtonSprite"]) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self loadMenu:@"MainMenuScene"];
        
    }
}

-(void)loadMenu: (NSString*)nodeWithFileNamed {
    [self clearStrikeCount];
    
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:nodeWithFileNamed];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
}


#pragma mark +1 к попаданиям
-(void)addStrikeCollision{
    
    [[NSUserDefaults standardUserDefaults] setInteger:[[[NSUserDefaults standardUserDefaults] objectForKey:STRIKE_KEY] intValue] + 1 forKey:STRIKE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}





#pragma mark Смена ориентации - меняем позиции sprites
- (void) orientationChanged:(NSNotification *)note
{
    
    NSString *orientation =  [currentOrientation getOrientation];
    NSLog(@"orientation: %@" ,orientation);
    [self cspBinokle:orientation];
    [self cspLabelInfo:orientation];
    [self cspLabelDetonation:orientation];
    [self cspLabelScoresPhysics:orientation];
    [self cspboatSprite:orientation];
    [self cspmovePointerSprite:orientation];
    [self cspmenuButtonSprite:orientation];
    [self cspstrikePointerSprite:orientation];
    [self cspdestroyPointerSprite:orientation];
    [self csplaunchButtonSprite:orientation];
    [self csplaunchButtonSpriteOFF:orientation];
}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    CGPoint previousPosition = [touch previousLocationInNode:self];
    CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, spritesClasses.BackgroundSprite.position.y);

    
    if (spritesClasses.BackgroundSprite.position.x + translation.x>-self.frame.size.width/2+ROCK_WIDTH & spritesClasses.BackgroundSprite.position.x + translation.x < self.frame.size.width/2-ROCK_WIDTH){
        [spritesClasses.BackgroundSprite setPosition:CGPointMake(spritesClasses.BackgroundSprite.position.x + translation.x, spritesClasses.BackgroundSprite.position.y)];
        [spritesClassesWater.BackgroundWaterSprite setPosition:CGPointMake(spritesClassesWater.BackgroundWaterSprite.position.x + translation.x, spritesClassesWater.BackgroundWaterSprite.position.y)];
    }
         

    spritesClassesRockLeft.RockSpriteLeft.position =CGPointMake(spritesClasses.BackgroundSprite.frame.origin.x+ROCK_WIDTH/2, spritesClassesRockLeft.RockSpriteLeft.position.y);
    spritesClassesRockRight.RockSpriteRight.position =CGPointMake(spritesClasses.BackgroundSprite.frame.origin.x+spritesClasses.BackgroundSprite.frame.size.width-ROCK_WIDTH/2 , spritesClassesRockRight.RockSpriteRight.position.y);
 
    spritesClassesLabelInfo.LabelInfo.text=[NSString stringWithFormat:@"%ld", lroundf(spritesClasses.BackgroundSprite.position.x + translation.x)];
}



-(void)SceneSetting
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:SOUNDBACKGROUND_KEY] isEqualToString:@"ON"]){
    
        [audioPlayer.playSound play];
    } else {
        [audioPlayer.playSound stop];
    }
}


#pragma mark Статус сложного режима игры
-(NSString *)getHardModeStatus{
    NSString *randomBoat=NO_KEY;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:HARD_KEY] isEqualToString:@"ON"]){
        
        randomBoat=YES_KEY;
        
    }
    
    return randomBoat;
}

#pragma mark Слушаем смену ориентации
-(void)loadNotificationChangeOrientation{
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

@end
