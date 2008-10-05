//
//  magic8ballAppDelegate.h
//  magic8ball
//
//  Created by David Syzdek on 7/6/08.
//  Copyright David M. Syzdek 2008. All rights reserved.
//

#import "common.h"
#import <UIKit/UIKit.h>

@class SettingsController;

@interface AppDelegate : NSObject <UIApplicationDelegate>
{
	IBOutlet UIWindow  * window;
   UIViewController   * board;
   UIViewController   * settings;
   NSUserDefaults     * defaults;
}

@property (nonatomic, retain) UIWindow           * window;
@property (nonatomic, retain) UIViewController   * board;
@property (nonatomic, retain) UIViewController   * settings;
@property (nonatomic, retain) NSUserDefaults     * defaults;

- (void) showBoardView:(id)sender;
- (void) showSettingsView:(id)sender;

@end

