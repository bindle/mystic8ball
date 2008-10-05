//
//  MagicController.h
//  magic8ball
//
//  Created by David Syzdek on 7/27/08.
//  Copyright 2008 David M. Syzdek. All rights reserved.
//

#import "common.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class AppDelegate;

@interface GameController : UIViewController <UIAccelerometerDelegate>
{
   id               delegate;
   BOOL             hasFliped;
   float            x;
   float            y;
   float            z;
   float            oldX;
   float            oldY;
   float            oldZ;
   UILabel        * message;
   UILabel        * forceDataX;
   UILabel        * forceDataY;
   UILabel        * forceDataZ;
   UIImage        * hideImage;
   UIImage        * revealImage;
   UIImageView    * centerImageView;
   NSUserDefaults * defaults;
   SystemSoundID    chimes;
}

@property(assign, readwrite) BOOL          hasFliped;
@property(assign, readwrite) float         x;
@property(assign, readwrite) float         y;
@property(assign, readwrite) float         z;
@property(assign, readwrite) float         oldX;
@property(assign, readwrite) float         oldY;
@property(assign, readwrite) float         oldZ;
@property(nonatomic, retain) id            delegate;
@property(nonatomic, retain) UILabel     * message;
@property(nonatomic, retain) UILabel     * forceDataX;
@property(nonatomic, retain) UILabel     * forceDataY;
@property(nonatomic, retain) UILabel     * forceDataZ;
@property(nonatomic, retain) UIImage     * hideImage;
@property(nonatomic, retain) UIImage     * revealImage;
@property(nonatomic, retain) UIImageView * centerImageView;
@property(nonatomic, retain) NSUserDefaults * defaults;

- (void) rollBall:(NSString *)newMessage;
- (void)accelerometerFlip:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;
- (void)accelerometerShake:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration;


@end
