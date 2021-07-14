//
//  MainMenuScene.m
//  Torpedo attack
//
//  Created by Sergey Silak on 19.01.2021.
//

#import "MainMenuScene.h"
#import "Constants.h"
#import <StoreKit/StoreKit.h>
#import "CurrentOrientation.h"
#import <UIKit/UIKit.h>


@implementation MainMenuScene{
    
    SKSpriteNode *BackgroundSprite;
    SKSpriteNode *gameNameSprite;
    SKSpriteNode* menuPlaySprite;
    SKSpriteNode *menuSettingsSprite;
    SKSpriteNode *menuAboutSprite;
    SKSpriteNode *menuPlayButtonSprite;
    SKSpriteNode *menuSettingsButtonSprite;
    SKSpriteNode *menuAboutButtonSprite;
    SKSpriteNode *menuRatingButtonSprite;
    SKTexture* texture;
    CurrentOrientation *currentOrientation;
}

/*Метод загрузки основного меню игры*/
- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    
    currentOrientation = [[CurrentOrientation alloc] init];
    
    [self clearStrike];
    [self sceneSetting];
    
    [self createBackgroundSprite];
    [self createMenuPlayButtonSprite];
    [self createMenuSettingsButtonSprite];
    [self createMenuRatingButtonSprite];
    [self createMenuAboutButtonSprite];
     
     
    [self changeOrientationGameName:currentOrientation.getOrientation];
}

/*Установка слушателя на смену ориентации экрана для поворота элементов главного меню*/
-(void)sceneSetting
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
       addObserver:self selector:@selector(viewWillTransition)
       name:UIDeviceOrientationDidChangeNotification
       object:[UIDevice currentDevice]];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue] > 50){
        
     //   [self requestReview];
    }
 }


/*Метод смены месторасположения элементов главного меню в зависимости от ориентации экрана*/
- (void)viewWillTransition {

    [self changeOrientationGameName:currentOrientation.getOrientation];
    
}
/*Обнуляем количество попаданий и потопленных кораблей*/
-(void)clearStrike{
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:STRIKE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (void)requestReview {
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        // Fallback on earlier versions
    }
}

//Метод создания и размещение Основного фона меню
-(void)createBackgroundSprite {
    texture = [SKTexture textureWithImageNamed:@"backMenu"];
    BackgroundSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    BackgroundSprite.size = self.frame.size; // Задаем размер.
    BackgroundSprite.anchorPoint = CGPointMake(0.5, 0.5);
    BackgroundSprite.name = @"BackgroundSprite";
    BackgroundSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    BackgroundSprite.zPosition=-1;
    [self addChild:BackgroundSprite];
}

//Метод создания и размещение кнопки Играть
-(void)createMenuPlayButtonSprite{
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"buttonPlay", nil)];
    menuPlayButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    menuPlayButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    menuPlayButtonSprite.anchorPoint = CGPointMake(0.5, 0.5);
    menuPlayButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+50);
    menuPlayButtonSprite.name = @"menuPlayButtonSprite";
    menuPlayButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    menuPlayButtonSprite.zPosition=0;
    [self addChild:menuPlayButtonSprite];
    
}

//Метод создания и размещение кнопки Настройки
-(void)createMenuSettingsButtonSprite{
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"buttonSettings", nil)];
    menuSettingsButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    menuSettingsButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    menuSettingsButtonSprite.anchorPoint = CGPointMake(0.5, 0.5);
    menuSettingsButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-MENU_BUTTON_VISOTA);
    menuSettingsButtonSprite.name = @"menuSettingsButtonSprite";
    menuSettingsButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    menuSettingsButtonSprite.zPosition=0;
    [self addChild:menuSettingsButtonSprite];
}

//Метод создания и размещение кнопки Рейтинг
-(void)createMenuRatingButtonSprite{
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"buttonRating", nil)];
    menuRatingButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    menuRatingButtonSprite.size =  CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    menuRatingButtonSprite.anchorPoint = CGPointMake(0.5, 0.5);
    menuRatingButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-MENU_BUTTON_VISOTA*2-50);
    menuRatingButtonSprite.name = @"menuRatingButtonSprite";
    menuRatingButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    menuRatingButtonSprite.zPosition=0;
    [self addChild:menuRatingButtonSprite];
    
}
    
//Метод создания и размещение кнопки О игре
-(void)createMenuAboutButtonSprite{
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"buttonAbout", nil)];
    menuAboutButtonSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    menuAboutButtonSprite.size = CGSizeMake(MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT);
    menuAboutButtonSprite.anchorPoint = CGPointMake(0.5, 0.5);
    menuAboutButtonSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-MENU_BUTTON_VISOTA*3-100);
    menuAboutButtonSprite.name = @"menuAboutButtonSprite";
    menuAboutButtonSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    menuAboutButtonSprite.zPosition=0;
    [self addChild:menuAboutButtonSprite];

}

//Метод меняет позицию и размер Названия игры в меню в зависимости от ориентации экрана
-(void)changeOrientationGameName: (NSString *)orientation {
    
    [self gameNameRemove];
    
    texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"GameName", nil)];
    gameNameSprite = [SKSpriteNode spriteNodeWithTexture:texture];
    gameNameSprite.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height/2-200);
    gameNameSprite.size =  CGSizeMake(800, 300);
    
    if ([orientation isEqualToString: PORTRAIT]){
        
        texture = [SKTexture textureWithImageNamed:NSLocalizedString(@"GameName_P", nil)];
        gameNameSprite = [SKSpriteNode spriteNodeWithTexture:texture];
        gameNameSprite.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height/2-150);
        gameNameSprite.size =  CGSizeMake(533, 200);
    }
    gameNameSprite.anchorPoint = CGPointMake(0.5, 0.5);
    gameNameSprite.name = @"gameNameSprite";
    gameNameSprite.scene.scaleMode = SKSceneScaleModeAspectFill;
    gameNameSprite.zPosition=0;
    [BackgroundSprite addChild:gameNameSprite];
}

//Метод удаления Названия игры в меню
-(void)gameNameRemove {
    [gameNameSprite removeFromParent];
}


//Метод обрабатывает касания кнопок в Главном меню
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

 UITouch *touch = [touches anyObject];
 CGPoint location = [touch locationInNode:self];

 SKNode *node = [self nodeAtPoint:location];

 if ([node.name isEqualToString:@"menuPlayButtonSprite"]) {
     NSString *nameScene;
     
     if ([[[NSUserDefaults standardUserDefaults] objectForKey:DESTROYED_KEY] intValue] == 0){
         
         nameScene = @"InformationScene";
     } else {
     
         nameScene = @"GameScene";
     }
     
     [self loadScene:nameScene];
 }

 if ([node.name isEqualToString:@"menuSettingsButtonSprite"]) {

     [self loadScene:@"SettingsScene"];
 }
    
    if ([node.name isEqualToString:@"menuRatingButtonSprite"]) {

        [self loadScene:@"RatingScene"];
    }
    
    
    if ([node.name isEqualToString:@"menuAboutButtonSprite"]) {

        [self loadScene:@"AboutScene"];
    }
}


//Загрузка сцены в соответствии с нажатой кнопкой меню.
-(void)loadScene:(NSString*)nameScene{
    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:nameScene];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    SKView *skView = (SKView *)self.view;
    [skView presentScene:scene];
}


@end
