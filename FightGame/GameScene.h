//
//  GameScene.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameLayer.h"
#import "HudLayer.h"
@interface GameScene : CCScene
{
    GameLayer* _gameLayer;
    HudLayer* _huoLayer;
    
    
}
-(id)init;

@end
