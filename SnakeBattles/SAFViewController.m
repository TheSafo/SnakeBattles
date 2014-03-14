//
//  SAFViewController.m
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import "SAFViewController.h"
#import "SAFMyScene.h"
#import "SAFClassicSnakeScene.h"
#import "Singleton.h"

@implementation SAFViewController

SINGLETON_IMPL(SAFViewController);

- (BOOL)prefersStatusBarHidden {return YES;}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:currentScene];
        SKNode *node = [currentScene nodeAtPoint:location];
        
        if([currentScene.name isEqualToString:@"SAFClassicSnakeScene"])
        {
            if([node.name isEqualToString:@"lost"])
            {
                [self lostGame];
                return;
            }
            
            if(location.x > currentScene.frame.size.width/2)
            {
                [(SAFClassicSnakeScene *)currentScene turnHeadRight];
            }
            else
            {
                [(SAFClassicSnakeScene *)currentScene turnHeadLeft];
            }
        }
        else if([currentScene.name isEqualToString:@"MainMenu"])
        {
            if([node.name isEqualToString:@"ClassicButton"])
            {
                [self switchToClassicMode];
            }
        }
    }
}

-(void)switchToClassicMode
{
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    SKScene *scene = [SAFClassicSnakeScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    currentScene = scene;
    
    [skView presentScene:scene];
}

- (void)lostGame
{
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    SKScene *scene = [SAFMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    currentScene = scene;
    
    [skView presentScene:scene];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene *scene = [SAFMyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    currentScene = scene;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
