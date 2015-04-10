//
//  Define.h
//  FightGame
//
//  Created by zjsruxxxy3 on 14-7-8.
//
//

#ifndef FightGame_Define_h
#define FightGame_Define_h
typedef enum 
{

    kIdleState=0,
    kAttackState,
    kWalkState,
    kHurtState,
    kDeadState
    
    
}ActionState;

//typedef struct _BoundingBox
//{
//    CGRect actual;
//    CGRect original;
//    
//    
//}BoundingBox;


typedef struct _BoundingBox
{
    CGRect actual;
    CGRect original;
}BoundingBox;

#endif
