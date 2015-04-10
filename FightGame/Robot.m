//
//  Robot.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-12.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "Robot.h"


@implementation Robot

-(id)init
{
    if(self = [super initWithSpriteFrameName:@"robot_idle_00.png"]);
    {
               
        _theNextTimeDecision = 0;
        
        int i = 0;
        
        CCArray* idleArray = [CCArray arrayWithCapacity:5];
//        NSMutableArray* aaa = [ NSMutableArray arrayWithCapacity:5];
        for (i = 0; i < 5; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"robot_idle_%02d.png",i]];
            [idleArray addObject:frame];
            
        }
        CCAnimation* idleAnimation = [CCAnimation animationWithSpriteFrames:[idleArray getNSArray]delay:1/12.0];

//        CCAnimation* idleAnimation = [CCAnimation animationWithSpriteFrames:[idleArray getNSArray] delay:1/12.0];
//        CCAnimate* idleAnimate = [CCAnimate actionWithAnimation:idleAnimation];
//        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:idleAnimate];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];

        self.idleAction = repeat;
        
        
        
        CCArray* attackArray = [CCArray arrayWithCapacity:5];
        for (i = 0 ; i < 5; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"robot_attack_%02d.png",i]];
            [attackArray addObject:frame];
            
            
        }
        CCAnimation* attackAnimation = [CCAnimation animationWithSpriteFrames:[attackArray getNSArray] delay:1/12.0];
        CCCallFunc* callIdle = [CCCallFunc actionWithTarget:self selector:@selector(idle)];
        CCSequence* sequence = [CCSequence actions:[CCAnimate actionWithAnimation:attackAnimation],callIdle, nil];
        self.attackAction = sequence;
        
//        CCRepeatForever* repeat3 = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:attackAnimation]];
//        self.attackAction = repeat3;
        
        
        
        
        CCArray* walkArray = [CCArray arrayWithCapacity:6];
        for (i = 0 ; i <6; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"robot_walk_%02d.png",i]];
            [walkArray addObject:frame];
            
        }
        CCAnimate* walkAnimate = [CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:[walkArray getNSArray] delay:1/12.0]];
        CCSequence* sequence2 = [CCSequence actions:walkAnimate,callIdle, nil];
        self.walkAction = sequence2;
        
        
        
        CCArray* hurtArray = [CCArray arrayWithCapacity:3];
        for (i = 0 ; i < 3; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"robot_hurt_%02d.png",i]];
            [hurtArray addObject:frame];
            
        }
        CCAnimate* hurtAnimate = [CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:[hurtArray getNSArray] delay:1/12.0]];
        self.hurtAction = [CCSequence actions:hurtAnimate,callIdle, nil];
        
        
        
        
        CCArray* deadArray = [ CCArray arrayWithCapacity:5];
        for (i = 0; i < 5; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"robot_knockout_%02d.png",i]];
            [deadArray addObject:frame];
            
        }
        CCAnimate* deadAnimate = [CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:[deadArray getNSArray] delay:1/12.0]];
//        self.deadAction = deadAnimate;
        
        CCBlink* blink = [CCBlink actionWithDuration:1.5 blinks:5];
        
        CCCallFuncN* destory = [CCCallFuncN actionWithTarget:self selector:@selector(destoryOne:)];
        CCSequence* sequence4 = [CCSequence actions:deadAnimate,blink,destory, nil];
        
        self.deadAction = sequence4;
        
        
                
        self.damage = 5;
        self.health = 30;
        self.centerToBottom = 35;
        self.centerToSide = 30;
        self.walkSpeed = 60;
//        self.point = 100;

        
        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-self.centerToSide, -self.centerToBottom) size:CGSizeMake(self.centerToSide*2,self.centerToSide*2)];
        
        
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(self.centerToSide, -5) size:CGSizeMake(15,15)];
        

    }
    
    
    return self;
    
}
-(void)destoryOne:(ccTime)dt
{
    self.opacity = 0 ;
    
}
-(void)dealloc
{
//    [self unscheduleUpdate];
    
    [super dealloc];
    
}
@end
