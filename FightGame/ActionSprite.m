//
//  ActionSprite.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-8.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "ActionSprite.h"
//#import "SimpleAudioEngine.h"
@implementation ActionSprite
-(void)update:(ccTime)dt
{
    if (_actionState == kWalkState)
    {
        _finalPosition = ccpAdd(position_, ccpMult(_velocity, dt));
//        NSLog(@"%f",dt);
        
    }
}
-(void)idle
{
    if(self.actionState =! kIdleState)
    {
        [self stopAllActions];
        [self runAction:_idleAction];
        self.actionState = kIdleState;
        self.velocity = CGPointZero;
        
        
    }
}

-(void)walkToDirection:(CGPoint)direction
{
    if (self.actionState == kIdleState )
    {
        [self stopAllActions];
        [self runAction:_walkAction];
        self.actionState = kWalkState;
        
    }
    if (self.actionState == kWalkState)
    {
        _velocity = ccp(direction.x * _walkSpeed, direction.y *_walkSpeed);
        
        if (_velocity.x >0)
        {
            self.scaleX = 1;
        }
        else if(_velocity.x <0)
        {
            self.scaleX = -1;
        }
        
    }
}

-(BoundingBox)createBoundingBoxWithOrigin:(CGPoint)origin size:(CGSize)size
{
    BoundingBox boundingBox;
    
    boundingBox.original.origin = origin;
    boundingBox.original.size = size;
    //    boundingBox.actual.size = size;
    boundingBox.actual.origin = ccpAdd(position_, ccp(boundingBox.original.origin.x, boundingBox.original.origin.y));
    boundingBox.actual.size = size;
    
    return boundingBox;
    
    
}
-(void)transformBox
{
    _hitBox.actual.origin = ccpAdd(position_, ccp(_hitBox.original.origin.x*scaleX_, _hitBox.original.origin.y*scaleY_));
    _hitBox.actual.size = CGSizeMake(_hitBox.original.size.width*scaleX_, _hitBox.original.size.height*scaleY_);
    
    
    _attackBox.actual.origin = ccpAdd(position_, ccp(_attackBox.original.origin.x*scaleX_, _attackBox.original.origin.y));

    _attackBox.actual.size =CGSizeMake(_attackBox.original.size.width*scaleX_, _attackBox.original.size.height*scaleY_);
    
}
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    [self transformBox];
    
    
    
}


-(void)attack
{
    if (self.actionState == kIdleState || self.actionState == kWalkState || self.actionState == kAttackState)
    {
        [self stopAllActions];
        [self runAction:_attackAction];
        NSLog(@"attack");
        
        self.actionState = kAttackState;
        
        
    }
}





-(void)hurtDamage:(float)damage
{
    if (self.actionState  == kIdleState || self.actionState == kWalkState || self.actionState == kHurtState )
    {
        [self stopAllActions];
        [self runAction:_hurtAction];
        self.actionState = kHurtState;
        _health -= _damage;
        
//        [[SimpleAudioEngine sharedEngine]playEffect:[NSString stringWithFormat:@"pd_hit1.caf"]];
        
        
        
        
        if (_health <= 0)
        {
            [self dead];
            
            
        }
        

    }
   



}
-(void)dead
{
    if (self.actionState != kDeadState)
    {
        [self stopAllActions];
        [self runAction:_deadAction];
        _velocity = CGPointZero;
        
//        self.opacity = 0 ;
        
        self.actionState =kDeadState;
    }
    
        
}
@end
