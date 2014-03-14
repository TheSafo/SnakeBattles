//
//  SAFClassicSnakeScene.h
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SAFGridObject.h"
#import "SAFSnakePart.h"
#import "SAFPowerUp.h"

@interface SAFClassicSnakeScene : SKScene
{
    int snakeLength;
    SAFSnakePart *snakeHead;
    SAFPowerUp *powerUp;
}
@property NSTimeInterval timeOfLastMove;
@property NSTimeInterval timePerMove;

-(void)turnHeadRight;
-(void)turnHeadLeft;

@end
