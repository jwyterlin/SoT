//
//  GenericButton.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 28/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "GenericButton.h"

@implementation GenericButton

-(id)init {
    
    self = [super init];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
    
}

-(void)setup {
    
    self.titleLabel.font = [UIFont systemFontOfSize:17.0];
    self.titleLabel.textColor = [UIColor colorWithRed:104.0/256.0 green:104.0/256.0 blue:113.0/256.0 alpha:1.0];
    
}

@end
