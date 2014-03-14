//
//  SAFViewController.h
//  SnakeBattles
//

//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Singleton.h"
#import "SAFClassicSnakeScene.h"
#import "SAFMyScene.h"

@interface SAFViewController : UIViewController
{
    SKScene *currentScene;
}


SINGLETON_INTR(SAFViewController);


@end
