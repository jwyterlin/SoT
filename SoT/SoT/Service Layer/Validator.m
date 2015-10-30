//
//  Validator.m
//  SoT
//
//  Created by Jhonathan Wyterlin on 30/10/15.
//  Copyright © 2015 Jhonathan Wyterlin. All rights reserved.
//

#import "Validator.h"

@implementation Validator

+(BOOL)validateObject:(id)object {
    
    if ( object == nil )
        return NO;
    
    if ( [object isEqual:[NSNull null]] )
        return NO;
    
    if ( [object isKindOfClass:[NSString class]] )
        if ( [object isEqualToString:@"<null>"] )
            return NO;
    
    return YES;
    
}


@end
