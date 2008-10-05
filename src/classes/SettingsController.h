//
//  SettingsController.h
//  magic8ball
//
//  Created by David Syzdek on 8/24/08.
//  Copyright 2008 David M. Syzdek. All rights reserved.
//

#import "common.h"
#import <UIKit/UIKit.h>


@interface SettingsController : UIViewController
{
   id               delegate;
   UISwitch       * shakeSwitch;
   UISwitch       * flipSwitch;
   UISwitch       * vibrateSwitch;
   UISwitch       * soundSwitch;
   NSUserDefaults * defaults;
}

@property(nonatomic, retain) id               delegate; 
@property(nonatomic, retain) UISwitch       * shakeSwitch; 
@property(nonatomic, retain) UISwitch       * flipSwitch; 
@property(nonatomic, retain) UISwitch       * vibrateSwitch; 
@property(nonatomic, retain) UISwitch       * soundSwitch; 
@property(nonatomic, retain) NSUserDefaults * defaults;

- (void) openDeveloper:(id)sender;

- (void) updateShakePref:(id)sender;
- (void) updateFlipPref:(id)sender;
- (void) updateVibratePref:(id)sender;
- (void) updateSoundPref:(id)sender;

@end
