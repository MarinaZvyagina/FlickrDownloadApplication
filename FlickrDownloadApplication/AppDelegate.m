//
//  AppDelegate.m
//  FlickrDownloadApplication
//
//  Created by Марина Звягина on 31.05.17.
//  Copyright © 2017 Zvyagina Marina. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FDAFlickrDataBase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   // [FDAFlickrDataBase getPictures:@"cat"];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    ViewController *mainVC=[[ViewController alloc] initWithPicturesManager:[FDAFlickrDataBase new]];
    
    window.rootViewController = mainVC;
    
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
