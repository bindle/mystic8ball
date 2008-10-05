//
//  LuckyPokerChipController.m
//  magic8ball
//
//  Created by David Syzdek on 7/27/08.
//  Copyright 2008 David M. Syzdek. All rights reserved.
//

#import "LuckyChipController.h"


@implementation LuckyChipController

// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   CGRect              frame;
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];
   
   self.hideImage             = [UIImage imageNamed:@"LuckyPokerChipCenter.png"];
   self.revealImage           = [UIImage imageNamed:@"LuckyPokerChip.png"];

   [super loadView];
   
   frame                      = CGRectMake(15.0, 90.0, 300, 300);
   self.centerImageView.frame = frame;
   
   frame                      = CGRectMake(65, 160, 200.0, 150.0);
   self.message.font          = [UIFont systemFontOfSize:24];
   self.message.textColor     = [UIColor colorWithRed:(244.0/256.0) green:(214.0/256.0) blue:(94.0/256.0) alpha:1.0];
   self.message.frame         = frame;
   
   frame                      = CGRectMake(65, 160, 200.0, 150.0);
   self.message.font          = [UIFont fontWithName:@"Arial-BoldMT" size:28];
   //self.message.font          = [UIFont systemFontOfSize:40];
   self.message.textColor     = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
   self.message.frame         = frame;
   
   [pool release];
   
   //[self rollBall:nil];
   
   return;
}


- (IBAction) rollBall:(NSString *)newMessage
{
   NSAutoreleasePool * pool;
   NSArray * data;
   int num;
   
   // show easter eggs every 500 rolls
   switch((random() % 2500))
   {
      case 0:
         [super rollBall:@"Just flip\na coin!"];
         return;
      case 1:
         [super rollBall:@"Dude...\nI'm getting\ndizzy."];
         return;
      case 2:
         [super rollBall:@"Just decide already!!"];
         return;
      case 3:
         [super rollBall:@"Do I look fat?"];
         return;
      case 4:
         [super rollBall:@"The answer\nis...\nOoh Shiny!!"];
         return;
      default:
         break;
   };

   pool = [[NSAutoreleasePool alloc] init];
   if ((random() % 5) == 1)
      data  = [NSArray arrayWithObjects:@"Take a\nWalk",
                                        @"Tilt",
                                        @"Gamble",
                                        @"All In!",
                                        @"LIMP",
                                        @"Straddle",
                                        nil];
   else
      data = [NSArray arrayWithObjects:@"Bet", 
                                       @"Raise", 
                                       @"Fold",
                                       @"Call",
                                       @"Check",
                                       @"Check\nRaise", 
                                       nil];
   num = random() % [data count];
   [super rollBall:[data objectAtIndex:num]];
   
   [pool release];
      
  return;
};



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



@end
