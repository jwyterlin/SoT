//
//  DeviceInfo.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "DeviceInfo.h"

@implementation DeviceInfo

+(CGFloat)height {
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    NSLog( @"screenBounds.size.height: %.2f", screenBounds.size.height );
    return screenBounds.size.height;
    
}

+(CGFloat)width {
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    NSLog( @"screenBounds.size.width: %.2f", screenBounds.size.width );
    return screenBounds.size.width;
    
}

+(BOOL)isIpad {
    return ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad );
}

+(BOOL)isIphone {
    return ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone );
}

@end
