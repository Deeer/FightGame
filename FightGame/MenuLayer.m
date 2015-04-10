//
//  MenuLayer.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-20.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "SimpleAudioEngine.h"


@implementation MenuLayer
-(id)init
{
    if (self = [super initWithColor:ccc4(0, 125, 250, 255)])
    {
        i = 0;
        
        size = [[CCDirector sharedDirector]winSize];
        [self initTitle];
        [self initMenu];
        
    }
    return self;
    
}
-(void)initTitle
{
    CCLabelTTF* titleLabel = [CCLabelTTF labelWithString:@"FightGame" fontName:@"Arial" fontSize:50];
    titleLabel.color = ccc3(255, 255, 255);
    titleLabel.position = ccp(size.width/2 - 100, size.height - 50);
    titleLabel.rotation = -15;
//    titleLabel.scale = 1.5;
    
    
    
    [self addChild:titleLabel];

}
-(void)initMenu
{
    [CCMenuItemFont setFontName:@"Futura"];
    [CCMenuItemFont setFontSize:30];
    CCMenuItemFont* start = [CCMenuItemFont itemWithString:@"Start" target:self selector:@selector(startGame)];
    
    [CCMenuItemFont setFontSize:20];
    CCMenuItem* onMusic = [CCMenuItemFont itemWithString:@"ON"];
    CCMenuItem* offMusic = [CCMenuItemFont itemWithString:@"OFF"];
    CCMenuItemToggle* music = [CCMenuItemToggle itemWithTarget:self selector:@selector(changeMusic) items:onMusic,offMusic, nil];
//    CCMenuItemImage* image = [CCMenuItemImage itemWithNormalImage:@"menu.png" selectedImage:@"menu.png" target:self selector:@selector(goFight)];
    
    
    CCMenu* mymenu = [CCMenu menuWithItems:start,music, nil];

    [mymenu alignItemsVerticallyWithPadding:1];
    mymenu.position = ccp(size.width/2, size.height/2-20);
//    image.position =ccp(0, 0);
    
    [self addChild:mymenu];
    
    
    
}
-(void)startGame
{
    GameScene* _scene =[GameScene node];
    
//    [[CCDirector sharedDirector]pushScene:[GameScene node]];
    [[CCDirector sharedDirector] pushScene:[CCTransitionCrossFade transitionWithDuration:1.0 scene:_scene]];
    
    
    
}
-(void)changeMusic
{
    if (_music)
    {
        _music = NO;
                                                    
        
    }else
    {
        _music = YES;
        
    }
    NSLog(@"2");
    
}
-(void)dealloc
{
    [super dealloc];
    
}
@end
