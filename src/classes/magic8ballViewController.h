//
//  magic8ballViewController.h
//  magic8ball
//
//  Created by David Syzdek on 7/6/08.
//  Copyright David M. Syzdek 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface magic8ballViewController : UIViewController <UIAccelerometerDelegate>
{
   IBOutlet UILabel * message;
   IBOutlet UILabel * forceDataX;
   IBOutlet UILabel * forceDataY;
   IBOutlet UILabel * forceDataZ;
   IBOutlet UIImageView * ballObject;
   UIImage * ballImage;
   UIImage * ballImageFull;
   BOOL  hasFliped;
   float oldX;
   float oldY;
   float oldZ;
   float x;
   float y;
   float z;
}

@property(assign, readwrite) BOOL hasFliped;
@property(assign, readwrite) float oldX;
@property(assign, readwrite) float oldY;
@property(assign, readwrite) float oldZ;
@property(assign, readwrite) float x;
@property(assign, readwrite) float y;
@property(assign, readwrite) float z;

- (IBAction) rollBall:(id)sender; 

@end

