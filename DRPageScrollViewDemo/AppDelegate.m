//
//  AppDelegate.m
//  DRPageScrollViewDemo
//
//  Created by David Román Aguirre on 3/4/15.
//  Copyright (c) 2015 David Román Aguirre. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.window.backgroundColor = [UIColor whiteColor];
	self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
	
	[self.window makeKeyAndVisible];
	
	return YES;
}

@end
