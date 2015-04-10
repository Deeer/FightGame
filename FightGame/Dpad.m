//
//  Dpad.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-9.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "Dpad.h"


@implementation Dpad


//-(id)init
//{
//    if (self = [super init])
//    {
//        _radius = 55;
//        _direction=CGPointZero;
//        _isHeld = NO;
//        [self scheduleUpdate];
//        
//    }
//    return self;
//    
//}
-(void)onEnter
{
    [super onEnter];
    _radius = 55;
    _direction=CGPointZero;
    _isHeld = NO;
    [self scheduleUpdate];
    
}
-(void)onEnterTransitionDidFinish
{
    [[[CCDirector sharedDirector]touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
    
}
-(void)onExit
{
    [[[CCDirector sharedDirector]touchDispatcher]removeDelegate:self];
//    [[[CCDirector sharedDirector]touchDispatcher]removeDelegate:_protocol];
//    [[[CCDirector sharedDirector]touchDispatcher]removeDelegate:_pee];

}
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint myloca = [[CCDirector sharedDirector]convertToGL:[touch locationInView:[touch view]]];
//    float distanceSQ =ccpDistanceSQ(myloca, position_);//self.position
    float distanceSQ = ccpDistance(myloca, position_);
    
    if (distanceSQ <= _radius)
    {
        [self updateDirectionToMyLocation:myloca];


        _isHeld = YES;
        
        return YES;
        
    }

    return NO;
    
}
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
   CGPoint myloca=[ [CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    [self updateDirectionToMyLocation:myloca];
    
}
-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    _direction = CGPointZero;
    _isHeld =NO;
    [_protocol funcTouchEnd:self]; //设置协议参数之三
    
}
-(void)updateDirectionToMyLocation:(CGPoint)location
{
    float angle =ccpToAngle(ccpSub(location, position_));
    float degree = 1 * CC_RADIANS_TO_DEGREES(angle);
    if (degree >= -22.5 && degree <= 22.5)
    {
        _direction = ccp(1,0);
        
    }else if (degree > 22.5 && degree < 67.5)
    {
        _direction = ccp(1,1);
        
    }else if (degree >= 67.5 && degree <= 112.5)
    {
        _direction = ccp(0,1);
    }else if (degree > 112.5 && degree <157.5)
    {
        _direction = ccp(-1, 1);
    }else if (degree > -67.5 && degree < -22.5)
    {
        _direction = ccp(1, -1);
        
    }else if (degree >= -112.5 && degree <= -67.5)
    {
        _direction = ccp(0,-1);
        
    }else if (degree > -157.5 && degree < -112.5)
    {
        _direction = ccp(-1,-1);
        
    }else
    {
        _direction = ccp(-1,0);
        
    }
    
    [_protocol funcTarget:self didChangeDirection:_direction];  //设置协议参数之一
    
    
}
-(void)update:(ccTime)dt
{
    if(_isHeld)
    {
        [_protocol funcTarget:self isHoldingDirection:_direction]; //设置协议参数之二
      
        
    }
}
@end

