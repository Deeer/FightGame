//
//  GameLayer.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hero.h"
#import "HudLayer.h"
#import "Robot.h"
//#import "StartScene.h"
//#import "MenuLayer.h"
@interface GameLayer : CCLayer<myProtocol>
{
    CCTMXTiledMap* myMap;
    Hero* _hero;
    CCSpriteBatchNode* _actor;
    CGSize size ;
    float realX;
    float realY;
//    Robot* _robot;
    int i2 ;
    int robotCount;
    int Mypoint;
    
    
//    CCLabelTTF* score;
    
    CCSpriteBatchNode* _actor2;
//    NSMutableArray* _deleteRobot;
    
    
    
    
    
    
}
@property(nonatomic,assign)HudLayer* hud;

@property(nonatomic,retain)CCArray* robots;  //ccarray  retain; ------>release;

@property(nonatomic,strong)NSMutableArray* deleteRobot;

-(id)init;
-(void)initMenu;

@end
