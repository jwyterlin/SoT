//
//  GenericView.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericView.h"

@implementation GenericView

-(id)init {
    
    self = [super init];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
    
}

-(void)setup {}

@end