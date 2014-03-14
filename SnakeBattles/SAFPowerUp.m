//
//  SAFPowerUp.m
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/9/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import "SAFPowerUp.h"

static const uint32_t snakePartCategory     =  0x1 << 0;
static const uint32_t powerUpCategory       =  0x1 << 1;

@implementation SAFPowerUp

-(SAFSnakePart *)toSnakePart
{
    SAFSnakePart *temp = [[SAFSnakePart alloc] initWithImageNamed:@"snakeHead.png"];
    temp.loc = self.loc;
    temp.position = self.position;
    temp.size = CGSizeMake(16,16);
    temp.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(16, 16)];
    temp.physicsBody.affectedByGravity = NO;
    temp.physicsBody.friction = 0.0f;
    temp.physicsBody.categoryBitMask = snakePartCategory;
    temp.physicsBody.contactTestBitMask = snakePartCategory | powerUpCategory;
    temp.physicsBody.collisionBitMask = 0;
    return temp;
}

@end
