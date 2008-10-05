//
//  SettingsController.m
//  magic8ball
//
//  Created by David Syzdek on 8/24/08.
//  Copyright 2008 David M. Syzdek. All rights reserved.
//

#import "SettingsController.h"


@implementation SettingsController

@synthesize delegate;
@synthesize shakeSwitch;
@synthesize flipSwitch;
@synthesize vibrateSwitch;
@synthesize soundSwitch;
@synthesize defaults;


// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   UIView            * localView;
   UILabel           * localLabel;
   UIButton          * localButton;
   UISwitch          * localSwitch;
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];
   
   // load view
   localView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
   //localView.backgroundColor = [UIColor grayColor];
   self.view                 = localView;
   [localView release];
   
   // add BindleBinary logo and link
   localButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame           = CGRectMake((320-252)/2, 20, 252, 100);
   localButton.backgroundColor = [UIColor clearColor];
   [localButton setBackgroundImage:[UIImage imageNamed:@"BindleBinariesLogo.png"] forState:UIControlStateNormal];
   [localButton addTarget:self action:@selector(openDeveloper:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];

   // add shake mode switch
   localSwitch      = [[UISwitch alloc] initWithFrame:CGRectMake(206, 150, 0, 0)];
   self.shakeSwitch = localSwitch;
   if ([self.defaults boolForKey:@"shake"])
      self.shakeSwitch.on = YES;
   [self.shakeSwitch addTarget:self action:@selector(updateShakePref:) forControlEvents:UIControlEventValueChanged];
   [self.view addSubview:localSwitch];
   [localSwitch release];
   localLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 147, 178, 27)];
   localLabel.backgroundColor = [UIColor clearColor];
   localLabel.font            = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
   localLabel.textAlignment   = UITextAlignmentLeft;
   localLabel.text            = @"Shake Mode:";
   [self.view addSubview:localLabel];
   [localLabel release];
   
   // add flip mode
   localSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206, 185, 0, 0)];
   self.flipSwitch = localSwitch;
   if ([self.defaults boolForKey:@"flip"])
      self.flipSwitch.on = YES;
   [self.flipSwitch addTarget:self action:@selector(updateFlipPref:) forControlEvents:UIControlEventValueChanged];
   [self.view addSubview:localSwitch];
   [localSwitch release];
   
   localLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(20, 182, 178, 27)];
   localLabel.backgroundColor = [UIColor clearColor];
   localLabel.font            = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
   localLabel.textAlignment   = UITextAlignmentLeft;
   localLabel.text            = @"Flip Mode:";
   [self.view addSubview:localLabel];
   [localLabel release];

   // add vibrate mode
   localSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206, 220, 0, 0)];
   self.vibrateSwitch = localSwitch;
   if ([self.defaults boolForKey:@"vibrate"])
      self.vibrateSwitch.on = YES;
   [self.vibrateSwitch addTarget:self action:@selector(updateVibratePref:) forControlEvents:UIControlEventValueChanged];
   [self.view addSubview:localSwitch];
   [localSwitch release];
   localLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(20, 217, 178, 27)];
   localLabel.backgroundColor = [UIColor clearColor];
   localLabel.font            = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
   localLabel.textAlignment   = UITextAlignmentLeft;
   localLabel.text            = @"Vibrate Mode:";
   [self.view addSubview:localLabel];
   [localLabel release];

   // add Sound Clips
   localSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(206, 255, 0, 0)];
   self.soundSwitch = localSwitch;
   if ([self.defaults boolForKey:@"sound"])
      self.soundSwitch.on = YES;
   [self.soundSwitch addTarget:self action:@selector(updateSoundPref:) forControlEvents:UIControlEventValueChanged];
   [self.view addSubview:localSwitch];
   [localSwitch release];
   localLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(20, 252, 178, 27)];
   localLabel.backgroundColor = [UIColor clearColor];
   localLabel.font            = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
   localLabel.textAlignment   = UITextAlignmentLeft;
   localLabel.text            = @"Sound Clips:";
   [self.view addSubview:localLabel];
   [localLabel release];
   
   // edit button
   //localLabel                 = [[UILabel alloc] initWithFrame:CGRectMake(20, 287, 250, 27)];
   //localLabel.backgroundColor = [UIColor clearColor];
   //localLabel.font            = [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0];
   //localLabel.textAlignment   = UITextAlignmentLeft;
   //localLabel.text            = @"Edit Custom Answers:";
   //[self.view addSubview:localLabel];
   //[localLabel release];
   
   // add done button
   localButton                 = [UIButton buttonWithType:UIButtonTypeCustom];
   localButton.frame           = CGRectMake((320-74)/2, 460-59, 74, 49);
   localButton.backgroundColor = [UIColor clearColor];
   [localButton setTitle:@"done" forState:UIControlStateNormal];
   [localButton setBackgroundImage:[UIImage imageNamed:@"Button.png"]       forState:UIControlStateNormal];
   [localButton setBackgroundImage:[UIImage imageNamed:@"ButtonPushed.png"] forState:UIControlStateHighlighted];
   [localButton addTarget:delegate action:@selector(showBoardView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];
   
   [pool release];
   
   return;
}


/*
 If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad {
}
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[super dealloc];
}


- (void) openDeveloper:(id)sender
{
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.bindlebinaries.net/"]];
   return;
}


- (void) updateShakePref:(id)sender
{
   if (self.shakeSwitch.on)
   {
      self.flipSwitch.on = NO;
      [self.defaults setObject:@"YES" forKey:@"shake"];
      [self.defaults setObject:@"NO"  forKey:@"flip"];
   } else {
      self.flipSwitch.on = YES;
      [self.defaults setObject:@"NO"  forKey:@"shake"];
      [self.defaults setObject:@"YES" forKey:@"flip"];
   };
   [self.defaults synchronize];
   return;
}


- (void) updateFlipPref:(id)sender
{
   if (self.flipSwitch.on)
   {
      self.shakeSwitch.on = NO;
      [self.defaults setObject:@"NO"  forKey:@"shake"];
      [self.defaults setObject:@"YES" forKey:@"flip"];
   } else {
      self.shakeSwitch.on = YES;
      [self.defaults setObject:@"YES" forKey:@"shake"];
      [self.defaults setObject:@"NO"  forKey:@"flip"];
   };
   [self.defaults synchronize];
   return;
}


- (void) updateVibratePref:(id)sender
{
   if (self.vibrateSwitch.on)
      [self.defaults setObject:@"YES" forKey:@"vibrate"];
   else
      [self.defaults setObject:@"NO"  forKey:@"vibrate"];
   [self.defaults synchronize];
   return;
}


- (void) updateSoundPref:(id)sender
{
   if (self.soundSwitch.on)
      [self.defaults setObject:@"YES" forKey:@"sound"];
   else
      [self.defaults setObject:@"NO"  forKey:@"sound"];
   [self.defaults synchronize];
printf("got here\n");
   return;
}


@end
