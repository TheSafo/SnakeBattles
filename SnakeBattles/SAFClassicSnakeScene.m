//
//  SAFClassicSnakeScene.m
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import "SAFClassicSnakeScene.h"
#import "SAFCoord.h"
#import "SAFGridObject.h"
#include <math.h>
#import "SAFClassicModeViewController.h"
#include <UIKit/UIKit.h>
#import "SAFPowerUp.h"
#include <stdlib.h>



/* TODO
 Fix multisnake movement
 Lose if collide with a piece
*/

static const uint32_t snakePartCategory     =  0x1 << 0;
static const uint32_t powerUpCategory       =  0x1 << 1;


@implementation SAFClassicSnakeScene

-(void)addNewPowerUp
{
    powerUp = nil;
    powerUp = [[SAFPowerUp alloc] initWithImageNamed:@"square.png"];
    SAFCoord* temp = [SAFCoord alloc];
    int x = arc4random() % 20;
    int y = arc4random() % 35;
    temp.x = 16*x;
    temp.y = 16*y;
    powerUp.loc = temp;
    powerUp.size = CGSizeMake(16,16);
    powerUp.position = CGPointMake((16*x), (16*y));
    powerUp.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(16, 16)];
    powerUp.physicsBody.affectedByGravity = NO;
    powerUp.physicsBody.friction = 0.0f;
    powerUp.physicsBody.categoryBitMask = powerUpCategory;
    powerUp.physicsBody.collisionBitMask = 0;
    powerUp.physicsBody.contactTestBitMask = snakePartCategory;
    [self addChild:powerUp];
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *snakePart, *powerUpHit;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        snakePart = contact.bodyA;
        powerUpHit = contact.bodyB;
        [self eatFood:snakePart :powerUpHit];
            }
    else if(contact.bodyB.categoryBitMask < contact.bodyA.categoryBitMask)
    {
        snakePart = contact.bodyB;
        powerUpHit = contact.bodyA;
        [self eatFood:snakePart :powerUpHit];
    }
    else
    {
        int index1 = [snake indexOfObject:contact.bodyA.node];
        int index2 = [snake indexOfObject:contact.bodyB.node];
        if(index1 -index2 == 1)
            return;
        if ([contact.bodyA.node isEqual:[snake objectAtIndex:0]])
        {
            SAFSnakePart* head = contact.bodyA.node;
            int directionToNode = [self directionToNode:head:contact.bodyB.node];
            if(directionToNode == head.direction)
                [self loseGame];
            return;
        }
        if ([contact.bodyB.node isEqual:[snake objectAtIndex:0]])
        {
            SAFSnakePart* head = contact.bodyB.node;
            int directionToNode = [self directionToNode:head:contact.bodyA.node];
            if(directionToNode == head.direction)
                [self loseGame];
            return;
        }
        else
            [self loseGame];
    }
}

-(int)directionToNode: (SAFSnakePart *)from : (SAFSnakePart *) to
{
    SAFCoord* fromLoc = from.loc;
    SAFCoord* toLoc = to.loc;
    
    if(from.loc.y > to.loc.y)
    {
        if(from.loc.x > to.loc.x)
            return 225;
        if(from.loc.x == to.loc.x)
            return 180;
        return 135;
    }
    if(from.loc.y == to.loc.y)
    {
        if(from.loc.x > to.loc.x)
            return 270;
        if(from.loc.x == to.loc.x)
            return -1;
        return 90;
    }
    else
    {
        if(from.loc.x > to.loc.x)
            return 315;
        if(from.loc.x == to.loc.x)
            return 0;
        return 45;
    }
}


