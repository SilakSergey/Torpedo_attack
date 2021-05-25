//
//  SpritesClasses.h
//  Torpedo attack
//
//  Created by Sergey Silak on 06.05.2021.
//

#import <SpriteKit/SpriteKit.h>


@interface SpritesClasses : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *BackgroundSprite;

-(id)init;
-(void)CreateBackgroundSprite;

@end

//-------NEW INTERFACE------------//
@interface SpritesClassesWater : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *BackgroundWaterSprite;

-(id)init;
-(void)CreateBackgroundWaterSprite;

@end

//-------NEW INTERFACE------------//
@interface SpritesClassesRockLeft : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *RockSpriteLeft;

-(id)init;
-(void)CreateRockSpriteLeft;

@end


//-------NEW INTERFACE------------//
@interface SpritesClassesRockRight : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *RockSpriteRight;

-(id)init;
-(void)CreateRockSpriteRight;

@end


//-------NEW INTERFACE------------//
@interface SpritesClassesBinokleSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *binokleSprite;
@property (strong, nonatomic, readonly) NSString *binokleName;

-(id)init;
-(void)CreateBinokleSprite:(NSString *)orientation;

@end


//-------NEW INTERFACE------------//
@interface SpritesClassesMenuButtonSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *menuButtonSprite;


-(id)init;
-(void)CreateMenuButtonSprite:(NSString *)orientation;

@end

//-------NEW INTERFACE------------//
@interface SpritesClassesStrikePointerSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *strikePointerSprite;


-(id)init;
-(void)CreateStrikePointerSprite:(NSString *)orientation;

@end

//-------NEW INTERFACE------------//
@interface SpritesClassesDestroyPointerSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *destroyPointerSprite;


-(id)init;
-(void)CreateDestroyPointerSprite:(NSString *)orientation;

@end


//-------NEW INTERFACE------------//
@interface SpritesClassesMovePointerSprite : SKSpriteNode
@property (strong, nonatomic, readonly) SKSpriteNode *movePointerSprite;


-(id)init;
-(void)CreatemMovePointerSprite:(NSString *)orientation;

@end



//-------NEW INTERFACE------------//
@interface SpritesClassesLabelScoresPhysics : SKLabelNode
@property (strong, nonatomic, readonly) SKLabelNode *LabelScoresPhysics;


-(id)init;
-(void)CreateScores:(NSString *)orientation;

@end



//-------NEW INTERFACE------------//
@interface SpritesClassesLabelInfo : SKLabelNode
@property (strong, nonatomic, readonly) SKLabelNode *LabelInfo;


-(id)init;
-(void)CreateLabelInfo:(NSString *)orientation;

@end


