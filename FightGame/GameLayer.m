//
//  GameLayer.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"


@implementation GameLayer
-(id)init
{
    if (self = [super init])
    {
        size = [[CCDirector sharedDirector]winSize];
                        
        CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [cache addSpriteFramesWithFile:@"pd_sprites.plist"];
        _actor = [CCSpriteBatchNode batchNodeWithFile:@"pd_sprites.pvr.ccz"];
//        _actor2 = [CCSpriteBatchNode batchNodeWithFile:@"pd_sprites.pvr.ccz"];
        
        [[_actor texture] setAliasTexParameters];
//        [[_actor2 texture]setAliasTexParameters];
        
//       = _actor.texture

        Mypoint = 100;
      
        self.isTouchEnabled = YES;
        [self scheduleUpdate];
        
        [self addChild:_actor z:1];
        
        [self initMap];
        [self initHero];
        [self initRobot];        
//        [self initScore];
//        [self initMenu];
        
    }
    return self;
    
}
-(void)initMenu
{
    CCMenuItemImage* gameOver = [CCMenuItemImage itemWithNormalImage:@"Slice 2.png" selectedImage:@"Slice 2.png" target:self selector:@selector(gameOver)];
    CCMenu* menu = [CCMenu menuWithItems:gameOver, nil];
    menu.position = ccp(size.width/2,size.height/2);
    NSLog(@"111");
    _hud.score = nil;

    [_hud addChild:menu z:6];
    
    
}

-(void)initMap
{
    myMap = [CCTMXTiledMap node];
    [myMap initWithTMXFile:@"pd_tilemap.tmx"];
    for (CCTMXLayer* child in [myMap children])
    {
        [[child texture]setAliasTexParameters]; //锯齿化
        
    }
    
    [self addChild:myMap z:-10];
}
-(void)initHero
{
    _hero = [Hero node];
    _hero.position = ccp(50,80);
    [_hero idle];
    _hero.finalPosition = _hero.position;
    
    
//    [_actor2 addChild:_hero z:10];
    [_actor addChild:_hero z:10];
    
}

-(void)initRobot
{
    int i = 0;
//    robotCount = 10;
    self.robots = [CCArray arrayWithCapacity:10.0];
    for (i = 0; i < 10.0 ; i++)
    {
       Robot* _robot2 = [Robot node];
       
        _robot2.actionState = kIdleState;
        
        [_actor addChild:_robot2];
        [_robots addObject:_robot2];
        
        int minX = size.width + _robot2.centerToSide;
        int maxX = myMap.tileSize.width * myMap.mapSize.width - _robot2.centerToSide;
        
        int minY = _robot2.centerToBottom;
        int maxY = myMap.tileSize.height * 3 + _robot2.centerToBottom;
        
        int realX2 =  arc4random()%(maxX-minX+1)+minX;
        int realY2 = arc4random()%(maxY-minY+1)+minY;
            
        _robot2.scaleX = -1;
        _robot2.position = ccp(realX2, realY2);
        _robot2.finalPosition = _robot2.position;
        
        [_robot2 idle];
        
        
    }
    
    
}

-(void)setView:(CGPoint)point
{
    float viewX = MIN((myMap.tileSize.width * myMap.mapSize.width)-size.width/2,MAX(size.width/2, point.x));
    float viewY = MIN((myMap.tileSize.height * myMap.mapSize.height)-size.height/2,MAX(size.height/2, point.y));
    
    CGPoint actualView = ccp(viewX,viewY);
    
    self.position = ccpSub(ccp(size.width/2, size.height/2),actualView) ;
  
//    score.position = self.position;
    
   }

