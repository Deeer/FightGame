//
//  Hero.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-8.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "Hero.h"


@implementation Hero
-(id)init
{
    if (self = [super initWithSpriteFrameName:@"hero_idle_00.png"])
    {
        int i = 0;
        
        
        ////////////////////////空闲／／／／／／／／／／／／／／／／／／／／
        CCArray* idleArray =[CCArray arrayWithCapacity:6];
        
        for (i=0; i<6; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"hero_idle_%02d.png",i] ];
            [idleArray addObject:frame];
            
            
        }
        CCAnimation* idleAnimation = [CCAnimation animationWithSpriteFrames:[idleArray getNSArray]delay:1/10.0];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
        self.idleAction = repeat;
        
        
        
       
        
        
        ///////////////////////////走路／／／／／／／／／／／／／／／／／／／／／
        CCArray* walkArray = [CCArray arrayWithCapacity:8];
        for (i=0; i<8; i++) {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame =[cache spriteFrameByName:[NSString stringWithFormat:@"hero_walk_%02d.png",i]];
            [walkArray addObject:frame];
            
        }
        CCAnimation* walkAnimation = [CCAnimation animationWithSpriteFrames:[walkArray getNSArray] delay:1.0/12];
        CCAnimate* walkAnimate =[CCAnimate actionWithAnimation:walkAnimation];
        self.walkAction =[CCRepeatForever actionWithAction:walkAnimate];
        
        //////////////////////////攻击／／／／／／／／／／／／／／／／／／／／／／
        CCArray* attackArray = [CCArray arrayWithCapacity:3];
        for (i=0; i<3; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame =[cache spriteFrameByName:[NSString stringWithFormat:@"hero_attack_00_%02d.png",i]];
            [attackArray addObject:frame];
            
        }
        CCAnimation* attackAnimation = [CCAnimation animationWithSpriteFrames:[attackArray getNSArray] delay:1/24.0];
        CCAnimate* attackAnimate =[CCAnimate actionWithAnimation:attackAnimation];
        
        CCCallFunc* callIdle = [CCCallFunc actionWithTarget:self selector:@selector(idle)];
        CCSequence* sequence = [CCSequence actions:attackAnimate,callIdle, nil];
        
        self.attackAction = sequence;
        //////////////////////////受伤／／／／／／／／／／／／／
        CCArray* hurtArray = [CCArray arrayWithCapacity:3];
        for (i = 0; i < 3; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame = [cache spriteFrameByName:[NSString stringWithFormat:@"hero_hurt_%02d.png",i]];
            [hurtArray addObject:frame];
            
        }
        CCAnimation* hurtAnimation = [CCAnimation animationWithSpriteFrames:[hurtArray getNSArray] delay:1/12.0];
        CCAnimate* hurtAnimate = [CCAnimate actionWithAnimation:hurtAnimation];
        
//        CCCallFunc* callIdle2 = [CCCallFunc actionWithTarget:self selector:@selector(idle)];

        CCSequence* sequence3 = [CCSequence actions:hurtAnimate ,callIdle, nil];
      
//        CCRepeatForever* repeat2 = [CCRepeatForever actionWithAction:hurtAnimate];
//        self.hurtAction = repeat2;
        
        self.hurtAction = sequence3;
        
        
        
        ////////////////////////死亡／／／／／／／／／／／／／／／／／／／／
        CCArray* deadArray = [CCArray arrayWithCapacity:5];
        for (i = 0 ; i<5; i++)
        {
            CCSpriteFrameCache* cache = [CCSpriteFrameCache sharedSpriteFrameCache];
            CCSpriteFrame* frame =[cache spriteFrameByName:[NSString stringWithFormat:@"hero_knockout_%02d.png",i]];
            [deadArray addObject:frame];
            
            
        }
        CCAnimation* deadAnimation = [CCAnimation animationWithSpriteFrames:[deadArray getNSArray] delay:1/10.0];
        CCAnimate* deadAnimate = [CCAnimate actionWithAnimation:deadAnimation];
        CCSequence* sequence4 = [CCSequence actions:deadAnimate,[CCBlink actionWithDuration:2.0 blinks:6.0], nil]; //blink 死亡闪烁
        self.deadAction = sequence4 ;
        
        
//        self.deadAction = deadAnimate;
        
        
        
        
        self.centerToSide = 30;
        self.centerToBottom = 35;
        self.walkSpeed = 100;
        self.damage = 10;
        self.health = 80;

        self.hitBox = [self createBoundingBoxWithOrigin:ccp(-self.centerToSide, -self.centerToBottom) size:CGSizeMake(self.centerToSide*2, self.centerToBottom*2)];
        self.attackBox = [self createBoundingBoxWithOrigin:ccp(self.centerToSide, -10) size:CGSizeMake(20, 20)];
        
        
        
        
        
    }
    return self;
    
    
}
-(void)dealloc
{
    [super dealloc];
    
}
@end
