//
//  HudLayer.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Dpad.h"
//#import "StartScene.h"
@interface HudLayer : CCLayer
{
//    Dpad* myPad2;
//    Dpad* mypad3;
    
}
@property (nonatomic,assign)Dpad* myPad;
@property (nonatomic,assign)CCLabelTTF* score;


@end
