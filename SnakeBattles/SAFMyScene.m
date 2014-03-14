
//
//  SAFMyScene.m
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import "SAFMyScene.h"
#include <UIKit/UIKit.h>

@implementation SAFMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        self.name = @"MainMenu";
        
        SKLabelNode *header = [[SKLabelNode alloc] initWithFontNamed:@"AmericanTypewriter-Bold"];
        header.text = @"SNAKE BATTLES";
        header.fontSize = 30;
        header.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 200);
        [self addChild:header];
        
        SKLabelNode *classicButton = [[SKLabelNode alloc] initWithFontNamed:@"AmericanTypewriter-Bold"];
        classicButton.text = @"Classic Mode";
        classicButton.fontSize = 20;
        classicButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 100);
        classicButton.name = @"ClassicButton";
        [self addChild:classicButton];
        
        
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
