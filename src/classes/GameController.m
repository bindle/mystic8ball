//
//  MagicController.m
//  magic8ball
//
//  Created by David Syzdek on 7/27/08.
//  Copyright 2008 David M. Syzdek. All rights reserved.
//

#import "GameController.h"
#import <AudioToolbox/AudioToolbox.h>

// Constant for the number of times per second (Hertz) to sample acceleration.
#define kAccelerometerFrequency     10//40



@implementation GameController

@synthesize hasFliped;
@synthesize x;
@synthesize y;
@synthesize z;
@synthesize oldX;
@synthesize oldY;
@synthesize oldZ;
@synthesize delegate;
@synthesize message;
@synthesize forceDataX;
@synthesize forceDataY;
@synthesize forceDataZ;
@synthesize hideImage;
@synthesize revealImage;
@synthesize centerImageView;
@synthesize defaults;


// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   CGRect              frame;
   UIView            * localView;
   UILabel           * localLabel;
   UIButton          * localButton;
   UIImageView       * localImageView;
   NSString          * path;
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];

   path = [[NSBundle mainBundle] pathForResource:@"chimes" ofType:@"wav"];
   AudioServicesCreateSystemSoundID((CFURLRef)[NSURL fileURLWithPath:path], &chimes);

   // load view
   localView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
   self.view = localView;
   [localView release];
   
   // loads image view
   frame                      = CGRectMake(10.0, 90.0, 300, 300);
   localImageView             = [[UIImageView alloc] initWithFrame:frame];
   localImageView.image       = self.hideImage;
   self.centerImageView       = localImageView;
   [localImageView release];
   [self.view addSubview:self.centerImageView];
   
   // loads label
   frame                      = CGRectMake(117.0, 165.0, 130.0, 123.0);
   localLabel                 = [[UILabel alloc] initWithFrame:frame];
   localLabel.textColor       = [UIColor whiteColor];
   localLabel.textAlignment   = UITextAlignmentCenter;
   localLabel.backgroundColor = [UIColor clearColor];
   localLabel.lineBreakMode   = UILineBreakModeWordWrap;
   localLabel.numberOfLines   = 3;
   self.message               = localLabel;
   [localLabel release];
   [self.view addSubview:self.message];
   
   // Add 'i' button
   localButton       = [UIButton buttonWithType:UIButtonTypeInfoLight];
   localButton.frame = CGRectMake(320-40, 460-40, 40, 40);
   [localButton addTarget:delegate action:@selector(showSettingsView:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:localButton];
   
#ifdef DEBUG
   frame           = CGRectMake(20.0, 20.0, 280.0, 22.0);
   localLabel      = [[UILabel alloc] initWithFrame:frame];
   localLabel.font = [UIFont systemFontOfSize:17];
   localLabel.backgroundColor = [UIColor clearColor];
   self.forceDataX = localLabel;
   [localLabel release];
   [self.view addSubview:self.forceDataX];
   
   frame           = CGRectMake(20.0, 39.0, 280.0, 22.0);
   localLabel      = [[UILabel alloc] initWithFrame:frame];
   localLabel.font = [UIFont systemFontOfSize:17];
   localLabel.backgroundColor = [UIColor clearColor];
   self.forceDataY = localLabel;
   [localLabel release];
   [self.view addSubview:self.forceDataY];
   
   frame           = CGRectMake(20.0, 60.0, 280.0, 22.0);
   localLabel      = [[UILabel alloc] initWithFrame:frame];
   localLabel.font = [UIFont systemFontOfSize:17];
   localLabel.backgroundColor = [UIColor clearColor];
   self.forceDataZ = localLabel;
   [localLabel release];
   [self.view addSubview:self.forceDataZ];
#endif

   self.oldX = 4;
   self.oldY = 4;
   self.oldZ = 4;
   
   [pool release];
   
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
   if ([self.defaults boolForKey:@"shake"])
      [self accelerometerShake:accelerometer didAccelerate:acceleration];
   else
      [self accelerometerFlip:accelerometer didAccelerate:acceleration];
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometerFlip:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];

   x = acceleration.x;
   y = acceleration.y;
   z = acceleration.z;
   
#ifdef DEBUG
   forceDataX.text = [NSString stringWithFormat:@"X: %+1.30f", x]];
   forceDataY.text = [NSString stringWithFormat:@"Y: %+1.30f", y]];
   forceDataZ.text = [NSString stringWithFormat:@"Z: %+1.30f", z]];
#endif

   if (z > 0.7)
   {
      hasFliped = YES;
      [message setText:@""];
      self.centerImageView.image = self.hideImage;
   };
   if ((z < 0.0) && (hasFliped))
   {
      hasFliped                  = NO;
      [self rollBall:nil];
   };
   
   [pool release];
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometerShake:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
   float               diffX;
   float               diffY;
   float               diffZ;
   NSAutoreleasePool * pool;

   // grabs current readings
   self.x = acceleration.x;
   self.y = acceleration.y;
   self.z = acceleration.z;
   
   // if this is the first reading, save state and exit
   if ((self.oldX > 3) || (self.oldY > 3) || (self.oldZ > 3))
   {
      self.oldX = self.x;
      self.oldY = self.y;
      self.oldZ = self.z;
      return;
   }
   
   diffX = fabsf(self.x - self.oldX);
   diffY = fabsf(self.y - self.oldY);
   diffZ = fabsf(self.z - self.oldZ);

   pool = [[NSAutoreleasePool alloc] init];
   
#ifdef DEBUG
   forceDataX.text = [NSString stringWithFormat:@"X: %+1.30f", diffX];
   forceDataY.text = [NSString stringWithFormat:@"Y: %+1.30f", diffY];
   forceDataZ.text = [NSString stringWithFormat:@"Z: %+1.30f", diffZ];
#endif

   //if (z > 0.3)
   //   [message setText:@""];
   if ((diffX > 1.0) || (diffY > 1.0) || (diffZ > 1.0))
   {
      self.hasFliped             = YES;
      self.message.text          = @"";
      self.centerImageView.image = self.hideImage;
   }
   else if (((diffX < 0.1) || (diffY < 0.1) || (diffZ < 0.1)) && (hasFliped))
   {
      hasFliped                  = NO;
      [self rollBall:nil];
   };
   
   self.oldX = self.x;
   self.oldY = self.y;
   self.oldZ = self.z;
   
   [pool release];
   
   return;
}


- (IBAction) rollBall:(NSString *)newMessage
{
   if ([self.defaults boolForKey:@"vibrate"])
      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
   if ([self.defaults boolForKey:@"sound"])
      AudioServicesPlaySystemSound(chimes);
   self.centerImageView.image = self.revealImage;
   if (newMessage)
      self.message.text = newMessage;
      
  return;
};



// If you need to do additional setup after loading the view, override viewDidLoad.
- (void)viewDidLoad
{
   [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
   [[UIAccelerometer sharedAccelerometer] setDelegate:self];
   return;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
   switch(interfaceOrientation)
   {
      case UIInterfaceOrientationPortrait:
      case UIInterfaceOrientationPortraitUpsideDown:
         return(YES);
      default:
         return(NO);
   };
	return (NO);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc
{
   self.message         = nil;
   self.forceDataX      = nil;
   self.forceDataY      = nil;
   self.forceDataZ      = nil;
   self.centerImageView = nil;
   AudioServicesDisposeSystemSoundID(chimes);
	[super dealloc];
}


@end
