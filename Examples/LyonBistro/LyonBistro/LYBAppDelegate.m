//
//  LYBAppDelegate.m
//  LyonBistro
//
//  Created by Nicolas BACHSCHMIDT on 10/10/2013.
//  Copyright (c) 2013 CocoaHeads Lyon. All rights reserved.
//

#import "LYBAppDelegate.h"
#import "LYBSearchViewController.h"

@implementation LYBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[LYBSearchViewController new]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
