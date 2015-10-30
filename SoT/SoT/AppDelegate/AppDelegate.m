//
//  AppDelegate.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 25/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@interface AppDelegate()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupTwitter];
    
    return YES;
    
}

-(void)setupTwitter {
    
    [Fabric with:@[[Twitter class]]];
    [[Twitter sharedInstance] startWithConsumerKey:@"JYXmxm7dswYaaZuAek1Ny9GQS" consumerSecret:@"7oVb1pI8fwKrawv7sJCv5rB7ykfVlzED0OIMQ3c1N78O69J01Q"];
    [Fabric with:@[[Twitter sharedInstance]]];
    
}

@end
