//
//  IntroLayer.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright __MyCompanyName__ 2014年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "GameScene.h"
#import "StartScene.h"
// HelloWorldLayer
@interface IntroLayer : CCLayer
{
    GameScene* _scene;
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child

+(CCScene *) scene;

@end
