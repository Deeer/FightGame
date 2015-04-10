//
//  ActionSprite.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-8.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Define.h"

@interface ActionSprite : CCSprite
{
    
}
@property(nonatomic,strong)id idleAction;
@property(nonatomic,strong)id attackAction;
@property(nonatomic,strong)id walkAction;
@property(nonatomic,strong)id hurtAction;
@property(nonatomic,strong)id deadAction;


@property(nonatomic,assign)ActionState actionState;



@property(nonatomic,assign)float centerToSide;
@property(nonatomic,assign)float centerToBottom;

@property(nonatomic,assign)float damage;
@property(nonatomic,assign)float health;


@property(nonatomic,assign)float walkSpeed;

@property(nonatomic,assign)CGPoint  velocity;
@property(nonatomic,assign)CGPoint finalPosition;

@property(nonatomic,assign)BoundingBox hitBox;
@property(nonatomic,assign)BoundingBox attackBox;


-(void)idle;
-(void)attack;
-(void)walkToDirection:(CGPoint)direction;

-(void)hurtDamage:(float)damage;
-(void)dead;

-(void)update:(ccTime)dt;

-(BoundingBox)createBoundingBoxWithOrigin:(CGPoint)origin size:(CGSize)size;



@end
