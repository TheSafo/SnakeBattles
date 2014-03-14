//
//  SAFClassicModeViewController.h
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Singleton.h"

@interface SAFClassicModeViewController : UIViewController

SINGLETON_INTR(SAFClassicModeViewController);


- (void)lostGame;

@end
