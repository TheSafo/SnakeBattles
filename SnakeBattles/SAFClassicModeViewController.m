//
//  SAFClassicModeViewController.m
//  SnakeBattles
//
//  Created by Jake Saferstein on 3/8/14.
//  Copyright (c) 2014 Jake Saferstein. All rights reserved.
//

#import "SAFClassicModeViewController.h"
#import "SAFMyScene.h"
#import "SAFGridView.h"
#import "SAFClassicSnakeScene.h"
#import "SAFViewController.h"

@interface SAFClassicModeViewController ()

@end

@implementation SAFClassicModeViewController

SINGLETON_IMPL(SAFClassicModeViewController);


- (void)lostGame
{
    //UIStoryboardSegue *temp = [UIStoryboardSegue segueWithIdentifier: @"UnwindToMainMenu"  source: self destination: [SAFViewController sharedInstance] performHandler:nil];
    //[self unwindToMainMenu:temp];
    //[self performSegueWithIdentifier:@"UnwindToMainMenu" sender:self];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {return YES;}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene *scene = [SAFClassicSnakeScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    [skView presentScene:scene];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
