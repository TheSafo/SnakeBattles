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
 Add powerup after eating old one
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
    temp.x = 16*18;
    temp.y = 16*18;
    powerUp.loc = temp;
    powerUp.size = CGSizeMake(16,16);
    powerUp.position = CGPointMake((16*18), (16*18));
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
        
        //SKSpriteNode* temp = powerUpHit.node;
        SAFSnakePart* oldHead = snakePart.node;
        snakeHead = [(SAFPowerUp *) powerUp toSnakePart];
        
        SKTexture* bodyText = [SKTexture textureWithImageNamed:@"blackSquare.png"];
        [oldHead setTexture:bodyText];
        snakeHead.next = oldHead;
        oldHead.prev = snakeHead;
        
        [powerUp removeFromParent];
        
        
        snakeHead.direction = oldHead.direction;
        if(snakeHead.direction == 0)
        {
            snakeHead.lastMove = @"N";
            
        }
        else if(snakeHead.direction == 90)
        {
            snakeHead.lastMove = @"E";
            SKAction *rotate = [SKAction rotateByAngle:M_PI/2 duration:.1];
            [snakeHead runAction:rotate];
        }
        else if(snakeHead.direction == 180)
        {
            snakeHead.lastMove = @"S";
            SKAction *rotate = [SKAction rotateByAngle:M_PI duration:.1];
            [snakeHead runAction:rotate];
        }
        else if(snakeHead.direction == 270)
        {
            snakeHead.lastMove = @"W";
            SKAction *rotate = [SKAction rotateByAngle:-M_PI/2 duration:.1];
            [snakeHead runAction:rotate];
        }
        [self addChild:snakeHead];
        [self addNewPowerUp];
    }
    else if(contact.bodyB.categoryBitMask < contact.bodyA.categoryBitMask)
    {
        snakePart = contact.bodyB;
        powerUpHit = contact.bodyA;
        
        //SKSpriteNode* temp = powerUpHit.node;
        SAFSnakePart* oldHead = snakePart.node;
        snakeHead = [(SAFPowerUp *) powerUp toSnakePart];
        
        SKTexture* bodyText = [SKTexture textureWithImageNamed:@"blackSquare.png"];
        [oldHead setTexture:bodyText];
        snakeHead.next = oldHead;
        oldHead.prev = snakeHead;
        
        [powerUp removeFromParent];
        
        snakeHead.next = oldHead;
        oldHead.prev = snakeHead;
        
        snakeHead.direction = oldHead.direction;
         if(snakeHead.direction == 0)
         {
             snakeHead.lastMove = @"N";
             
         }
         else if(snakeHead.direction == 90)
         {
             snakeHead.lastMove = @"E";
             SKAction *rotate = [SKAction rotateByAngle:M_PI/2 duration:.1];
             [snakeHead runAction:rotate];
         }
         else if(snakeHead.direction == 180)
         {
             snakeHead.lastMove = @"S";
             SKAction *rotate = [SKAction rotateByAngle:M_PI duration:.1];
             [snakeHead runAction:rotate];
         }
         else if(snakeHead.direction == 270)
         {
             snakeHead.lastMove = @"W";
             SKAction *rotate = [SKAction rotateByAngle:-M_PI/2 duration:.1];
             [snakeHead runAction:rotate];
        }
        [self addChild:snakeHead];
        [self addNewPowerUp];
    }
    else
    {
     //  [self loseGame];
        return;
    }
    
    
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        self.timePerMove = .6;
        self.timeOfLastMove = 0.0;
        self.name = @"SAFClassicSnakeScene";
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        self.physicsWorld.gravity = CGVectorMake(0,0);
        self.physicsWorld.contactDelegate = self;
        
        snakeHead = [[SAFSnakePart alloc] initWithImageNamed:@"snakeHead.png"];
        snakeHead.direction = 0;
        snakeHead.position = CGPointMake(0, 0);
        SAFCoord* temp = [SAFCoord alloc];
        temp.x = 0;
        temp.y = 0;
        snakeHead.loc = temp;
        snakeHead.size = CGSizeMake(16,16);
        snakeHead.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(16, 16)];
        snakeHead.physicsBody.affectedByGravity = NO;
        snakeHead.physicsBody.friction = 0.0f;
        snakeHead.physicsBody.categoryBitMask = snakePartCategory;
        snakeHead.physicsBody.contactTestBitMask = snakePartCategory | powerUpCategory;
        snakeHead.physicsBody.collisionBitMask = 0;
        
        
        powerUp = [[SAFPowerUp alloc] initWithImageNamed:@"square.png"];
        SAFCoord* temp2 = [SAFCoord alloc];
        temp2.x = 16*10;
        temp2.y = 16*17;
        powerUp.loc = temp2;
        powerUp.size = CGSizeMake(16,16);
        powerUp.physicsBody =[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(16, 16)];
        powerUp.physicsBody.affectedByGravity = NO;
        powerUp.position = CGPointMake(16*10, 16*17);
        powerUp.physicsBody.friction = 0.0f;
        powerUp.physicsBody.categoryBitMask = powerUpCategory;
        powerUp.physicsBody.collisionBitMask = 0;
        powerUp.physicsBody.contactTestBitMask = snakePartCategory;
        
        
        [self addChild: powerUp];
        [self addChild: snakeHead];
    }
    return self;
}