-(void)eatFood:(SKPhysicsBody*)snakePart:(SKPhysicsBody*)powerUpHit
{
    SAFSnakePart* oldHead = [snake objectAtIndex:0];
    SAFSnakePart* snakeHead = [(SAFPowerUp *) powerUp toSnakePart];
    
    SKTexture* bodyText = [SKTexture textureWithImageNamed:@"blackSquare.png"];
    
    [oldHead setTexture:bodyText];
    
    [powerUp removeFromParent];
    
    [snake insertObject:snakeHead atIndex:0];
    snakeLength++;
    
    snakeHead.direction = oldHead.direction;
    if(snakeHead.direction == 0)
    {
        
    }
    else if(snakeHead.direction == 90)
    {
        SKAction *rotate = [SKAction rotateByAngle:-M_PI/2 duration:0];
        [snakeHead runAction:rotate];
    }
    else if(snakeHead.direction == 180)
    {
        SKAction *rotate = [SKAction rotateByAngle:M_PI duration:0];
        [snakeHead runAction:rotate];
    }
    else if(snakeHead.direction == 270)
    {
        SKAction *rotate = [SKAction rotateByAngle:M_PI/2 duration:0];
        [snakeHead runAction:rotate];
    }
    if(snakeHead.direction == 0)
    {
        SKAction *moveUp = [SKAction moveByX:0 y:16 duration:0];
        [snakeHead runAction:moveUp];
        snakeHead.loc.y = snakeHead.loc.y+16;
        if(snakeHead.loc.y > self.frame.size.height)
            [self loseGame];
        
    }
    else if (snakeHead.direction == 90)
    {
        SKAction *moveRight = [SKAction moveByX:16 y:0 duration:0];
        [snakeHead runAction:moveRight];
        snakeHead.loc.x = snakeHead.loc.x+16;
        if(snakeHead.loc.x > self.frame.size.width)
            [self loseGame];
        
    }
    else if (snakeHead.direction == 180)
    {
        SKAction *moveDown = [SKAction moveByX:0 y:-16 duration:0];
        [snakeHead runAction:moveDown];
        snakeHead.loc.y = snakeHead.loc.y-16;
        if(snakeHead.loc.y < 0)
            [self loseGame];
        
    }
    else
    {
        SKAction *moveLeft = [SKAction moveByX:-16 y:0 duration:0];
        [snakeHead runAction:moveLeft];
        snakeHead.loc.x = ((SAFSnakePart *) [snake objectAtIndex:0]).loc.x-16;
        if(snakeHead.loc.x < 0)
            [self loseGame];
    }

    
    
    [self addChild:snakeHead];
    [self addNewPowerUp];
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        snake = [NSMutableArray new];
        
        self.timePerMove = .4;
        self.timeOfLastMove = 0.0;
        self.name = @"SAFClassicSnakeScene";
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        SAFSnakePart *snakeHead = [[SAFSnakePart alloc] initWithImageNamed:@"snakeHead.png"];
        [snake addObject:snakeHead];
        snakeLength = 1;
        ((SAFSnakePart *) [snake objectAtIndex:0]).direction = 0;
        [((SAFSnakePart *) [snake objectAtIndex:0]) setPosition:CGPointMake(16,16)];
        SAFCoord* temp = [SAFCoord alloc];
        temp.x = 16;
        temp.y = 16;
        snakeHead.loc = temp;
        snakeHead.size = CGSizeMake(16,16);
        snakeHead.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(15, 15)];
        snakeHead.physicsBody.affectedByGravity = NO;
        snakeHead.physicsBody.friction = 0.0f;
        snakeHead.physicsBody.categoryBitMask = snakePartCategory;
        snakeHead.physicsBody.contactTestBitMask = snakePartCategory | powerUpCategory;
        snakeHead.physicsBody.collisionBitMask = 0;
        
        powerUp = [[SAFPowerUp alloc] initWithImageNamed:@"square.png"];
        SAFCoord* temp3 = [SAFCoord alloc];
        temp3.x = 16*10;
        temp3.y = 16*17;
        powerUp.loc = temp3;
        powerUp.size = CGSizeMake(16,16);
        powerUp.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(16, 16)];
        powerUp.physicsBody.affectedByGravity = NO;
        powerUp.position = CGPointMake(16*10, 16*17);
        powerUp.physicsBody.friction = 0.0f;
        powerUp.physicsBody.categoryBitMask = powerUpCategory;
        powerUp.physicsBody.collisionBitMask = 0;
        powerUp.physicsBody.contactTestBitMask = snakePartCategory;
        
        
        [self addChild: powerUp];
        [self addChild:[snake objectAtIndex:0]];
        //[self addChild: snakeTail];
    }
    return self;
}

