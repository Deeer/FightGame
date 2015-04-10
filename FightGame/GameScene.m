//
//  GameScene.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene
-(id)init
{
    if (self = [super init])
    {
        _gameLayer = [GameLayer node];
        _huoLayer = [HudLayer node];
        [self addChild:_gameLayer z:0];
        [self addChild:_huoLayer z:2];
        _huoLayer.myPad.protocol = _gameLayer;   //在scene里委托代理对象
        _gameLayer.hud = _huoLayer;//反联系
        
    }
    return self;
    
}
@end