-(void)updatePosition
{

    realX = MIN(myMap.mapSize.width * myMap.tileSize.width-_hero.centerToSide, MAX(_hero.centerToSide, _hero.finalPosition.x));
    
    
    realY =MIN(3*myMap.tileSize.height+_hero.centerToBottom, MAX(_hero.centerToBottom, _hero.finalPosition.y));
    
    
//    _hero.position = _hero.finalPosition;
    _hero.position =ccp(realX,realY);//移动的位置
}
-(void)update:(ccTime)dt
{
    [_hero update:dt];// actionState的update 调用；

//    [self initScore];
    
    
    [self setView:_hero.position];//移动视角
    
    [self updatePosition]; //移动hero 坐标
    [self updateRobot:dt];
    

    
    
    
}
-(void)updateRobot:(ccTime)dt
{
    int alive = 0;
    Robot* robot;
    float distance;
    for (robot in _robots)
    {
        [robot update:dt];
        robot.position = robot.finalPosition;

        if (robot.actionState != kDeadState)
        {
            alive++;
            if (CACurrentMediaTime() >= robot.theNextTimeDecision)
            {
                distance = ccpDistance(robot.position,_hero.position);
                if (distance <= 50 )
                {
                    robot.theNextTimeDecision = CACurrentMediaTime() + CCRANDOM_0_1() * 0.4 + 0.1;
                    if (_hero.position.x > robot.position.x)
                    {
                        robot.scaleX = 1;
                        
                    }else
                    {
                        robot.scaleX = -1;
                    }
                    [robot attack];
                    if (robot.actionState == kAttackState)
                    {
                        if (fabs(_hero.position.y - robot.position.y) < 15 && fabs(_hero.position.x - robot.position.x)<60)
                        {
                            if (CGRectIntersectsRect(robot.attackBox.actual, _hero.hitBox.actual))
                            {

                                [_hero hurtDamage:robot.damage];
                                if (_hero.actionState == kDeadState )
                                {
                                    //                [robot stopAllActions];
                                    robot.theNextTimeDecision = 10000000000;
                                    [self initMenu];
                                    NSLog(@"88");
                                    
                                    
                                    
                                }
                            }
                        }
                    }
                }else if (distance < size.width/2)
                {
                    robot.theNextTimeDecision = CACurrentMediaTime() + CCRANDOM_0_1() * 0.5 +0.5;
                    CGPoint robortDirection = ccpNormalize(ccpSub(_hero.position, robot.position));
                    [robot walkToDirection:robortDirection];
                    
                    
                }            
            }
            
        } 
        
        
    }


    
    
    
    
}
-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  
{
    
    [_hero attack];
//    NSLog(@"%f",CACurrentMediaTime());
//     NSLog(@"%d",(27000/60/60));
    
    
//    _deleteRobot  = [NSMutableArray new];
    if (_hero.actionState == kAttackState)
    {
        for (Robot* robot in [_robots getNSArray])
        {
            if (robot.actionState != kDeadState)
            {
                if ((fabs(_hero.position.y - robot.position.y) < 15) && (fabs(_hero.position.x - robot.position.x)<65))
                {

                    if (CGRectIntersectsRect(_hero.attackBox.actual, robot.hitBox.actual))
                    {
                        NSLog(@"2");
                        [robot hurtDamage:_hero.damage];
                        if (robot.actionState == kDeadState)
                        {
                            [_hud.score setString:[NSString stringWithFormat:@"%d",Mypoint]];
                            Mypoint+=100;
                            NSLog(@"333");
                                                        
                        }
                    }
                }
            }else if(robot.actionState == kDeadState)
            {
//                [_hud.score setString:[NSString stringWithFormat:@"%d",Mypoint]];

                NSLog(@"%d",Mypoint);

            
            }
            

        }
    }
}
-(void)deleteRobot:(ccTime)dt
{
  
    
    for (Robot* robot in _deleteRobot)
    {
        [_robots removeObject:robot];
        [_actor removeChild:robot cleanup:YES];
        NSLog(@"4");


    }
    
    
    
}

-(void)funcTarget:(Dpad *)simpleId isHoldingDirection:(CGPoint)direction //实现协议的方法之一
{
    [_hero walkToDirection:direction];
}
-(void)funcTarget:(Dpad *)simpleId didChangeDirection:(CGPoint)direction //实现协议的方法之二
{
    [_hero walkToDirection:direction];
    
}
-(void)funcTouchEnd:(id)simpledId //实现协议的方法之一
{
    if (_hero.actionState == kWalkState)
    {
        [_hero idle];
        
    }
//    [_hero idle];
    


}

-(void)gameOver
{
//    [[CCDirector sharedDirector]pushScene:[CCTransitionJumpZoom transitionWithDuration:1.0 scene:[StartScene node]]];
    [[CCDirector sharedDirector]popScene];
    
    
}
-(void)dealloc
{
    [super dealloc];
//    [_robots release];
//    [self unscheduleUpdate];
    
}
@end
