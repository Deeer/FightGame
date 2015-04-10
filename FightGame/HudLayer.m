//
//  HudLayer.m
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-7.
//  Copyright 2014年 __MyCompanyName__. All rights reserved.
//

#import "HudLayer.h"


@implementation HudLayer
-(id)init
{
    if (self = [super init])
    {
        _myPad = [Dpad node];
        [_myPad initWithFile:@"pd_dpad.png"];
//        NSLog(@"%f",myPad.radius);
        _myPad.position = ccp(64.0, 64.0);
        _myPad.opacity = 100;
        
        
        
        [self addChild:_myPad];
        [self initScore];
        [self initEsc];
        
        
    }
    return self;
    
}
-(void)initScore
{
    
    CGSize size = [[CCDirector sharedDirector]winSize];
    
    _score = [CCLabelTTF labelWithString:@"0" fontName:@"Arial" fontSize:30];
    _score.position = ccp(size.width-30, size.height-30);
    NSLog(@"222");
    
    [self addChild:_score];
    
    
    
    
}
-(void)initEsc
{
    CGSize size = [[CCDirector sharedDirector]winSize];
    [CCMenuItemFont setFontName:@"Arial"];
    [CCMenuItemFont setFontSize:25];
    CCMenuItem *item = [CCMenuItemFont itemWithString:@"Esc" target:self selector:@selector(makeEsc)];
    
    CCMenu* menu = [CCMenu menuWithItems:item, nil];
    menu.position = ccp(30, size.height-30);
//    menu.position = ccp(size.width/2,size.height/2);
    
    
    [self addChild:menu z:10];
    NSLog(@"444");
    
    
}
-(void)makeEsc
{
    [[CCDirector sharedDirector]popScene];
    
//    [[CCDirector sharedDirector]replaceScene:[StartScene node]];
    
     
    
}
-(void)dealloc
{
    [super dealloc];
    
}
@end
