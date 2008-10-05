//
//  magic8ballAppDelegate.m
//  magic8ball
//
//  Created by David Syzdek on 7/6/08.
//  Copyright David M. Syzdek 2008. All rights reserved.
//

#import "common.h"
#import "AppDelegate.h"
#import "Beacon.h"
#import "magic8ballController.h"
#import "LuckyChipController.h"
#import "SettingsController.h"

@implementation AppDelegate

@synthesize window;
@synthesize board;
@synthesize settings;
@synthesize defaults;


- (void)applicationDidFinishLaunching:(UIApplication *)application
{
   NSDictionary     * appDefaults;
   NSUserDefaults   * localDefaults;
	UIViewController * localController;
   
   NSLog(@"%@ %@", [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleName"], [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleVersion"]);
   NSLog(@"Copyright (C) 2008 David M. Syzdek");
   NSLog(@"http://www.bindlebinaries.net/");
   
   NSString *applicationCode = PinchMediaCode;
   [Beacon initAndStartBeaconWithApplicationCode:applicationCode useCoreLocation:NO];

   [application setStatusBarHidden:NO animated:NO];
   
   srandomdev();
   
   // initialize defaults
   localDefaults = [[NSUserDefaults alloc] init];
   self.defaults = localDefaults;
   [localDefaults release];
   appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"shake"];
   [self.defaults registerDefaults:appDefaults];
   appDefaults = [NSDictionary dictionaryWithObject:@"NO" forKey:@"flip"];
   [self.defaults registerDefaults:appDefaults];
   appDefaults = [NSDictionary dictionaryWithObject:@"YES" forKey:@"vibrate"];
   [self.defaults registerDefaults:appDefaults];
   appDefaults = [NSDictionary dictionaryWithObject:@"NO" forKey:@"sound"];
   [self.defaults registerDefaults:appDefaults];

   localController         = [[MyControllerClass alloc] init];
   self.board              = localController;
   [(id)self.board setDelegate:self];
   [(id)self.board setDefaults:self.defaults];
   [self.board loadView];
   [localController release];
   
   localController         = [[SettingsController alloc] init];
   self.settings           = localController;
   [(id)self.settings setDelegate:self];
   [(id)self.settings setDefaults:self.defaults];
   [self.settings loadView];
   [localController release];
   
	// Override point for customization after app launch	
   [self.window addSubview:self.board.view];
   [window makeKeyAndVisible];
   
   [self.board viewDidLoad];
   [self.settings viewDidLoad];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
   // Pinch Media Analytics
   //[[Beacon shared] endBeacon];
   
   [self.defaults synchronize];
   [[Beacon shared] endBeacon];
   
   return;
}


- (void)dealloc
{
   [board    release];
   [settings release];
	[window   release];
	[super    dealloc];
}


- (void) showBoardView:(id)sender
{
	//self.settings.view.userInteractionEnabled   = NO;
	//self.board.view.userInteractionEnabled      = NO;
   
   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
   
   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
   [self.settings.view removeFromSuperview];
   [window addSubview:self.board.view];

   [UIView commitAnimations];

   return;
}


- (void) showSettingsView:(id)sender
{
	//self.settings.view.userInteractionEnabled   = NO;
	//self.board.view.userInteractionEnabled      = NO;
   
   // setup the animation group
	[UIView beginAnimations:nil context:nil];
   [UIView setAnimationDuration:0.75];
   [UIView setAnimationDelegate:self];
   [UIView setAnimationDidStopSelector:@selector(transitionDidStop:finished:context:)];
   
   [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:window cache:YES];
   [self.board.view removeFromSuperview];
   [window addSubview:self.settings.view];

   [UIView commitAnimations];

   return;
}


- (void)transitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	// re-enable user interaction when the flip is completed.
	self.settings.view.userInteractionEnabled    = YES;
	self.board.view.userInteractionEnabled       = YES;

}


@end
