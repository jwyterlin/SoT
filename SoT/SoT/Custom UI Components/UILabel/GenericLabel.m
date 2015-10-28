//
//  GenericLabel.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericLabel.h"

@implementation GenericLabel

-(id)init {
    
    self = [super init];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
    
}

-(void)setup {
    
    self.textColor = [UIColor colorWithRed:94.0/256.0 green:159.0/256.0 blue:202.0/256.0 alpha:1.0];
    self.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:24.0];
    
}

@end
