//
//  magic8ballController.m
//  magic8ball
//
//  Created by David Syzdek on 7/27/08.
//  Copyright 2008 David M. Syzdek. All rights reserved.
//

#import "magic8ballController.h"


@implementation magic8ballController


// Implement loadView if you want to create a view hierarchy programmatically
- (void)loadView
{
   NSAutoreleasePool * pool;
   
   pool = [[NSAutoreleasePool alloc] init];
   
   self.hideImage             = [UIImage imageNamed:@"8ballCenter.png"];
   self.revealImage           = [UIImage imageNamed:@"8ball.png"];

   [super loadView];
   
   [pool release];
   
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
         [super rollBall:@"Just flip a coin!"];
         return;
      case 1:
         [super rollBall:@"Dude... I'm getting dizzy."];
         return;
      case 2:
         [super rollBall:@"Just decide already!!"];
         return;
      case 3:
         [super rollBall:@"Do I look fat?"];
         return;
      case 4:
         [super rollBall:@"The answer is... Ooh Shiny!!"];
         return;
      default:
         break;
   };

   pool = [[NSAutoreleasePool alloc] init];
   data = [NSArray arrayWithObjects:@"As I see it,\nyes", 
                                    @"Ask again\nlater", 
                                    @"Better not\ntell you\nnow",
                                    @"Cannot\npredict\nnow",
                                    @"Concentrate\nand ask\nagain",
                                    @"Don't count\non it", 
                                    @"It is\ncertain",
                                    @"It is\ndecidedly\nso",
                                    @"Most\nlikely",
                                    @"My reply\nis no",
                                    @"My sources\nsay no",
                                    @"Outlook\ngood",
                                    @"Outlook not\nso good",
                                    @"Reply hazy,\ntry\nagain",
                                    @"Signs point\nto yes",
                                    @"Very\ndoubtful",
                                    @"Without\na doubt",
                                    @"Yes",
                                    @"Yes -\ndefinitely",
                                    @"You may\nrely on\nit",
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
