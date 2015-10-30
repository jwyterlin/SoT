//
//  GenericTextField.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericTextField.h"

@implementation GenericTextField

-(id)init {
    
    self = [super init];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
    
}

-(void)setup {
    
    self.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:[DeviceInfo isIpad]?64.0f:48.0f];
    
}

@end