-(void)loseGame
{
    [self removeAllChildren];
    SKLabelNode *loseText = [SKLabelNode labelNodeWithFontNamed:@"Helvitica"];
    loseText.fontSize = 30.0f;
    loseText.color = [UIColor redColor];
    loseText.text = @"YOU LOSE!";
    loseText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    loseText.name = @"lost";
    [self addChild:loseText];
    snakeHead = nil;
    
}

-(void)move:(SAFSnakePart*)piece
{
    if(piece == nil)
        return;
    
    NSString *prevMove = piece.prev.lastMove;
    if([prevMove isEqualToString:@"N"])
    {
        SKAction *moveUp = [SKAction moveByX:0 y:16 duration:.1];
        [piece runAction:moveUp];
        piece.loc.y = piece.loc.y+16;
        piece.lastMove = @"N";
        
    }
    else if([prevMove isEqualToString:@"E"])
    {
        SKAction *moveRight = [SKAction moveByX:16 y:0 duration:.1];
        [piece runAction:moveRight];
        piece.loc.x = piece.loc.x+16;
        piece.lastMove = @"E";
        
    }
    else if([prevMove isEqualToString:@"S"])
    {
        SKAction *moveDown = [SKAction moveByX:0 y:-16 duration:.1];
        [piece runAction:moveDown];
        piece.lastMove = @"S";
        piece.loc.y = piece.loc.y-16;
    }
    else if([prevMove isEqualToString:@"W"])
    {
        SKAction *moveLeft = [SKAction moveByX:-16 y:0 duration:.1];
        [piece runAction:moveLeft];
        piece.lastMove = @"W";
        piece.loc.x = piece.loc.x-16;
    }
    [self move:piece.next];
}

-(void)update:(NSTimeInterval)currentTime
{
    if (currentTime - self.timeOfLastMove < self.timePerMove) return;
    int direction = snakeHead.direction;
    if(direction == 0)
    {
        SKAction *moveUp = [SKAction moveByX:0 y:16 duration:.1];
        [snakeHead runAction:moveUp];
        snakeHead.loc.y = snakeHead.loc.y+16;
        [self move:snakeHead.next];
        snakeHead.lastMove = @"N";
        if(snakeHead.loc.y > self.frame.size.height)
            [self loseGame];
        
    }
    else if (direction == 90)
    {
        SKAction *moveRight = [SKAction moveByX:16 y:0 duration:.1];
        [snakeHead runAction:moveRight];
        snakeHead.loc.x = snakeHead.loc.x+16;
        [self move:snakeHead.next];
        snakeHead.lastMove = @"E";
        if(snakeHead.loc.x > self.frame.size.width)
            [self loseGame];
        
    }
    else if (direction == 180)
    {
        SKAction *moveDown = [SKAction moveByX:0 y:-16 duration:.1];
        [snakeHead runAction:moveDown];
        [self move:snakeHead.next];
        snakeHead.lastMove = @"S";
        snakeHead.loc.y = snakeHead.loc.y-16;
        if(snakeHead.loc.y < 0)
            [self loseGame];
        
    }
    else
    {
        SKAction *moveLeft = [SKAction moveByX:-16 y:0 duration:.1];
        [snakeHead runAction:moveLeft];
        [self move:snakeHead.next];
        snakeHead.lastMove = @"W";
        snakeHead.loc.x = snakeHead.loc.x-16;
        if(snakeHead.loc.x < 0)
            [self loseGame];
    }
    self.timeOfLastMove = currentTime;
}

-(void)turnHeadLeft
{
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
    int direction = snakeHead.direction;
    SKAction *rotate = [SKAction rotateByAngle:-M_PI/2 duration:.1];
    [snakeHead runAction:rotate];
    
    if(direction == 270)
        snakeHead.direction = 0;
    else
        snakeHead.direction = direction + 90;
}

@end
