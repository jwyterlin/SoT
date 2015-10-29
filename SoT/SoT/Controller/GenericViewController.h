//
//  GenericViewController.h
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Custom UI Components
#import "CATransformLayer+Helper.h"

// Service Layer
#import "DeviceInfo.h"

@interface GenericViewController : UIViewController

-(void)registerObserversForKeyboard;
-(void)animateTextField:(UITextField *)textField up:(BOOL)up;

@end
