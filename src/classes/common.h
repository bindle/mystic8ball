/*
 *  common.h
 *  magic8ball
 *
 *  Created by David Syzdek on 8/24/08.
 *  Copyright 2008 David M. Syzdek. All rights reserved.
 *
 */

#ifdef MAGICEIGHTBALL
#define MyControllerClass magic8ballController
#define PinchMediaCode @"026c0750b69d04afdbc7a51eacbb49ab"
#else LUCKYCHIP
#define MyControllerClass LuckyChipController
#define PinchMediaCode @"f05d096ef3bf9c257e6a3d80e272aea5"
#endif