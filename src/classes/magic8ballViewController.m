//
//  magic8ballAppDelegate.m
//  magic8ball
//
//  Created by David Syzdek on 7/6/08.
//  Copyright David M. Syzdek 2008. All rights reserved.
//

#import "magic8ballViewController.h"

// Constant for the number of times per second (Hertz) to sample acceleration.
#define kAccelerometerFrequency     10//40
// Constant for the number of times per second (Hertz) the graph will be redrawn.
#define kUpdateFrequency            1//15

@implementation magic8ballViewController

@synthesize hasFliped;
@synthesize oldX;
@synthesize oldY;
@synthesize oldZ;
@synthesize x;
@synthesize y;
@synthesize z;

- (IBAction) rollBall:(id)sender
{
   NSAutoreleasePool * pool;
   NSArray * data;
   int num;
   
   pool = [[NSAutoreleasePool alloc] init];
   AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
   //sleep(1);
   switch((random() % 2500))
   {
      case 0:
         [message setText:@"Just flip a coin!"];
         [pool release];
         return;
      case 1:
         [message setText:@"Dude... I'm getting dizzy."];
         [pool release];
         return;
      case 2:
         [message setText:@"Just decide already!!"];
         [pool release];
         return;
      case 3:
         [message setText:@"Do I look fat?"];
         [pool release];
         return;
      case 4:
         [message setText:@"The answer is... Ooh Shiny!!"];
         [pool release];
         return;
      default:
         break;
   };
   data = [NSArray arrayWithObjects:@"1\n2\n3\n",
                                    @"As I see it, yes", 
                                    @"Ask again later", 
                                    @"Better not tell you now",
                                    @"Cannot predict now",
                                    @"Concentrate and ask again",
                                    @"Don't count on it", 
                                    @"It is certain",
                                    @"It is decidedly so",
                                    @"Most likely",
                                    @"My reply is no",
                                    @"My sources say no",
                                    @"Outlook good",
                                    @"Outlook not so good",
                                    @"Reply hazy, try again",
                                    @"Signs point to yes",
                                    @"Very doubtful",
                                    @"Without a doubt",
                                    @"Yes",
                                    @"Yes - definitely",
                                    @"You may rely on it",
                                    nil];
   num = random() % [data count];
   [message setText:[data objectAtIndex:0]];
   
   [pool release];
   return;
}


// UIAccelerometerDelegate method, called when the device accelerates.
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
   NSAutoreleasePool * pool;
   
   // grabs current readings
   self.x = acceleration.x;
   self.y = acceleration.y;
   self.z = acceleration.z;
   
   // if this is the first reading, save state and exit
   if ((self.oldX > 1) || (self.oldY > 1) || (self.oldZ > 1))
   {
      self.oldX = self.x;
      self.oldY = self.y;
      self.oldY = self.z;
      return;
   }
   
   pool = [[NSAutoreleasePool alloc] init];
#ifdef DEBUG
   forceDataX.text = [NSString stringWithFormat:@"X: %+1.30f", self.x - self.oldX];
   forceDataY.text = [NSString stringWithFormat:@"Y: %+1.30f", self.y - self.oldY];
   forceDataZ.text = [NSString stringWithFormat:@"Z: %+1.30f", self.z - self.oldZ];
#endif

   //if (z > 0.3)
   //   [message setText:@""];
   if (z > 0.7)
   {
      hasFliped        = YES;
      message.text     = @"";
      ballObject.image = ballImageFull;
   };
   if ((z < 0.0) && (hasFliped))
   {
      hasFliped        = NO;
      ballObject.image = ballImage;
      [self rollBall:self];
   };
   
   self.oldX = self.x;
   self.oldY = self.y;
   self.oldY = self.z;
   
   [pool release];
   return;
}


/*
 *  Implement viewDidLoad if you need to do additional setup after loading the view.
 */
- (void)viewDidLoad
{
   NSAutoreleasePool * pool;
   NSString * imageFile;
   
   hasFliped = NO;

   srandomdev();
   
	[super viewDidLoad];
   pool = [[NSAutoreleasePool alloc] init];
   imageFile     = [[NSBundle mainBundle] pathForResource:@"8ball" ofType:@"png"];
   ballImage     = [[UIImage alloc] initWithContentsOfFile:imageFile];
   imageFile     = [[NSBundle mainBundle] pathForResource:@"8ballCenter" ofType:@"png"];
   ballImageFull = [[UIImage alloc] initWithContentsOfFile:imageFile];
   //[self rollBall:self];
   [pool release];

   self.oldX = 2;
   self.oldY = 2;
   self.oldZ = 2;

   [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / kAccelerometerFrequency)];
   [[UIAccelerometer sharedAccelerometer] setDelegate:self];
   return;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
   [ballImage release];
	[ballImageFull release];
   [super dealloc];
}

@end
