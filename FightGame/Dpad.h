//
//  Dpad.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-9.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@class Dpad;
@protocol myProtocol <NSObject>

-(void)funcTarget:(Dpad*)simpleId didChangeDirection:(CGPoint)direction;  //声明协议之一，对象为self

-(void)funcTarget:(Dpad *)simpleId isHoldingDirection:(CGPoint)direction; //声明协议之二，对象为self

//-(void)funcTouchEnd:(Dpad*)simpledId; //声明协议之三，对象为self

-(void)funcTouchEnd:(id)simpledId; //声明协议之三，对象为self  ，id ＝代替任何obj



@end
@interface Dpad : CCSprite <CCTargetedTouchDelegate>
{
    
}

@property (nonatomic,assign)float radius;
@property (nonatomic,assign)CGPoint direction;/////////基本类型用 assigne

@property(nonatomic,assign)id<CCTargetedTouchDelegate>pee;

@property (nonatomic,assign)id<myProtocol> protocol;/////////协议 用assigne ／／／／将协议属性化
@property (nonatomic,assign)BOOL isHeld;

-(void)onEnterTransitionDidFinish;
-(void)onExit;

@end
