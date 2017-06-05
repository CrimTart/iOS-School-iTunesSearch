//
//  AppDelegate.m
//  iTunesSearch
//
//  Created by Admin on 22.05.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    ViewController *mainVC=[[ViewController alloc] init];
    
    window.rootViewController = mainVC;
    
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
