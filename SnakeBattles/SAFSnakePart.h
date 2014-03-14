//
//  SAFSnakePart.h
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/9/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import "SAFGridObject.h"

@interface SAFSnakePart : SAFGridObject
@property (nonatomic)SAFSnakePart *prev;
@property (nonatomic)SAFSnakePart *next;
@property (nonatomic)NSString *lastMove;
@property (nonatomic) int direction;

@end
