//
//  StartScene.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-20.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "StartScene.h"


@implementation StartScene
-(id)init
{
    if (self = [super init])
    {
        gui = [MenuLayer node];
        [self addChild:gui];
        
    }
    return self;
    
}
@end