-(void)loseGame
{
    [self removeAllChildren];
    SKLabelNode *loseText = [SKLabelNode labelNodeWithFontNamed:@"Helvitica"];
    loseText.fontSize = 30.0f;
    loseText.color = [UIColor redColor];
    NSString *s = [NSString stringWithFormat:@"Snake Length: %d", snakeLength];
    loseText.text = s;
    loseText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    loseText.name = @"lost";
    [self addChild:loseText];
    snake = nil;
}


-(void)update:(NSTimeInterval)currentTime
{
    if (currentTime - self.timeOfLastMove < self.timePerMove) return;
    SAFSnakePart* snakeHead = [snake objectAtIndex:0];
    int direction = snakeHead.direction;

    SAFCoord* oldLoc = [SAFCoord alloc];
    oldLoc.x = ((SAFSnakePart *) [snake objectAtIndex:0]).loc.x;
    oldLoc.y = ((SAFSnakePart *) [snake objectAtIndex:0]).loc.y;
    
    if(direction == 0)
    {
        SKAction *moveUp = [SKAction moveByX:0 y:16 duration:0];
        [snakeHead runAction:moveUp];
       snakeHead.loc.y = snakeHead.loc.y+16;
        if(snakeHead.loc.y > self.frame.size.height)
            [self loseGame];
        
    }
    else if (direction == 90)
    {
        SKAction *moveRight = [SKAction moveByX:16 y:0 duration:0];
        [snakeHead runAction:moveRight];
        snakeHead.loc.x = snakeHead.loc.x+16;
        if(snakeHead.loc.x > self.frame.size.width)
            [self loseGame];
        
    }
    else if (direction == 180)
    {
        SKAction *moveDown = [SKAction moveByX:0 y:-16 duration:0];
        [snakeHead runAction:moveDown];
        snakeHead.loc.y = snakeHead.loc.y-16;
        if(snakeHead.loc.y < 0)
            [self loseGame];
        
    }
    else
    {
        SKAction *moveLeft = [SKAction moveByX:-16 y:0 duration:0];
        [snakeHead runAction:moveLeft];
        snakeHead.loc.x = ((SAFSnakePart *) [snake objectAtIndex:0]).loc.x-16;
        if(snakeHead.loc.x < 0)
            [self loseGame];
    }
    
    if(snakeLength >= 2)
    {
        SAFSnakePart* oldTail =((SAFSnakePart *) [snake objectAtIndex:snakeLength-1]);
        [snake removeObjectAtIndex:snakeLength-1];
    
        [oldTail setPosition:CGPointMake(oldLoc.x, oldLoc.y)];
        [snake insertObject:oldTail atIndex:1];
    }
    self.timeOfLastMove = currentTime;
}

-(void)turnHeadLeft
{
    SAFSnakePart* snakeHead = [snake objectAtIndex:0];
    int direction = snakeHead.direction;
    SKAction *rotate = [SKAction rotateByAngle:M_PI/2 duration:.1];
    [snakeHead runAction:rotate];
    if(direction == 0)
        snakeHead.direction = 270;
    else
        snakeHead.direction = direction - 90;
}

-(void)turnHeadRight
{
    SAFSnakePart* snakeHead = [snake objectAtIndex:0];
    int direction = snakeHead.direction;
    SKAction *rotate = [SKAction rotateByAngle:-M_PI/2 duration:.1];
    [snakeHead runAction:rotate];
    if(direction == 270)
        snakeHead.direction = 0;
    else
        snakeHead.direction = direction + 90;
}

@end
