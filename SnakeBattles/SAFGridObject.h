//
//  SAFGridObject.h
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "SAFCoord.h"

@interface SAFGridObject : SKSpriteNode
@property (nonatomic) SAFCoord *loc;

@end
