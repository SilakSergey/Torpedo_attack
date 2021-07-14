//
//  SpritesClasses.h
//  Torpedo attack
//
//  Created by Sergey Silak on 06.05.2021.
//

#import <SpriteKit/SpriteKit.h>

/*Интерфейс инициализации и создания неба*/
@interface SpritesClasses : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *BackgroundSprite;

-(id)init;
-(void)CreateBackgroundSprite;

@end

/*Интерфейс инициализации и создания моря (с анмацией)*/
@interface SpritesClassesWater : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *BackgroundWaterSprite;

-(id)init;
-(void)CreateBackgroundWaterSprite;

@end

/*Интерфейс инициализации и создания скалы слева*/
@interface SpritesClassesRockLeft : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *RockSpriteLeft;

-(id)init;
-(void)CreateRockSpriteLeft;

@end


/*Интерфейс инициализации и создания скалы справа*/
@interface SpritesClassesRockRight : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *RockSpriteRight;

-(id)init;
-(void)CreateRockSpriteRight;

@end


/*Интерфейс инициализации и создания монокля*/
@interface SpritesClassesBinokleSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *binokleSprite;
@property (strong, nonatomic, readonly) NSString *binokleName;

-(id)init;
-(void)CreateBinokleSprite:(NSString *)orientation;

@end


/*Интерфейс инициализации и создания кнопки Menu внутри сцены игры*/
@interface SpritesClassesMenuButtonSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *menuButtonSprite;


-(id)init;
-(void)CreateMenuButtonSprite:(NSString *)orientation;

@end

/*Интерфейс инициализации и создания подсказки к Таймеру подрыва торпеды*/
@interface SpritesClassesStrikePointerSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *strikePointerSprite;


-(id)init;
-(void)CreateStrikePointerSprite:(NSString *)orientation;

@end

/*Интерфейс инициализации и создания подсказки к количеству потопленных кораблей*/
@interface SpritesClassesDestroyPointerSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *destroyPointerSprite;


-(id)init;
-(void)CreateDestroyPointerSprite:(NSString *)orientation;

@end


/*Интерфейс инициализации и создания подсказки к позвожности двигать прицел*/
@interface SpritesClassesMovePointerSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *movePointerSprite;


-(id)init;
-(void)CreatemMovePointerSprite:(NSString *)orientation;

@end



/*Интерфейс инициализации и создания метки с количеством потопленных кораблей*/
@interface SpritesClassesLabelScoresPhysics : SKLabelNode
@property (strong, nonatomic, readonly) SKLabelNode *LabelScoresPhysics;


-(id)init;
-(void)CreateScores:(NSString *)orientation;

@end



/*Интерфейс инициализации и создания метки с псевдо азимутом прицела*/
@interface SpritesClassesLabelInfo : SKLabelNode
@property (strong, nonatomic, readonly) SKLabelNode *LabelInfo;


-(id)init;
-(void)CreateLabelInfo:(NSString *)orientation;

@end


